<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://www.str.com" xmlns:xs="http://www.w3.org/2001/XMLSchema"
exclude-result-prefixes="str">

	<xsl:function name="str:imprimeTexto" as="xs:string" xmlns:str="http://www.str.com">
		<xsl:param name="arg" as="xs:string"/>
		<xsl:sequence select="if ($arg='') 
             then '&#160;'
             else $arg"/>
	</xsl:function>
	<xsl:param name="idPeticion"/>
	<xsl:param name="descripcionServicio"/>
	<xsl:param name="fechaStr"/>
	<xsl:param name="nifFuncionario"/>
	<xsl:param name="nombreFuncionario"/>
	<xsl:param name="organismoFuncionario"/>
	<xsl:param name="nombre"/>
	<xsl:param name="apellido1"/>
	<xsl:param name="apellido2"/>
	<xsl:param name="documento"/>
	<xsl:param name="tipoDocumento"/>
	<xsl:param name="espanol"/>
	<xsl:param name="fechaNac"/>	
	<xsl:param name="municipioNac"/>	
	<xsl:param name="provinciaNac"/>	
	<xsl:param name="municipioRes"/>	
	<xsl:param name="provinciaRes"/>	
	<xsl:param name="finalidad"/>	
	<xsl:param name="codProcedimiento"/>
	<xsl:param name="nomProcedimiento"/>
	<xsl:param name="idExpediente"/>
	<xsl:param name="unidadTramitadora"/>	

	<xsl:template match="/">
<html>
	<head>
		<link type="text/css" rel="stylesheet" href="css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="css/panel.css"/>
		<link type="text/css" rel="stylesheet" href="css/plantilla.css"/>

	</head>
	<body>
		<div aria-labelledby="ui-dialog-title-formularioConsulta:j_idt117:j_idt118" role="dialog" tabindex="-1" class="ui-dialog ui-widget ui-widget-content ui-corner-all  ui-draggable ui-resizable" style="display: block; z-index: 1002; outline: 0px none; position: absolute; height: auto; width: 1001px; top: 14px; left: 128px;">
			<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
				<span id="ui-dialog-title-formularioConsulta:j_idt117:j_idt118" class="ui-dialog-title">Respuesta con Identificador de Petición: WEBPRO7067130</span>
				<a role="button" class="ui-dialog-titlebar-close ui-corner-all" href="#">
					<span class="ui-icon ui-icon-closethick">close</span>
				</a>
			</div>
			<div class="ui-dialog-content ui-widget-content" id="formularioConsulta:j_idt117:j_idt118" style="width: auto; min-height: 0px; height: 759.833px;">
				<table id="formularioConsulta:j_idt117:displayAuto" style="with:90%;">
					<tbody>
						<tr>
							<td>
								<span id="formularioConsulta:j_idt117:respuesta">
									<!-- PLANTILLA -->
					
									<div class="resultadoConsulta">
										<p>
										Respecto a la consulta realizada el dia <b><xsl:value-of select="$fechaStr"/></b> al Servicio de <b><xsl:value-of select="$descripcionServicio"/></b> 
										por el funcionario [ <b><xsl:value-of select="$nombreFuncionario"/></b> ] 
										con DNI <b><xsl:value-of select="$nifFuncionario"/></b> perteneciente al organismo <b><xsl:value-of select="$organismoFuncionario"/></b>, con los siguientes datos:
									
									</p>
									</div>
									<div id="panel" class="ui-panel ui-widget ui-widget-content ui-corner-all">
										<div id="panel_content" class="ui-panel-content ui-widget-content">
											<div class="fila">
												<p class="sexto">
													<label>Nombre:</label>
												</p>
												<p class="cuarto">
													<span><xsl:value-of select="str:imprimeTexto(string($nombre))"/></span>
												</p>
												<p class="sexto">
													<label>Primer Apellido:</label>
												</p>
												<p class="cuarto">
													<span><xsl:value-of select="str:imprimeTexto(string($apellido1))"/></span>
												</p>
											</div>
											<div class="fila">
												<p class="sexto">
													<label>Segundo Apellido:</label>
												</p>
												<p class="cuarto">
													<span><xsl:value-of select="str:imprimeTexto(string($apellido2))"/></span>
												</p>
												<p class="sexto">
													<label>Documentación:</label>
												</p>
												<p class="cuarto">
													<span><xsl:value-of select="str:imprimeTexto(string($documento))"/> (<xsl:value-of select="str:imprimeTexto(string($tipoDocumento))"/>)</span>
												</p>
											</div>
											<div class="fila">
												<p class="sexto">
													<label>Español:</label>
												</p>
												<p class="cuarto">
													<span>SI</span>
												</p>
												<p class="sexto">
													<label>Fecha Nacimiento:</label>
												</p>
												<p class="cuarto">
													<span><xsl:value-of select="str:imprimeTexto(string($fechaNac))"/> </span>
												</p>
											</div>
											<div class="fila">
												<p class="sexto">
													<label>Provincia de Nacimiento:</label>
												</p>
												<p class="cuarto">
													<span><xsl:value-of select="str:imprimeTexto(string($provinciaNac))"/>		 
											</span>
												</p>
												<p class="sexto">
													<label>Municipio de Nacimiento:</label>
												</p>
												<p>
													<span><xsl:value-of select="str:imprimeTexto(string($municipioNac))"/> </span>
												</p>
											</div>
											<div class="fila">
												<p class="sexto">
													<label>Provincia de Residencia:</label>
												</p>
												<p class="cuarto">
													<span> <xsl:value-of select="str:imprimeTexto(string($provinciaRes))"/></span>
												</p>
												<p class="sexto">
													<label>Municipio de Residencia:</label>
												</p>
												<p class="cuarto">
													<span> <xsl:value-of select="str:imprimeTexto(string($municipioRes))"/></span>
												</p>
											</div>
										<!-- div class="fila">
												<p class="cuarto">
													<label>Motivo:</label>
												</p>
												<p>
													<span><xsl:value-of select="$finalidad"/></span>
												</p>
											</div>-->
									<!-- Finalidad -->
											<xsl:if test="string($codProcedimiento) = ''">
												<div class="fila">
													<p class="sexto">
														<label>Motivo:</label>
													</p>
													<p class="cuarto">
														<span>
															<xsl:value-of select="$finalidad"/>
														</span>
													</p>
												</div>
											</xsl:if>					
											<xsl:if test="string($codProcedimiento)  != ''">
												<div class="fila">
					
													<p class="sexto">
														<label>Numero Expediente:</label>
													</p>
													<p class="cuarto">
														<span> <xsl:value-of select="str:imprimeTexto(string($idExpediente))"/></span>
													</p>
													<p class="sexto">
														<label>Unidad Tramitadora:</label>
													</p>
													<p class="cuarto">
														<span> <xsl:value-of select="str:imprimeTexto(string($unidadTramitadora))"/></span>
													</p>								
												</div>
												<div class="fila">
													<p class="sexto">
														<label>Código Procedimiento:</label>
													</p>
													<p class="cuarto">
														<span> <xsl:value-of select="str:imprimeTexto(string($codProcedimiento))"/></span>
													</p>							
													<p class="sexto">
														<label>Nombre Procedimiento:</label> 
													</p>
													<p>
														<span> <xsl:value-of select="str:imprimeTexto(string($nomProcedimiento))"/></span>
													</p>
					
												</div>
												<div class="fila">
													<p class="sexto">
														<label>Finalidad:</label>
													</p>							
													<p>
														<span> <xsl:value-of select="$finalidad"/></span>
													</p>						
												</div>
												
											</xsl:if>
											<!-- Fin Finalidad -->						
										</div>
									</div>
								
									<br/>
									<div id="resultadoConsulta">
										<p>
										Se han obtenido los siguientes datos de Residencia:
									
									</p>
									</div>
									<br/>
									<!-- Fin Cabecera de la respuesta -->
									<xsl:apply-templates select="//*[local-name()='DatosEspecificos']"/>

									<!-- FIN PLANTILLA-->
								</span>
							</td>
						</tr>

					</tbody>
				</table>
			</div>
		</div>
	</body>		
	</html>
	</xsl:template>
	<xsl:template match="//*[local-name()='DatosEspecificos']">
		<xsl:variable name="respuesta" select="/*[local-name()='Respuesta']"/>
		<xsl:variable name="datosEspecificos" select="$respuesta/*[local-name()='Transmisiones']/*[local-name()='TransmisionDatos']/*[local-name()='DatosEspecificos']"/>
		<xsl:variable name="domicilio" select="$datosEspecificos/*[local-name()='Domicilio']"/>
		<xsl:variable name="direccion" select="$domicilio/*[local-name()='Direccion']"/>
		<xsl:choose>
			<!-- Miramos el Codigo de Error de la etiqueta Atributos-->
			<xsl:when test="$datosEspecificos/*[local-name()='Estado']/*[local-name()='CodigoEstado'] != '0003' ">
			<xsl:variable name="estado" select="$datosEspecificos/*[local-name()='Estado']"/>
				<div class="resultadoConsulta">
					<h3>CONSULTA REALIZADA CORRECTAMENTE: 
					<xsl:value-of select="$estado/*[local-name()='CodigoEstado']"/> 
					<xsl:value-of select="$estado/*[local-name()='LiteralError']"/>
					</h3>
				</div>			
			</xsl:when>
			<!-- FIN Miramos el Codigo de Error de la etiqueta Atributos-->
			<xsl:when test="$datosEspecificos/*[local-name()='Estado']/*[local-name()='CodigoEstado'] = '0003'">		
		<!-- Panel Datos residencia-->
		<div id="datos" class="ui-panel ui-widget ui-widget-content ui-corner-all">
			<div id="datos_header" class="ui-panel-titlebar ui-widget-header ui-corner-all">
				<span class="ui-panel-title">Datos Residencia</span>
			</div>
			<div id="datos_content" class="ui-panel-content ui-widget-content">
				<div class="fila">
					<p class="sexto">
						<label>Provincia:</label>
					</p>
					<p class="cuarto">
						<span>
							<xsl:value-of select="str:imprimeTexto(string($domicilio/*[local-name()='ProvinciaRespuesta']/*[local-name()='Nombre']))"/> ( 
								<xsl:value-of select="str:imprimeTexto(string($domicilio/*[local-name()='ProvinciaRespuesta']/*[local-name()='Codigo']))"/>
								)
						</span>
					</p>
					<p class="sexto">
						<label>Municipio:</label>
					</p>
					<p class="tercio">
						<span>
							<xsl:value-of select="str:imprimeTexto(string($domicilio/*[local-name()='MunicipioRespuesta']/*[local-name()='Nombre']))"/> ( 
								<xsl:value-of select="str:imprimeTexto(string($domicilio/*[local-name()='MunicipioRespuesta']/*[local-name()='Codigo']))"/>
								)
						</span>
					</p>
				</div>
				<!-- Fila 2 Entidades -->
				<div class="fila">
					<p class="sexto">
						<label>Entidad Colectiva:</label>
					</p>
					<p class="cuarto">
						<span>
							<xsl:value-of select="str:imprimeTexto(string($domicilio/*[local-name()='EntColectiva']/*[local-name()='Nombre']))"/>
						</span>
					</p>
					<p class="sexto">
						<label>Entidad Singular:</label>
					</p>
					<p class="tercio">
						<span>
							<xsl:value-of select="str:imprimeTexto(string($domicilio/*[local-name()='EntSingular']/*[local-name()='Nombre']))"/>
						</span>
					</p>
				</div>
				<!-- Fila 3 Nucleo -->
				<div class="fila">
					<p class="sexto">
						<label>Código Unidad Poblacional:</label>
					</p>
					<p class="cuarto">
						<span>
							<xsl:value-of select="str:imprimeTexto(string($domicilio/*[local-name()='CodUnidadPoblacional']))"/>
						</span>
					</p>				
					<p class="sexto">
						<label>Núcleo / Diseminado:</label>
					</p>
					<p class="tercio">
						<span>
							<xsl:value-of select="str:imprimeTexto(string($domicilio/*[local-name()='Nucleo']/*[local-name()='Nombre']))"/>
						</span>
					</p>

				</div>
				<!-- Fila 4 CP -->
				<div class="fila">
					<p class="sexto">
						<label>Código Postal:</label>
					</p>
					<p class="cuarto">
						<span>
							<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='CodPostal']))"/>
						</span>
					</p>
				</div>
				<!-- Fila 5 Via -->
				<div class="fila">
					<p class="sexto">
						<label>Tipo de Vía:</label>
					</p>
					<p class="cuarto">
						<span>
							<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Via']/*[local-name()='Tipo']))"/>
						</span>
					</p>
					<p class="sexto">
						<label>Nombre de Vía:</label>
					</p>
					<p class="tercio">
						<span>
							<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Via']/*[local-name()='Nombre']))"/>
						</span>
					</p>
				</div>
				<!-- Tabla datos de la Direccion-->
				<div class="fila">
				 
				</div>
				<div class="fila">
					<p class="resto">
						<span> </span>
					</p>
					<p class="decimo">
						<label>Número</label>
						<span>
									<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Numero']/*[local-name()='Valor']))"/> 
									
									<xsl:if test="string($direccion/*[local-name()='Numero']/*[local-name()='Calificador']) != ''">
									- <xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Numero']/*[local-name()='Calificador']))"/>
									</xsl:if>
									
									 
									
						</span>
					</p>
					<p class="decimo">
						<label>Nº Superior</label>
						<span>
									<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='NumeroSuperior']/*[local-name()='Valor']))"/> 
									
									<xsl:if test="string($direccion/*[local-name()='NumeroSuperior']/*[local-name()='Calificador']) != ''">
									- <xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='NumeroSuperior']/*[local-name()='Calificador']))"/>
									</xsl:if>
						</span>
					</p>
					<p class="decimo">
						<label>Km</label>
						<span><xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Kmt']))"/></span>
					</p>
					<p class="decimo">
						<label>Hm</label>
						<span><xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Hmt']))"/></span>
					</p>
					<p class="decimo">
						<label>Bloque</label>
						<span><xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Bloque']))"/></span>
					</p>
					<p class="decimo">
						<label>Portal</label>
						<span><xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Portal']))"/></span>
					</p>
					<p class="decimo">
						<label>Escalera</label>
						<span><xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Escalera']))"/></span>
					</p>
					<p class="decimo">
						<label>Planta</label>
						<span><xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Planta']))"/></span>
					</p>
					<p class="decimo">
						<label>Puerta</label>
						<span><xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Puerta']))"/></span>
					</p>
				</div>
			</div>
		</div>

			</xsl:when>
		</xsl:choose>
		<div class="resultadoConsulta">
			<p>
					Si desea verificar la consulta realizada utilize el siguiente identificador de petición:  <xsl:value-of select="$idPeticion"/>
			</p>
		</div>		
	</xsl:template>
</xsl:stylesheet>
