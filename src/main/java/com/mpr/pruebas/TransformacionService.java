package com.mpr.pruebas;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import com.mpr.pruebas.transformaciones.DOMUtils;
import com.mpr.pruebas.transformaciones.TranformacionesUtils;
import com.mpr.pruebas.transformaciones.TransformXmlToPdf;


@Service("transformacionService")
public class TransformacionService {

	@javax.annotation.Resource(name="plantillaXSLtnu")
	protected Resource plantillaXSLtnu;

	@javax.annotation.Resource(name="plantillaXSLPdftnu")
	protected Resource plantillaXSLPdftnu;
	
	@javax.annotation.Resource(name="ficheroXmltnu")
	protected Resource ficheroXmltnu;
	
	@javax.annotation.Resource(name="plantillaXSLvdr")
	protected Resource plantillaXSLvdr;

	@javax.annotation.Resource(name="plantillaXSLPdfvdr")
	protected Resource plantillaXSLPdfvdr;
	
	@javax.annotation.Resource(name="ficheroXmlvdr")
	protected Resource ficheroXmlvdr;	
	
	
	 @Value("#{'${path.destino}'}")
	private String path;
	
	public void generaFicherosResidencia(){
		generaFicheros(plantillaXSLvdr, plantillaXSLPdfvdr, ficheroXmlvdr, "residencia_");
	}
	
	public void generaFicherosTitulos(){
		generaFicheros(plantillaXSLtnu, plantillaXSLPdftnu, ficheroXmltnu, "titulos_");
	}	

	private void generaFicheros(Resource xsl, Resource xslPdf, Resource xml, String prefijo) {
		String respuesta = "Respuesta";
		try {
			respuesta = generaRespuestaHtml(xsl, xml);
			escribeRespuesta(respuesta.getBytes(),"html",prefijo);
			byte[] generaRespuestaPdf = generaRespuestaPdf(xslPdf, xml);
			escribeRespuesta(generaRespuestaPdf,"pdf",prefijo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}




	public String generaRespuestaHtml(Resource xsl, Resource xml) throws UnsupportedEncodingException,
			ParserConfigurationException, SAXException, IOException,
			TransformerException {
		
		Document docXML = DOMUtils.createDocument(xml.getInputStream());
		Map<String, Object> parametrosXsl = generaParametrosXsl();
		Document transformar = TranformacionesUtils.transformar(docXML,	xsl, parametrosXsl);
		return DOMUtils.prettyDocumentToString(transformar);
	}
	
	
	public byte[] generaRespuestaPdf(Resource xsl, Resource xml) throws Exception {
		TransformXmlToPdf transform = new TransformXmlToPdf();
		transform.setParametros(generaParametrosXsl());
		ByteArrayOutputStream xmlToPdf = transform.xmlToPdf(xml.getInputStream(), xsl.getInputStream());
		return xmlToPdf.toByteArray();		
	}
	
	
	private void escribeRespuesta(byte[] respuesta, String formato, String prefijo) throws Exception {
        File file = new File(path + "respuesta_" + prefijo 
                + System.currentTimeMillis() + "." + formato);
        FileOutputStream fos = new FileOutputStream(file);
        fos.write(respuesta);
        fos.close();		
	}
	
	protected Map<String,Object> generaParametrosXsl(){
		Map<String,Object> mapaParametros = new HashMap<String,Object>();
		mapaParametros.put("idPeticion","ID_PETICION_12");
		mapaParametros.put("fechaStr","20-10-20");
		mapaParametros.put("nifFuncionario","");
		mapaParametros.put("nombreFuncionario","Usuario de Pruebas");
		mapaParametros.put("organismoFuncionario","Organismo de Pruebas");
		mapaParametros.put("finalidad","Finalidad");
		mapaParametros.put("descripcionServicio", "Servicio de Pruebas");
		mapaParametros.put("tipoDocumento","NIF");
		mapaParametros.put("documento","89890002E");
		mapaParametros.put("nombre","Juan");
		mapaParametros.put("apellido1","Perez");
		mapaParametros.put("apellido2","Lopez");
		mapaParametros.put("codProcedimiento","COD_PROC_12");
		mapaParametros.put("nomProcedimiento","PROC_TEST");
		mapaParametros.put("idExpediente","1234567");
		mapaParametros.put("unidadTramitadora","DIVISION DE PROYECTOS DE ADM.ELECTRONICA(MPTAP)");
		return mapaParametros;
	}

	public Resource getPlantillaXSL() {
		return plantillaXSLtnu;
	}

	public void setPlantillaXSL(Resource plantillaXSL) {
		this.plantillaXSLtnu = plantillaXSL;
	}

	public Resource getFicheroXml() {
		return ficheroXmltnu;
	}

	public void setFicheroXml(Resource ficheroXml) {
		this.ficheroXmltnu = ficheroXml;
	}




	public String getPath() {
		return path;
	}




	public void setPath(String path) {
		this.path = path;
	}


	public Resource getPlantillaXSLPdf() {
		return plantillaXSLPdftnu;
	}


	public void setPlantillaXSLPdf(Resource plantillaXSLPdf) {
		this.plantillaXSLPdftnu = plantillaXSLPdf;
	}

}
