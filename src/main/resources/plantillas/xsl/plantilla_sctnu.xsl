<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://www.str.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:functx="http://www.functx.com" exclude-result-prefixes="str functx">
	<xsl:function name="str:imprimeTexto" as="xs:string" xmlns:str="http://www.str.com">
		<xsl:param name="arg" as="xs:string"/>
		<xsl:sequence select="if ($arg='') 
             then '&#160;'
             else $arg"/>
	</xsl:function>
	<xsl:function name="functx:ddmmyyyy-to-dd-mm-yyyy" as="xs:string?" xmlns:functx="http://www.functx.com">
		<xsl:param name="dateString" as="xs:string?"/>
		<xsl:sequence select=" 
			   if (empty($dateString))
					   then '&#160;'
			   else if (not(matches($dateString,
                        '^\D*(\d{2})\D*(\d{2})\D*(\d{4})\D*$')))
				   then error(xs:QName('functx:Invalid_Date_Format'))
			   else xs:string(replace($dateString,'^\D*(\d{2})\D*(\d{2})\D*(\d{4})\D*$','$1-$2-$3'))
 "/>
	</xsl:function>
	<xsl:param name="idPeticion"/>
	<xsl:param name="descripcionServicio"/>
	<xsl:param name="fechaStr"/>
	<xsl:param name="nifFuncionario"/>
	<xsl:param name="nombreFuncionario"/>
	<xsl:param name="organismoFuncionario"/>
	<xsl:param name="finalidad"/>
	<xsl:param name="codProcedimiento"/>
	<xsl:param name="nomProcedimiento"/>
	<xsl:param name="idExpediente"/>
	<xsl:param name="unidadTramitadora"/>
	<xsl:template match="/">
		<xsl:variable name="respuesta" select="/*[local-name()='Respuesta']"/>
		<xsl:variable name="datosTitular" select="$respuesta/*[local-name()='Transmisiones']/*[local-name()='TransmisionDatos']/*[local-name()='DatosGenericos']/*[local-name()='Titular']"/>
		<xsl:variable name="datosEspecificos" select="$respuesta/*[local-name()='Transmisiones']/*[local-name()='TransmisionDatos']/*[local-name()='DatosEspecificos']"/>
		<xsl:variable name="listaTitulos" select="$datosEspecificos/*[local-name()='ListaTitulos	']"/>
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
									<xsl:choose>
										<!-- Miramos el Codigo de Error de la etiqueta Atributos-->
										<xsl:when test="$datosEspecificos/*[local-name()='EstadoResultado']/*[local-name()='CodigoEstado'] != '0003' ">
											<xsl:variable name="estado" select="$datosEspecificos/*[local-name()='EstadoResultado']"/>
											<div class="resultadoConsulta">
												<h3>CONSULTA REALIZADA CORRECTAMENTE: <xsl:value-of select="$estado/*[local-name()='CodigoEstado']"/> - <xsl:value-of select="$estado/*[local-name()='LiteralError']"/>
												</h3>
											</div>
										</xsl:when>
										<xsl:when test="$datosEspecificos/*[local-name()='EstadoResultado']/*[local-name()='CodigoEstado'] = '0003'">
											<div id="panel" class="ui-panel ui-widget ui-widget-content ui-corner-all">
												<div id="panel_content" class="ui-panel-content ui-widget-content">
													<!-- Datos Peticion-->
													<div class="fila">
														<p class="cuarto">
															<label>DNI / NIE</label>
														</p>
														<p class="cuarto">
															<span>
																<xsl:value-of select="str:imprimeTexto(string($datosTitular/*[local-name()='Documentacion']))"/>
														( <xsl:value-of select="str:imprimeTexto(string($datosTitular/*[local-name()='TipoDocumentacion']))"/> )
													</span>
														</p>
														<p class="cuarto">
															<label>Nombre:</label>
														</p>
														<p class="cuarto">
															<span>
																<xsl:value-of select="str:imprimeTexto(string($datosTitular/*[local-name()='Nombre']))"/>
															</span>
														</p>
													</div>
													<!-- Fila 2 Apellidos -->
													<div class="fila">
														<p class="cuarto">
															<label>Apellido 1:</label>
														</p>
														<p class="cuarto">
															<span>
																<xsl:value-of select="str:imprimeTexto(string($datosTitular/*[local-name()='Apellido1']))"/>
															</span>
														</p>
														<p class="cuarto">
															<label>Apellido 2:</label>
														</p>
														<p class="cuarto">
															<span>
																<xsl:value-of select="str:imprimeTexto(string($datosTitular/*[local-name()='Apellido2']))"/>
															</span>
														</p>
													</div>
													<!-- Fila 3 Fecha Nac Pais -->
													<div class="fila">
														<p class="cuarto">
															<label>Fecha Nacimiento:</label>
														</p>
														<p class="cuarto">
															<span>
																<xsl:value-of select="str:imprimeTexto(string($datosEspecificos/*[local-name()='DatosTitular']/*[local-name()='FechaNacimiento']))"/>
															</span>
														</p>
														<p class="cuarto">
															<label>Pais:</label>
														</p>
														<p class="cuarto">
															<span>
																<xsl:value-of select="str:imprimeTexto(string($datosEspecificos/*[local-name()='DatosTitular']/*[local-name()='LugarNacimiento']/*[local-name()='Pais']))"/>
															</span>
														</p>									
													</div>
													<!-- Fila 4 Prov, Loc -->
													<div class="fila">
														<p class="cuarto">
															<label>Localidad:</label>
														</p>
														<p class="cuarto">
															<span>
																<xsl:value-of select="str:imprimeTexto(string($datosEspecificos/*[local-name()='DatosTitular']/*[local-name()='LugarNacimiento']/*[local-name()='Localidad']))"/>
															</span>
														</p>
														<p class="cuarto">
															<label>Provincia:</label>
														</p>
														<p class="cuarto">
															<span>
																<xsl:value-of select="str:imprimeTexto(string($datosEspecificos/*[local-name()='DatosTitular']/*[local-name()='LugarNacimiento']/*[local-name()='Provincia']))"/>
															</span>
														</p>									
													</div>								
													<!-- MOTIVO / PROCEDIMIENTO-->
													<xsl:if test="string($codProcedimiento) = ''">
														<div class="fila">
															<p class="cuarto">
																<label>Motivo:</label>
															</p>
															<p>
																<span>
																	<xsl:value-of select="$finalidad"/>
																</span>
															</p>
														</div>
													</xsl:if>
													<xsl:if test="string($codProcedimiento)  != ''">
														<div class="fila">
															<p class="cuarto">
																<label>Código Procedimiento:</label>
															</p>
															<p class="cuarto">
																<span>
																	<xsl:value-of select="$codProcedimiento"/>
																</span>
															</p>
															<p class="cuarto">
																<label>Numero Expediente:</label>
															</p>
															<p class="cuarto">
																<span>
																	<xsl:value-of select="$idExpediente"/>
																</span>
															</p>
														</div>
														<div class="fila">
															<p class="cuarto">
																<label>Nombre Procedimiento:</label>
															</p>
															<p class="cuarto">
																<span>
																	<xsl:value-of select="$nomProcedimiento"/>
																</span>
															</p>
															<p class="cuarto">
																<label>Unidad Tramitadora:</label>
															</p>
															<p class="cuarto">
																<span>
																	<xsl:value-of select="$unidadTramitadora"/>
																</span>
															</p>
														</div>
														<div class="fila">
															<p class="cuarto">
																<label>Finalidad:</label>
															</p>
															<p class="cuarto">
																<span>
																	<xsl:value-of select="$finalidad"/>
																</span>
															</p>
														</div>
													</xsl:if>
													<!-- Fin Finalidad -->
												</div>
											</div>
												<br/>
											<br/>
											<!-- Fin Cabecera de la respuesta -->
											<xsl:apply-templates select="//*[local-name()='DatosEspecificos']"/>
										</xsl:when>
									</xsl:choose>
			
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
		<xsl:variable name="estado" select="$datosEspecificos/*[local-name()='EstadoResultado']"/>
		<xsl:variable name="datosConsulta" select="$datosEspecificos/*[local-name()='den']"/>
		<xsl:variable name="listaTitulos" select="$datosEspecificos/*[local-name()='ListaTitulos']"/>
		<!-- Panel Datos residencia-->
		<div id="datos" class="ui-panel ui-widget ui-widget-content ui-corner-all">
			<div id="datos_header" class="ui-panel-titlebar ui-widget-header ui-corner-all">
				<span class="ui-panel-title">Datos Titulos No Universitarios</span>
			</div>
			<div id="datos_content" class="ui-panel-content ui-widget-content">
				<xsl:if test="$listaTitulos/*[local-name()='DatosTitulacion']">
					<xsl:for-each select="$listaTitulos/*[local-name()='DatosTitulacion']">
						<xsl:variable name="listaTitulos" select="position()"/>
						<fieldset>
							<h4 class="cabeceraTitulos"><span>Datos Centro</span></h4>

							<div class="fila">
								<p class="octavo">
									<label>Provincia:</label>
								</p>
								<p class="sexto">
									<span>
										<xsl:value-of select="./*[local-name()='DatosCentro']/*[local-name()='Provincia']"/>
									</span>
								</p>
								<p class="octavo">
									<label>Código Centro:</label>
								</p>
								<p class="sexto">
									<span>
										<xsl:value-of select="./*[local-name()='DatosCentro']/*[local-name()='CodCentro']"/>
									</span>
								</p>	
								<p class="octavo">
									<label>Centro:</label>
								</p>
								<p>
									<span>
										<xsl:value-of select="./*[local-name()='DatosCentro']/*[local-name()='Centro']"/>
									</span>
								</p>															

							</div>							
							<h4 class="cabeceraTitulos"><span>Datos Título</span></h4>
							<div class="fila">
								<p class="cuarto">
									<label>Titulación:</label>
								</p>
								<p class="cuarto">
									<span>
										<xsl:value-of select="./*[local-name()='DatosTitulo']/*[local-name()='Titulacion']"/>
									</span>
								</p>
								<p class="cuarto">
									<label>Tipo Título:</label>
								</p>
								<p class="cuarto">
									<span>
										<xsl:value-of select="./*[local-name()='DatosTitulo']/*[local-name()='TipoTitulo']"/>
									</span>
								</p>
							</div>
							
							
							<div class="fila">
								<p class="cuarto">
									<label>Tipo Estudio:</label>
								</p>
								<p class="cuarto">
									<span>
										<xsl:value-of select="./*[local-name()='DatosTitulo']/*[local-name()='TipoEstudio']"/>
									</span>
								</p>
								<p class="cuarto">
									<label>Nivel:</label>
								</p>
								<p class="cuarto">
									<span>
										<xsl:value-of select="./*[local-name()='DatosTitulo']/*[local-name()='Nivel']"/>
									</span>
								</p>
							</div>
							<div class="fila">
								<p class="cuarto">
									<label>Ley:</label>
								</p>
								<p class="cuarto">
									<span>
										<xsl:value-of select="./*[local-name()='DatosTitulo']/*[local-name()='Ley']"/>
									</span>
								</p>
								<p class="cuarto">
									<label>Fecha Finalización</label>
								</p>
								<p class="cuarto">
									<span>
										<xsl:value-of select="./*[local-name()='DatosTitulo']/*[local-name()='FechaFinalizacion']"/>
									</span>
								</p>								
							</div>
							<div class="fila">
								<p class="cuarto">
									<label>Fecha Expedición:</label>
								</p>
								<p class="cuarto">
									<span>
										<xsl:value-of select="./*[local-name()='DatosTitulo']/*[local-name()='FechaExpedicion']"/>
									</span>
								</p>
								<p class="cuarto">
									<label>Registro Nacional:</label>
								</p>
								<p class="cuarto">
									<span>
										<xsl:value-of select="./*[local-name()='DatosTitulo']/*[local-name()='NumRegistroNacional']"/>
									</span>
								</p>								
							</div>	
							<div class="fila">
								<p class="cuarto">
									<label>Registro Autonómico:</label>
								</p>
								<p class="cuarto">
									<span>
										<xsl:value-of select="./*[local-name()='DatosTitulo']/*[local-name()='NumRegistroAutonomico']"/>
									</span>
								</p>
								<p class="cuarto">
									<label>Registro Mec.:</label>
								</p>
								<p class="cuarto">
									<span>
										<xsl:value-of select="./*[local-name()='DatosTitulo']/*[local-name()='NumRegistroMec']"/>
									</span>
								</p>								
							</div>					
							<!-- Registro -->								
							<div class="fila">
								<p class="cuarto">
									<label>Num. Orden:</label>
								</p>
								<p class="cuarto">
									<span>
										<xsl:value-of select="./*[local-name()='DatosTitulo']/*[local-name()='Registro']/*[local-name()='NumOrdenLibro']"/>
									</span>
								</p>
								<p class="cuarto">
									<label>Num. Folio:</label>
								</p>
								<p class="cuarto">
									<span>
										<xsl:value-of select="./*[local-name()='DatosTitulo']/*[local-name()='Registro']/*[local-name()='NumFolio']"/>
									</span>
								</p>								
							</div>		
							<div class="fila">
								<p class="cuarto">
									<label>Num. Libro:</label>
								</p>
								<p class="cuarto">
									<span>
										<xsl:value-of select="./*[local-name()='DatosTitulo']/*[local-name()='Registro']/*[local-name()='NumLibro']"/>
									</span>
								</p>
						
							</div>												
						</fieldset>
					</xsl:for-each>
				</xsl:if>
			</div>
		</div>

	</xsl:template>
</xsl:stylesheet>
