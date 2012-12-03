package com.mpr.pruebas.transformaciones;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.fop.apps.FOPException;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;
import org.apache.log4j.Logger;
import org.springframework.core.io.Resource;

public class TransformXmlToPdf{
	private static final Logger log = Logger.getLogger(TransformXmlToPdf.class);
	private TransformerFactory factory = TransformerFactory.newInstance();
	private Resource pathTransform;
	private Map<String,Object> parametros = new HashMap<String,Object>();

	public TransformXmlToPdf(Resource contextPath){
		this.pathTransform = contextPath;
	}

	public TransformXmlToPdf(){

	}
	public ByteArrayOutputStream xmlToPdf(String resPDF) throws Exception{
		ByteArrayOutputStream out = null;
		FopFactory fopFactory = FopFactory.newInstance();
		try{
			out = new ByteArrayOutputStream();
			Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF,out);
			Source xslt = new StreamSource(pathTransform.getInputStream());
			if(log.isDebugEnabled()){
				log.debug("Transform Respuesta to PDF " + resPDF);
			}
			factory = TransformerFactory.newInstance();
			Transformer transformer = factory.newTransformer(xslt);
			Set<String> clavesLst = parametros.keySet();
			for(String clave:clavesLst){
				transformer.setParameter(clave,parametros.get(clave));
			}

			Result res = new SAXResult(fop.getDefaultHandler());
			InputStream is = new ByteArrayInputStream(resPDF.toString().getBytes("UTF-8"));
			Source src = new StreamSource(is);
			transformer.transform(src,res);
		}catch(TransformerException e){
			log.error(e,e);
			throw new Exception(e);
		}catch(IOException e){
			log.error(e,e);
			throw new Exception(e);
		}catch(FOPException e){
			log.error(e,e);
			throw new Exception(e);
		}finally{
			try{
				if(out != null){
					out.close();
				}
			}catch(IOException e){
				log.error(e,e);
				throw new Exception(e);
			}
		}
		return out;
	}
	
	
	public ByteArrayOutputStream xmlToPdf(InputStream respuesta, InputStream transformacionXsl) throws Exception{
		ByteArrayOutputStream out = null;
		FopFactory fopFactory = FopFactory.newInstance();
		try{
			out = new ByteArrayOutputStream();
			Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF,out);
			Source xslt = new StreamSource(transformacionXsl);

			
			factory = TransformerFactory.newInstance();
			Transformer transformer = factory.newTransformer(xslt);
			Set<String> clavesLst = parametros.keySet();
			for(String clave:clavesLst){
				transformer.setParameter(clave,parametros.get(clave));
			}

			Result res = new SAXResult(fop.getDefaultHandler());
			Source src = new StreamSource(respuesta);
			transformer.transform(src,res);
		}catch(TransformerException e){
			log.error(e,e);
			throw new Exception(e);
		}catch(FOPException e){
			log.error(e,e);
			throw new Exception(e);
		}finally{
			try{
				if(out != null){
					out.close();
				}
			}catch(IOException e){
				log.error(e,e);
				throw new Exception(e);
			}
		}
		return out;
	}	
	
	
	

	public Map<String,Object> getParametros(){
		return parametros;
	}

	public void setParametros(Map<String,Object> parametros){
		this.parametros = parametros;
	}
}

