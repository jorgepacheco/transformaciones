package com.mpr.pruebas.transformaciones;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.Map;

import javax.activation.DataHandler;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.xml.serialize.DOMSerializer;
import org.apache.xml.serialize.Method;
import org.apache.xml.serialize.OutputFormat;
import org.apache.xml.serialize.SerializerFactory;
import org.apache.xml.serialize.XMLSerializer;
import org.w3c.dom.CDATASection;
import org.w3c.dom.CharacterData;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.Text;
import org.xml.sax.EntityResolver;
import org.xml.sax.ErrorHandler;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;



/**
 * Clase que reune metodos utiles para trabajar con Documentos XML.
 * 
 * @author MartinE
 * @author AMORGAN
 */
@SuppressWarnings("rawtypes")
public abstract class DOMUtils{
	/**
	 * Constante para el chaset UTF-8
	 */
	public static final String CTE_CHARSET_UTF_8 = "UTF-8";
	/**
	 * Constante para el chaset ISO-8859-1
	 */
	public static final String CTE_CHARSET_ISO_8859_1 = "ISO-8859-1";
	private static final Log log = LogFactory.getLog(DOMUtils.class);
	private static DocumentBuilderFactory dbf = getDOMFactory();
	private static ByteArrayInputStream bais = new ByteArrayInputStream("".getBytes());

	/**
	 * Metodo que devuelve un String formateado que representa un Documento XML
	 * 
	 * @param doc
	 * @return
	 */
	public static String prettyDocumentToString(final Document doc){
		Element element = doc.getDocumentElement();
		OutputFormat of = new OutputFormat();
		of.setIndenting(true);
		of.setOmitXMLDeclaration(true);
		StringWriter sw = new StringWriter();
		try{
			DOMSerializer ser = SerializerFactory.getSerializerFactory(Method.XML).makeSerializer(sw,of).asDOMSerializer();
			ser.serialize(element);
		}catch(IOException e){
			log.debug("Fallo formateando XML",e);
			return null;
		}
		return sw.toString();
	}

	/**
	 * Metodo que devuelve un String formateado que representa un Nodo XML
	 * 
	 * @param element
	 * @return
	 */
	public static String prettyElementToString(final Element element){
		OutputFormat of = new OutputFormat();
		of.setIndenting(true);
		of.setOmitXMLDeclaration(true);
		StringWriter sw = new StringWriter();
		try{
			DOMSerializer ser = SerializerFactory.getSerializerFactory(Method.XML).makeSerializer(sw,of).asDOMSerializer();
			ser.serialize(element);
		}catch(IOException e){
			log.debug("Fallo formateando XML",e);
			return null;
		}
		return sw.toString();
	}

	/**
	 * Metodo que devuelve el String de un Documento XML
	 * 
	 * @param doc
	 * @return
	 */
	public static String documentToString(final Document doc){
		return DOMUtils.documentToString(doc,null);
	}

	/**
	 * Metodo que devuelve el String de un Documento XML utilizando el encoding indicado.
	 * 
	 * @param doc
	 * @param encoding Encoding a utilizar.
	 * @return
	 */
	public static String documentToString(final Document doc,final String encoding){
		String _encoding = encoding != null ? encoding : detectEncoding(doc);
		StringWriter sw = new StringWriter();
		try{
			OutputFormat format = new OutputFormat(doc);
			format.setEncoding(_encoding);
			XMLSerializer output = new XMLSerializer(sw,format);
			output.serialize(doc);
		}catch(IOException e){
			System.err.println(e);
		}
		return sw.toString();
		// FIXME: Eliminar dependencias Axis
		// return XMLUtils.DocumentToString(doc);
		// return privateElementToString(doc.getDocumentElement(), false);
	}

	/**
	 * Metodo que devuelve el encoding de un Documento XML.
	 * 
	 * @param doc
	 * @return Encoding del documento o UTF-8 si no lo encuentra
	 */
	public static String detectEncoding(final Document doc){
		String encoding = doc.getXmlEncoding();
		if(encoding == null){
			encoding = doc.getInputEncoding();
		}
		if(encoding == null){
			encoding = CTE_CHARSET_UTF_8;
		}
		return encoding;
	}



	/**
	 * Metodo que devuelve un Documento XML a partir de una representacion en String
	 * 
	 * @param xml
	 * @return
	 * @throws javax.xml.parsers.ParserConfigurationException
	 * @throws org.xml.sax.SAXException
	 * @throws java.io.IOException
	 */
	public static Document stringToDocument(final String xml) throws ParserConfigurationException,SAXException,
				IOException{
		return createDocument(xml);
	}

	/**
	 * Metodo que devuelve un Documento XML a partir de una representacion en String
	 * 
	 * @param xml
	 * @param encoding
	 * @return
	 * @throws javax.xml.parsers.ParserConfigurationException
	 * @throws org.xml.sax.SAXException
	 * @throws java.io.IOException
	 */
	public static Document stringToDocument(final String xml,final String encoding) throws ParserConfigurationException,
				SAXException,IOException{
		String _encoding = (encoding != null) ? encoding : CTE_CHARSET_UTF_8;
		// FIXME: Eliminar dependencias Axis
		// return XMLUtils.newDocument(new ByteArrayInputStream(xml.getBytes(_encoding)));
		return newDocument(new ByteArrayInputStream(xml.getBytes(_encoding)));
	}

	/**
	 * Metodo para copiar de un nodo a otro (de un Documento diferente).
	 * 
	 * @param source. Nodo origen
	 * @param dest. Nodo destino
	 * @return
	 */
	public static synchronized Node copyNode(final Node source,final Node dest){
		if(source.getNodeType() == Node.TEXT_NODE){
			Text tn = dest.getOwnerDocument().createTextNode(source.getNodeValue());
			return tn;
		}else{
			Node attr = null;
			NamedNodeMap attrs = source.getAttributes();
			if(attrs != null){
				for(int i = 0;i < attrs.getLength();i++){
					attr = attrs.item(i);
					((Element)dest).setAttributeNS(null,attr.getNodeName(),attr.getNodeValue());
				}
			}
			Node child = null;
			NodeList list = source.getChildNodes();
			for(int i = 0;i < list.getLength();i++){
				child = list.item(i);
				if(!(child instanceof Text)){
					Element en = dest.getOwnerDocument().createElementNS(child.getNamespaceURI(),child.getNodeName());
					if(child.getNodeValue() != null){
						en.setNodeValue(child.getNodeValue());
					}
					Node n = copyNode(child,en);
					dest.appendChild(n);
				}else if(child instanceof CDATASection){
					CDATASection cd = dest.getOwnerDocument().createCDATASection(child.getNodeValue());
					dest.appendChild(cd);
				}else{
					Text tn = dest.getOwnerDocument().createTextNode(child.getNodeValue());
					dest.appendChild(tn);
				}
			}
		}
		return dest;
	}

	/**
	 * Metodo para obtener el valor de un nodo identificado por su TagName y su namespace
	 * 
	 * @param doc. Documento XML donde buscar
	 * @param tagName. TagName que buscar
	 * @param ns. Namespace del TagName que buscar
	 * @return Valor del nodo
	 */
	public static String getSimpleValue(final Document doc,final String tagName,final String ns){
		Element elNode = findElement(doc,tagName,ns);
		if(elNode == null)
			return null;
		else if(elNode.getFirstChild() != null)
			return elNode.getFirstChild().getNodeValue();
		return "";
	}

	/**
	 * Metodo para obtener el valor de un nodo identificado por su TagName y su namespace
	 * 
	 * @param elto. Nodo XML donde buscar
	 * @param tagName. TagName que buscar
	 * @param ns. Namespace del TagName que buscar
	 * @return Valor del nodo
	 */
	public static String getSimpleValue(final Element elto,final String tagName,final String ns){
		Element elNode = findElement(elto,tagName,ns);
		if(elNode == null)
			return null;
		else if(elNode.getFirstChild() != null)
			return elNode.getFirstChild().getNodeValue();
		return "";
	}

	/**
	 * Metodo para obtener el valor de un nodo identificado
	 * 
	 * @param elto. Nodo XML donde buscar
	 * @return Valor del nodo
	 */
	public static String getSimpleValue(final Element element){
		if(element == null)
			return null;
		else if(element.getFirstChild() != null)
			return element.getFirstChild().getNodeValue();
		return "";
	}

	/**
	 * Metodo para establecer el valor de un nodo identificado por su TagName y su mamespace
	 * 
	 * @param doc. Documento XML donde buscar
	 * @param tagName. TagName que buscar
	 * @param ns. Namespace del TagName que buscar
	 * @param value. Valor del nodo
	 */
	public static void setSimpleValue(final Document doc,final String tagName,final String ns,final String value){
		Element elNode = findElement(doc,tagName,ns);
		if(elNode != null)
			elNode.setTextContent(value);
	}

	/**
	 * Metodo para establecer el valor de un nodo identificado por su TagName y su mamespace
	 * 
	 * @param doc. Nodo XML donde settear el valor
	 * @param value. Valor del nodo
	 */
	public static void setSimpleValue(final Element element,final String value){
		if(element != null)
			element.setTextContent(value);
	}

	/**
	 * Metodo para obtener el valor del atributo "attName" de un nodo identificado por su TagName y su namespace
	 * 
	 * @param elto. Nodo XML donde buscar
	 * @param tagName. TagName que buscar
	 * @param attName. Nombre del atributo que recuperar
	 * @param ns. Namespace del TagName que buscar
	 * @return String con el valor del atributo
	 */
	public static String getSimpleAttributeValue(final Element elto,final String tagName,final String attName,
				final String ns){
		Element elNode = findElement(elto,tagName,ns);
		if(elNode == null)
			return null;
		return elNode.getAttribute(attName);
	}

	/**
	 * Metodo para obtener el valor del atributo "attName" de un nodo
	 * 
	 * @param elto. Nodo XML donde buscar el atributo
	 * @return String con el valor del atributo
	 */
	public static String getSimpleAttributeValue(final Element elto,final String attName){
		if(elto == null)
			return null;
		return elto.getAttribute(attName);
	}

	/**
	 * Metodo para buscar un Nodo segun su TagName y namespace
	 * 
	 * @param doc. Documento XML donde buscar
	 * @param tagName. TagName que buscar
	 * @param ns. Namespace del TagName que buscar
	 * @return El primer nodo que concuerde con la busqueda
	 */
	public static Node findNode(final Document doc,final String tagName,final String ns){
		NodeList nl = findNodeList(doc,tagName,ns);
		if(nl.getLength() > 0){
			return nl.item(0);
		}
		return null;
	}

	/**
	 * Metodo para buscar un Nodo segun su TagName y varios namespaces
	 * 
	 * @param doc. Documento XML donde buscar
	 * @param tagName. TagName que buscar
	 * @param namespaces. Array con los Namespaces del TagName que buscar
	 * @return El primer nodo que concuerde con la busqueda
	 */
	public static Node findNode(final Document doc,final String tagName,final String[] namespaces){
		Node node = null;
		for(String namespace:namespaces){
			node = DOMUtils.findNode(doc,tagName,namespace);
			if(node != null){
				return node;
			}
		}
		return node;
	}

	/**
	 * Metodo para buscar un Nodo segun su TagName y namespace
	 * 
	 * @param doc. Documento XML donde buscar
	 * @param tagName. TagName que buscar
	 * @param ns. Namespace del TagName que buscar
	 * @return El primer nodo que concuerde con la busqueda
	 */
	public static Element findElement(final Document doc,final String tagName,final String ns){
		return (Element)findNode(doc,tagName,ns);
	}

	/**
	 * Metodo para buscar un Nodo segun su TagName y varios namespaces
	 * 
	 * @param doc. Documento XML donde buscar
	 * @param tagName. TagName que buscar
	 * @param namespaces. Array con los Namespaces del TagName que buscar
	 * @return El primer nodo que concuerde con la busqueda
	 */
	public static Element findElement(final Document doc,final String tagName,final String[] namespaces){
		return (Element)findNode(doc,tagName,namespaces);
	}

	/**
	 * Metodo para buscar un Nodo segun su TagName y namespace
	 * 
	 * @param doc. Documento XML donde buscar
	 * @param tagName. TagName que buscar
	 * @param ns. Namespace del TagName que buscar
	 * @return La lista de nodos que concuerden con la busqueda
	 */
	public static NodeList findNodeList(final Document doc,final String tagName,final String ns){
		if(ns == null || "".equals(ns))
			return doc.getElementsByTagName(tagName);
		return doc.getElementsByTagNameNS(ns,tagName);
	}

	/**
	 * Metodo para buscar un Nodo segun su TagName y namespace
	 * 
	 * @param elto. Nodo donde buscar
	 * @param tagName. TagName que buscar
	 * @param ns. Namespace del TagName que buscar
	 * @return El primer nodo que concuerde con la busqueda
	 */
	public static Node findNode(final Element elto,final String tagName,final String ns){
		NodeList nl = findNodeList(elto,tagName,ns);
		if(nl.getLength() > 0){
			return nl.item(0);
		}
		return null;
	}

	/**
	 * Metodo para buscar un Nodo segun su TagName y varios namespaces
	 * 
	 * @param elto. Nodo donde buscar
	 * @param tagName. TagName que buscar
	 * @param namespaces. Array con los Namespaces del TagName que buscar
	 * @return El primer nodo que concuerde con la busqueda
	 */
	public static Node findNode(final Element elto,final String tagName,final String[] namespaces){
		Node node = null;
		for(String namespace:namespaces){
			node = DOMUtils.findNode(elto,tagName,namespace);
			if(node != null){
				return node;
			}
		}
		return node;
	}

	/**
	 * Metodo para buscar un Nodo segun su TagName y namespace
	 * 
	 * @param elto. Nodo donde buscar
	 * @param tagName. TagName que buscar
	 * @param ns. Namespace del TagName que buscar
	 * @return El primer nodo que concuerde con la busqueda
	 */
	public static Element findElement(final Element elto,final String tagName,final String ns){
		return (Element)findNode(elto,tagName,ns);
	}

	/**
	 * Metodo para buscar un Nodo segun su TagName y namespace
	 * 
	 * @param elto. Nodo donde buscar
	 * @param tagName. TagName que buscar
	 * @param namespaces. Array con los Namespaces del TagName que buscar
	 * @return El primer nodo que concuerde con la busqueda
	 */
	public static Element findElement(final Element elto,final String tagName,final String[] namespaces){
		return (Element)findNode(elto,tagName,namespaces);
	}

	/**
	 * Metodo para buscar una lista de nodos segun su TagName y namespace
	 * 
	 * @param elto. Nodo donde buscar
	 * @param tagName. TagName que buscar
	 * @param ns. Namespace del TagName que buscar
	 * @return La lista de nodos que concuerden con la busqueda
	 */
	public static NodeList findNodeList(final Element elto,final String tagName,final String ns){
		return elto.getElementsByTagNameNS(ns,tagName);
	}

	/**
	 * Metodo para copiar un Documento XML
	 * 
	 * @param doc
	 * @return
	 * @throws ParserConfigurationException
	 * @throws SAXException
	 * @throws IOException
	 * @deprecated Se recomienda utilizar el metodo {@link cloneDocument(Document doc)}
	 */
	@Deprecated
	public static Document copyDocument(final Document doc) throws ParserConfigurationException,SAXException,IOException{
		return stringToDocument(documentToString(doc),CTE_CHARSET_UTF_8);
	}


	/**
	 * Metodo para crear un nuevo Documento XML
	 * 
	 * @return
	 * @throws ParserConfigurationException
	 */
	public static Document createDocument() throws ParserConfigurationException{
		// FIXME: Eliminar dependencias Axis
		// Document document = XMLUtils.newDocument();
		Document document = newDocument();
		return document;
	}

	/**
	 * Metodo para crear un nuevo Documento XML desde un archivo
	 * 
	 * @param file
	 * @param encoding
	 * @return
	 * @throws IOException
	 * @throws ParserConfigurationException
	 * @throws SAXException
	 */
	public static Document createDocument(final File file,final String encoding) throws IOException,
				ParserConfigurationException,SAXException{
		Assert.notNull(file,"<file> no puede ser null");
		Assert.notNull(encoding,"<encoding> no puede ser null");
		String stringDocument = FileUtils.readFileToString(file,encoding);
		Document document = DOMUtils.stringToDocument(stringDocument,encoding);
		return document;
	}

	/**
	 * Metodo para crear un nuevo Documento XML desde una cadena
	 * 
	 * @param msg
	 * @return
	 * @throws IOException
	 * @throws SAXException
	 * @throws ParserConfigurationException
	 */
	public static Document createDocument(final String msg) throws ParserConfigurationException,SAXException,IOException{
		/*-
		 * Se utiliza un StringReader para evitar problemas de encoding al hacer 
		 * "msg.getBytes(encoding)" con un encoding que no se corresponde con el de la cadena.
		 */
		Assert.notNull(msg,"<msg> no puede ser null");
		StringReader reader = new StringReader(msg);
		return newDocument(reader);
	}

	/**
	 * Metodo para crear un nuevo Documento XML desde una cadena
	 * 
	 * @param msg
	 * @param encoding
	 * @return
	 * @throws IOException
	 * @throws SAXException
	 * @throws ParserConfigurationException
	 * @deprecated Este metodo funciona correctamente siempre y cuando el encoding se corresponda con el de la cadena
	 *             <code>envelopeString</code>.<br>
	 *             Si no se esta completamente seguro del encoding se recomienda utilizar el metodo {@link
	 *             createDocument(String msg)}
	 */
	@Deprecated
	public static Document createDocument(final String msg,final String encoding) throws ParserConfigurationException,
				SAXException,IOException{
		Assert.notNull(msg,"<msg> no puede ser null");
		Assert.notNull(encoding,"<encoding> no puede ser null");
		// FIXME: Eliminar dependencias Axis
		// return XMLUtils.newDocument(new ByteArrayInputStream(msg.getBytes(encoding)));
		return newDocument(new ByteArrayInputStream(msg.getBytes(encoding)));
	}

	/**
	 * Metodo para crear un nuevo Documento XML desde un <code>InputStream</code>
	 * 
	 * @param inputStream
	 * @return
	 * @throws ParserConfigurationException
	 * @throws SAXException
	 * @throws IOException
	 */
	public static Document createDocument(final InputStream inputStream) throws ParserConfigurationException,
				SAXException,IOException{
		Assert.notNull(inputStream,"<inputStream> no puede ser null");
		// FIXME: Eliminar dependencias Axis
		// return XMLUtils.newDocument(inputStream);
		return newDocument(inputStream);
	}

	/**
	 * Metodo para crear un nuevo Documento XML desde un <code>InputStream</code>
	 * 
	 * @param inputStream
	 * @return
	 * @throws ParserConfigurationException
	 * @throws SAXException
	 * @throws IOException
	 */
	public static Document createDocument(final Reader reader) throws ParserConfigurationException,SAXException,
				IOException{
		Assert.notNull(reader,"<reader> no puede ser null");
		// FIXME: Eliminar dependencias Axis
		// return XMLUtils.newDocument(inputStream);
		return newDocument(reader);
	}


	

	private static String buildRootXPathExpression(final Element el){
		if(el == null){
			return "";
		}
		Element elementParent = getElementParent(el);
		StringBuilder sbXPathExpression = new StringBuilder(buildRootXPathExpression(elementParent));
		sbXPathExpression.append("/*[local-name()='");
		sbXPathExpression.append(el.getLocalName());
		sbXPathExpression.append("']");
		return sbXPathExpression.toString();
	}

	/**
	 * Metodo para obtener el namespace principal de un Docuemnto XML
	 * 
	 * @param doc
	 * @return
	 */
	public static String getDocumentNamespace(final Document doc){
		return doc.getDocumentElement().getNamespaceURI();
	}



	/**
	 * Metodo para obtener el primer nodo de tipo Node.ELEMENT_NODE de un Element dado
	 * <p>
	 * Con este metodo evitamos coger nodos que representen "\n" o comentarios
	 * 
	 * @param element
	 * @return
	 */
	public static Element getContentElement(final Element element){
		NodeList childNodes = element.getChildNodes();
		int length = childNodes.getLength();
		Node child = null;
		for(int i = 0;i < length;i++){
			child = childNodes.item(i);
			if(child.getNodeType() == Node.ELEMENT_NODE){
				return (Element)child;
			}
		}
		return null;
	}

	/**
	 * Metodo para obtener el primer nodo padre de tipo Node.ELEMENT_NODE de un Element dado
	 * <p>
	 * Con este metodo evitamos coger nodos que representen "\n" o comentarios
	 * 
	 * @param element
	 * @return
	 */
	public static Element getElementParent(final Element element){
		Node parent = element.getParentNode();
		if(Node.ELEMENT_NODE == parent.getNodeType()){
			return (Element)parent;
		}else if(Node.DOCUMENT_NODE == parent.getNodeType()){
			return null;
		}
		return getElementParent((Element)parent);
	}



	/**
	 * Metodo para cargar un Schema desde un archivo especificado
	 * 
	 * @param file
	 * @return
	 */
	public static Schema loadSchema(final File file){
		Schema schema = null;
		SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
		try{
			schema = sf.newSchema(file);
		}catch(SAXException e){
			log.error("Fallo cargando el SCHEMA",e);
		}
		return schema;
	}

	/**
	 * Metodo para incializar el objeto DocumentBuilderFactory
	 * 
	 * @return
	 */
	private static DocumentBuilderFactory getDOMFactory(){
		DocumentBuilderFactory dbf;
		try{
			dbf = DocumentBuilderFactory.newInstance();
			dbf.setNamespaceAware(true);
		}catch(Exception e){
			// log.error(Messages.getMessage("exception00"), e );
			dbf = null;
		}
		return(dbf);
	}

	/**
	 * Metodo que crea un nuevo Document vacio
	 * 
	 * @return Returns Document.
	 * @throws ParserConfigurationException si durante la construccion ocurre algun problema
	 */
	private static Document newDocument() throws ParserConfigurationException{
		synchronized(dbf){
			return dbf.newDocumentBuilder().newDocument();
		}
	}

	/**
	 * Metodo que crea un nuevo Document a traves de un InputSource
	 * 
	 * @return Returns Document.
	 * @throws ParserConfigurationException si durante la construccion sucede algun problema
	 * @throws SAXException si el document xml tiene problemas sax
	 * @throws IOException si ocurre una expecion de entrada/salida
	 */
	private static Document newDocument(final InputSource inp) throws ParserConfigurationException,SAXException,
				IOException{
		DocumentBuilder db;
		synchronized(dbf){
			try{
				db = dbf.newDocumentBuilder();
			}catch(Exception e){
				// Under some peculiar conditions (classloader issues), just scrap the old dbf, create a new one and
				// try again.
				dbf = getDOMFactory();
				db = dbf.newDocumentBuilder();
			}
		}
		db.setEntityResolver(new DOMUtils.DefaultEntityResolver());
		db.setErrorHandler(new DOMUtils.ParserErrorHandler());
		return(db.parse(inp));
	}

	/**
	 * Metodo que crea un nuevo Document a traves de un InputStream
	 * 
	 * @return Returns Document
	 * @throws ParserConfigurationException si durante la construccion sucede algun problema
	 * @throws SAXException si el document xml tiene problemas sax
	 * @throws IOException si ocurre una expecion de entrada/salida
	 */
	private static Document newDocument(final InputStream inp) throws ParserConfigurationException,SAXException,
				IOException{
		return newDocument(new InputSource(inp));
	}

	/**
	 * Metodo que crea un nuevo Document a traves de un Reader
	 * 
	 * @return Returns Document
	 * @throws ParserConfigurationException si durante la construccion sucede algun problema
	 * @throws SAXException si el document xml tiene problemas sax
	 * @throws IOException si ocurre una expecion de entrada/salida
	 */
	private static Document newDocument(final Reader reader) throws ParserConfigurationException,SAXException,
				IOException{
		return newDocument(new InputSource(reader));
	}



	


	/**
	 * @return
	 */
	public static InputSource getEmptyInputSource(){
		return new InputSource(bais);
	}

	public static class ParserErrorHandler implements ErrorHandler{
		/**
		 * Returns a string describing parse exception details
		 */
		private String getParseExceptionInfo(final SAXParseException spe){
			String systemId = spe.getSystemId();
			if(systemId == null){
				systemId = "null";
			}
			return "URI=" + systemId + " Line=" + spe.getLineNumber() + ": " + spe.getMessage();
		}

		// The following methods are standard SAX ErrorHandler methods.
		// See SAX documentation for more info.
		@Override
		public void warning(final SAXParseException spe) throws SAXException{
		}

		@Override
		public void error(final SAXParseException spe) throws SAXException{
			String message = "Error: " + getParseExceptionInfo(spe);
			throw new SAXException(message);
		}

		@Override
		public void fatalError(final SAXParseException spe) throws SAXException{
			String message = "Fatal Error: " + getParseExceptionInfo(spe);
			throw new SAXException(message);
		}
	}

	public static class DefaultEntityResolver implements EntityResolver{
		public DefaultEntityResolver(){
		}

		@Override
		public InputSource resolveEntity(final String publicId,final String systemId){
			return DOMUtils.getEmptyInputSource();
		}
	}

	public static byte[] convertDataHandlerToBytes(final DataHandler archivo) throws IOException{
		InputStream dataHandler = archivo.getInputStream();
		return IOUtils.toByteArray(dataHandler);
	}



	/**
	 * Duplica el arbol DOM completamente
	 * 
	 * @param source Document orginal a copiar
	 * @return Document destino.
	 * @throws TransformerException
	 */
	public static Document cloneDocument(final Document docSource) throws TransformerException{
		TransformerFactory tfactory = TransformerFactory.newInstance();
		Transformer tx = tfactory.newTransformer();
		DOMSource source = new DOMSource(docSource);
		DOMResult result = new DOMResult();
		tx.transform(source,result);
		return (Document)result.getNode();
	}



	/**
	 * Metodo para eliminar un nodo de un documento
	 * 
	 * @param element
	 */
	public static void deleteElement(final Element element){
		deleteNode(element);
	}

	/**
	 * Metodo para eliminar un nodo de un documento
	 * 
	 * @param node
	 */
	public static void deleteNode(final Node node){
		if(node != null){
			Node parentNode = node.getParentNode();
			parentNode.removeChild(node);
		}
	}
	
	/**
	 * Devuelve el binario de un documento XML indepedientemente
	 * de l encoding utilizado.
	 * 
	 * @param node Nodo a convertir
	 * @return Array de octetos del documento.
	 * @throws TransformerException En caso de fallo
	 */
	public static byte[] docToBytes(Node node) throws TransformerException  {
		byte[] ret = null;

            Source source = new DOMSource(node);
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            Result result = new StreamResult(out);
            TransformerFactory factory = TransformerFactory.newInstance();
            Transformer transformer = factory.newTransformer();
            transformer.transform(source, result);
            ret = out.toByteArray();
            return ret;
    }
	
	/**
	 * Accede a los contenidos CDATA que pueda tener una etiqueta.
	 * 
	 * @param e Etiqueta que dispone de contenido CDATA
	 * @return Cadena con el contenido.
	 */
	public static String getCharacterDataFromElement(Element e) {
		Node child = e.getFirstChild();
		if (child instanceof CharacterData) {
			CharacterData cd = (CharacterData) child;
			return cd.getData();
		}
		return "";
	}	
	
}
