package com.mpr.pruebas;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

public class LanzaTransformaciones {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println(":::: Empieza la generacion de Ficheros :::");
		ApplicationContext appContext = new FileSystemXmlApplicationContext("classpath:config/application-context.xml");
		TransformacionService servicio = (TransformacionService)appContext.getBean("transformacionService");
		servicio.generaFicherosResidencia();
		servicio.generaFicherosTitulos();
		System.out.println(":::: Acaba la generacion de Ficheros :::");

	}

}
