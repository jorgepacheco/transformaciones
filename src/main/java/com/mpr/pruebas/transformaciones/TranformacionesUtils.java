package com.mpr.pruebas.transformaciones;

import java.io.BufferedInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamSource;

import org.springframework.core.io.Resource;
import org.w3c.dom.Document;

/**
 * Clase que reune metodos utiles para trabajar con Transformaciones XSL y Documentos XML.
 * 
 * @author rmartine
 */
public class TranformacionesUtils{
	// Esta propiedad no es necesaria puesto que la JVM debería cargar la libreria existente.
	// System.setProperty("javax.xml.transform.TransformerFactory", "net.sf.saxon.TransformerFactoryImpl");
	/**
	 * Tranformacion simple de un Document XML utilizando una transformacion XSL.
	 * 
	 * @param docXML Documento XML a procesar
	 * @param pathXsl Path al fichero XSL para la transformacion
	 * @return Documento XML tranformado
	 * @throws TransformerException Excepcion al transformar la peticion.
	 * @throws FileNotFoundException Excepcion si no encuentran el fichero de transformacion
	 */
	public static Document transformar(final Document docXML,final String pathXsl) throws TransformerException,
				FileNotFoundException{
		InputStream resourceAsStream = Thread.currentThread().getContextClassLoader().getResourceAsStream(pathXsl);
		Assert.notNull(resourceAsStream,String.format(
					"El objeto <resourceAsStream> no puede ser null. Puede que no exista el recurso '%s'",pathXsl));
		InputStream xslIS = new BufferedInputStream(resourceAsStream);
		return TranformacionesUtils.transformar(docXML,xslIS);
	}

	/**
	 * Tranformacion simple de un Document XML utilizando una transformacion XSL.
	 * 
	 * @param docXML Documento XML a procesar
	 * @param xslIS Flujo de datos con la transformacion XSL a utilizar
	 * @return Documento XML tranformado
	 * @throws TransformerException Excepcion al transformar la peticion.
	 */
	public static Document transformar(final Document docXML,final InputStream xslIS) throws TransformerException{
		return TranformacionesUtils.transformar(docXML,xslIS,null);
	}

	/**
	 * Tranformacion simple de un Document XML utilizando una transformacion XSL y un Mapa de Parametros
	 * 
	 * @param docXML Documento XML a procesar
	 * @param xslIS Flujo de datos con la transformacion XSL a utilizar
	 * @param mapaParametros
	 * @return Documento XML tranformado
	 * @throws TransformerException Excepcion al transformar la peticion.
	 */
	public static Document transformar(final Document docXML,final InputStream xslIS,
				final Map<String,Object> mapaParametros) throws TransformerException{
		Assert.notNull(xslIS,"El objeto <xslIS> no puede ser null. Puede que no exista el recurso");
		// Use the static TransformerFactory.newInstance() method to instantiate
		// a TransformerFactory. The javax.xml.transform.TransformerFactory
		// system property setting determines the actual class to instantiate
		TransformerFactory tFactory = TransformerFactory.newInstance();
		Transformer transformer = tFactory.newTransformer(new StreamSource(xslIS));
		// Añadimos parametros al transformer
		if(mapaParametros != null){
			Set<Entry<String,Object>> parametros = mapaParametros.entrySet();
			for(Entry<String,Object> parametro:parametros){
				transformer.setParameter(parametro.getKey(),parametro.getValue());
			}
		}
		DOMResult resultado = new DOMResult();
		// Use the Transformer to apply the associated Templates object to an XML document
		transformer.transform(new DOMSource(docXML),resultado);
		Document docResultado = (Document)resultado.getNode();
		return docResultado;
	}

	/**
	 * Tranformacion simple de un Document XML utilizando una transformacion XSL.
	 * 
	 * @param docXML Documento XML a procesar
	 * @param xslLocation {@link Resource} del archivo XSL a utilizar en la transformacion
	 * @return Documento XML tranformado
	 * @throws TransformerException Excepcion al transformar la peticion.
	 */
	public static Document transformar(final Document docXML,final Resource xslLocation) throws TransformerException{
		try{
			return transformar(docXML,xslLocation.getInputStream());
		}catch(IOException e){
			throw new TransformerException(e);
		}
	}

	/**
	 * Tranformacion simple de un Document XML utilizando una transformacion XSL.
	 * 
	 * @param docXML Documento XML a procesar
	 * @param xslLocation {@link Resource} del archivo XSL a utilizar en la transformacion
	 * @param mapaParametros
	 * @return Documento XML tranformado
	 * @throws TransformerException Excepcion al transformar la peticion.
	 */
	public static Document transformar(final Document docXML,final Resource xslLocation,
				final Map<String,Object> mapaParametros) throws TransformerException{
		try{
			return transformar(docXML,xslLocation.getInputStream(),mapaParametros);
		}catch(IOException e){
			throw new TransformerException(e);
		}
	}
}
