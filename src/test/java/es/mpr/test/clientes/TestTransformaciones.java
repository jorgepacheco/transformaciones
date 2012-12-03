package es.mpr.test.clientes;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import com.mpr.pruebas.transformaciones.DOMUtils;
import com.mpr.pruebas.transformaciones.TranformacionesUtils;
import com.mpr.pruebas.transformaciones.TransformXmlToPdf;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration
public class TestTransformaciones{
	

	@javax.annotation.Resource(name="plantillaXSL")
	protected Resource plantillaXSL;
	

	@javax.annotation.Resource(name="plantillaXSLPdf")
	protected Resource plantillaXSLPdf;
	
	@javax.annotation.Resource(name="ficheroXml")
	protected Resource ficheroXml;
	
	
	 @Value("#{'${path.destino}'}")
	private String path;
	
	@Test
	public void testTransformacionHtml(){
		
		String respuesta = "Respuesta";
		try {
			respuesta = generaRespuestaHtml();
			escribeRespuesta(respuesta.getBytes(),"html");
		} catch (Exception e) {

			e.printStackTrace();
		}

	}


	@Test
	public void testTransformacionPdf(){
		
		byte[] respuesta;
		try {
			respuesta = generaRespuestaPdf();
			escribeRespuesta(respuesta,"pdf");
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	
	
	private void escribeRespuesta(byte[] respuesta, String formato) throws Exception {
        File file = new File(path + "respuesta"
                + System.currentTimeMillis() + "." + formato);
        FileOutputStream fos = new FileOutputStream(file);
        fos.write(respuesta);
        fos.close();		
	}




	private String generaRespuestaHtml() throws UnsupportedEncodingException,
			ParserConfigurationException, SAXException, IOException,
			TransformerException {
		
		Document docXML = DOMUtils.createDocument(ficheroXml.getInputStream());
		Map<String, Object> parametrosXsl = generaParametrosXsl();
		Document transformar = TranformacionesUtils.transformar(docXML,	plantillaXSL, parametrosXsl);
		return DOMUtils.prettyDocumentToString(transformar);
	}
	
	
	private byte[] generaRespuestaPdf() throws Exception {
		TransformXmlToPdf transform = new TransformXmlToPdf();
		ByteArrayOutputStream xmlToPdf = transform.xmlToPdf(ficheroXml.getInputStream(), plantillaXSLPdf.getInputStream());
		return xmlToPdf.toByteArray();		
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
		return plantillaXSL;
	}

	public void setPlantillaXSL(Resource plantillaXSL) {
		this.plantillaXSL = plantillaXSL;
	}

	public Resource getFicheroXml() {
		return ficheroXml;
	}

	public void setFicheroXml(Resource ficheroXml) {
		this.ficheroXml = ficheroXml;
	}




	public String getPath() {
		return path;
	}




	public void setPath(String path) {
		this.path = path;
	}


	public Resource getPlantillaXSLPdf() {
		return plantillaXSLPdf;
	}


	public void setPlantillaXSLPdf(Resource plantillaXSLPdf) {
		this.plantillaXSLPdf = plantillaXSLPdf;
	}
	
}
