<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0" xmlns:str="http://www.str.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:functx="http://www.functx.com" exclude-result-prefixes="str functx">
	<xsl:function name="str:imprimeTexto" as="xs:string" xmlns:str="http://www.str.com">
		<xsl:param name="arg" as="xs:string"/>
		<xsl:sequence select="if ($arg='') 
             then '&#160;'
             else $arg"/>
	</xsl:function>
	<xsl:output version="1.0" method="xml" encoding="UTF-8" indent="no"/>
	<xsl:param name="SV_OutputFormat" select="'PDF'"/>
	<xsl:param name="webContextName"/>
	<xsl:param name="tituloConsulta"/>
	<xsl:param name="justificanteTituloHeader"/>
	<xsl:param name="justificanteTexto"/>
	<xsl:param name="responsabilidadTituloFooter"/>
	<xsl:param name="responsabilidadTexto"/>
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
		<fo:root>
			<fo:layout-master-set>
				<fo:simple-page-master master-name="default-page" page-height="11in" page-width="8.5in" margin-top="0.2in" margin-left="0.6in" margin-right="0.6in">
					<fo:region-body margin-top="400" margin-bottom="120"/>
					<fo:region-before extent="800"/>
					<fo:region-after region-name="xsl-region-after" extent="100"/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="default-page" initial-page-number="1" format="1">
				<xsl:call-template name="header"/>
				<xsl:call-template name="footer"/>
				<xsl:call-template name="body"/>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
	<xsl:template name="header">
		<fo:static-content flow-name="xsl-region-before">
			<fo:block border-style="solid" border-width="1px" border-color="#2F4F4F">
				<fo:table table-layout="fixed" border-width="1px 1px 1px 1px" width="100%" border-spacing="2pt">
					<fo:table-body start-indent="0pt">
						<fo:table-row>
							<fo:table-cell number-columns-spanned="1" padding="0" height="30" display-align="center">
								<fo:block>
									<fo:external-graphic>
										<xsl:attribute name="src">
											<xsl:text>css/2011-HaciendaAP-cabecera.jpg</xsl:text>
										</xsl:attribute>									</fo:external-graphic>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell padding="15">
								<fo:block font-size="12pt" font-family="Arial,Helvetica,sans-serif" font-weight="bold" line-height="13pt" color="#2F4F4F" space-after.optimum="2pt" display-align="after">
									<xsl:value-of select="$justificanteTituloHeader"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			<fo:block text-align="justify">
				<fo:inline font-size="9pt" font-family="Arial,Helvetica,sans-serif" font-weight="bold" color="#DC143C" line-height="10pt" space-after.optimum="2pt" display-align="after">
					<xsl:value-of select="$justificanteTexto"/>
				</fo:inline>
			</fo:block>
			<!-- PARRAFO CON RESPUESTA -->
			<fo:block>
				<fo:leader leader-pattern="space"/>
			</fo:block>
			<fo:block>
				<fo:leader leader-pattern="space"/>
			</fo:block>
			<fo:block text-align="center" font-family="Arial,sans-serif" font-size="10pt" line-height="10pt" space-after.optimum="1pt" display-align="after">
				<fo:inline font-weight="bold">
					<xsl:text>Identificador de Petición:</xsl:text>
					<xsl:value-of select="$idPeticion"/>
				</fo:inline>
			</fo:block>
			<fo:block margin-top="15pt" text-align="justify">
				<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
					<fo:inline font-weight="normal">
						<xsl:text>Respecto a la consulta realizada el dia </xsl:text>
					</fo:inline>
					<fo:inline font-weight="bold">
						<xsl:value-of select="$fechaStr"/>
					</fo:inline>
					<fo:inline font-weight="normal">
						<xsl:text> al Servicio de </xsl:text>
					</fo:inline>
					<fo:inline font-weight="bold">
						<xsl:value-of select="$descripcionServicio"/>
					</fo:inline>
					<fo:inline font-weight="normal">
						<xsl:text> por el funcionario  </xsl:text>
					</fo:inline>
					<fo:inline font-weight="bold">
					[ <xsl:value-of select="$nombreFuncionario"/> ] con DNI <xsl:value-of select="$nifFuncionario"/>
					</fo:inline>
					<fo:inline font-weight="normal">
						<xsl:text> perteneciente al organismo </xsl:text>
					</fo:inline>
					<fo:inline font-weight="bold">
						<xsl:value-of select="$organismoFuncionario"/>
					</fo:inline>
					<fo:inline font-weight="normal">
						<xsl:text>, con los siguientes datos: </xsl:text>
					</fo:inline>
					<fo:leader leader-pattern="space"/>
				</fo:block>
			</fo:block>
			<!-- DATOS DE LA VERIFICACION-->
			<fo:block border-style="solid" border="1px 0 0 0" text-indent="3mm" font-family="Arial,sans-serif" font-size="10pt" space-before="5mm" space-after="1mm">
				<fo:table table-layout="fixed" width="100%" border-spacing="5pt" space-before="2mm">
					<fo:table-body start-indent="0pt">
						<!-- Fila 1 Hijo -->
						<fo:table-row>
							<fo:table-cell padding="2pt" display-align="center">
								<fo:block>
									<fo:inline-container>
										<fo:block>
											<xsl:text>&#x2029;</xsl:text>
										</fo:block>
									</fo:inline-container>
								</fo:block>
								<fo:block text-align="left" margin="0pt">
									<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
										<fo:inline font-weight="bold">
											<xsl:text>Nombre:</xsl:text>
											<fo:leader leader-pattern="space"/>
										</fo:inline>
										<fo:inline font-style="normal">
											<xsl:value-of select="str:imprimeTexto(string($nombre))"/>
										</fo:inline>
									</fo:block>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell padding="2pt" display-align="center">
								<fo:block>
									<fo:inline-container>
										<fo:block>
											<xsl:text>&#x2029;</xsl:text>
										</fo:block>
									</fo:inline-container>
								</fo:block>
								<fo:block text-align="left" margin="0pt">
									<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
										<fo:inline font-weight="bold">
											<xsl:text>Primer Apellido:</xsl:text>
											<fo:leader leader-pattern="space"/>
										</fo:inline>
										<fo:inline font-style="normal">
											<xsl:value-of select="str:imprimeTexto(string($apellido1))"/>
										</fo:inline>
									</fo:block>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<!-- Fila2 Hijo -->
						<fo:table-row>
							<fo:table-cell padding="2pt" display-align="center">
								<fo:block>
									<fo:inline-container>
										<fo:block>
											<xsl:text>&#x2029;</xsl:text>
										</fo:block>
									</fo:inline-container>
								</fo:block>
								<fo:block text-align="left" margin="0pt">
									<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
										<fo:inline font-weight="bold">
											<xsl:text>Segundo Apellido:</xsl:text>
											<fo:leader leader-pattern="space"/>
										</fo:inline>
										<fo:inline font-style="normal">
											<xsl:value-of select="str:imprimeTexto(string($apellido2))"/>
										</fo:inline>
									</fo:block>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell padding="2pt" display-align="center">
								<fo:block>
									<fo:inline-container>
										<fo:block>
											<xsl:text>&#x2029;</xsl:text>
										</fo:block>
									</fo:inline-container>
								</fo:block>
								<fo:block text-align="left" margin="0pt">
									<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
										<fo:inline font-weight="bold">
											<xsl:text>Documentación:</xsl:text>
											<fo:leader leader-pattern="space"/>
										</fo:inline>
										<fo:inline font-style="normal">
											<xsl:value-of select="str:imprimeTexto(string($documento))"/> (<xsl:value-of select="str:imprimeTexto(string($tipoDocumento))"/>)
										</fo:inline>
									</fo:block>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<!-- Fila3Hijo -->
						<fo:table-row>
							<fo:table-cell padding="2pt" display-align="center">
								<fo:block>
									<fo:inline-container>
										<fo:block>
											<xsl:text>&#x2029;</xsl:text>
										</fo:block>
									</fo:inline-container>
								</fo:block>
								<fo:block text-align="left" margin="0pt">
									<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
										<fo:inline font-weight="bold">
											<xsl:text>Español:</xsl:text>
											<fo:leader leader-pattern="space"/>
										</fo:inline>
										<fo:inline font-style="normal">
											<xsl:value-of select="$espanol"/>
										</fo:inline>
									</fo:block>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell padding="2pt" display-align="center">
								<fo:block>
									<fo:inline-container>
										<fo:block>
											<xsl:text>&#x2029;</xsl:text>
										</fo:block>
									</fo:inline-container>
								</fo:block>
								<fo:block text-align="left" margin="0pt">
									<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
										<fo:inline font-weight="bold">
											<xsl:text>Fecha Nacimiento:</xsl:text>
											<fo:leader leader-pattern="space"/>
										</fo:inline>
										<fo:inline font-style="normal">
											<xsl:value-of select="str:imprimeTexto(string($fechaNac))"/>
										</fo:inline>
									</fo:block>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<!-- Fila4Hijo -->
						<fo:table-row>
							<fo:table-cell padding="2pt" display-align="center">
								<fo:block>
									<fo:inline-container>
										<fo:block>
											<xsl:text>&#x2029;</xsl:text>
										</fo:block>
									</fo:inline-container>
								</fo:block>
								<fo:block text-align="left" margin="0pt">
									<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
										<fo:inline font-weight="bold">
											<xsl:text>Provincia de Nacimiento:</xsl:text>
											<fo:leader leader-pattern="space"/>
										</fo:inline>
										<fo:inline font-style="normal">
											<xsl:value-of select="str:imprimeTexto(string($provinciaNac))"/>
										</fo:inline>
									</fo:block>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell padding="2pt" display-align="center">
								<fo:block>
									<fo:inline-container>
										<fo:block>
											<xsl:text>&#x2029;</xsl:text>
										</fo:block>
									</fo:inline-container>
								</fo:block>
								<fo:block text-align="left" margin="0pt">
									<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
										<fo:inline font-weight="bold">
											<xsl:text>Municipio de Nacimiento:</xsl:text>
											<fo:leader leader-pattern="space"/>
										</fo:inline>
										<fo:inline font-style="normal">
											<xsl:value-of select="str:imprimeTexto(string($municipioNac))"/>
										</fo:inline>
									</fo:block>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<!-- Fila5Hijo -->
						<fo:table-row>
							<fo:table-cell padding="2pt" display-align="center">
								<fo:block>
									<fo:inline-container>
										<fo:block>
											<xsl:text>&#x2029;</xsl:text>
										</fo:block>
									</fo:inline-container>
								</fo:block>
								<fo:block text-align="left" margin="0pt">
									<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
										<fo:inline font-weight="bold">
											<xsl:text>Provincia de Residencia:</xsl:text>
											<fo:leader leader-pattern="space"/>
										</fo:inline>
										<fo:inline font-style="normal">
											<xsl:value-of select="str:imprimeTexto(string($provinciaRes))"/>
										</fo:inline>
									</fo:block>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell padding="2pt" display-align="center">
								<fo:block>
									<fo:inline-container>
										<fo:block>
											<xsl:text>&#x2029;</xsl:text>
										</fo:block>
									</fo:inline-container>
								</fo:block>
								<fo:block text-align="left" margin="0pt">
									<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
										<fo:inline font-weight="bold">
											<xsl:text>Municipio de Residencia:</xsl:text>
											<fo:leader leader-pattern="space"/>
										</fo:inline>
										<fo:inline font-style="normal">
											<xsl:value-of select="str:imprimeTexto(string($municipioRes))"/>
										</fo:inline>
									</fo:block>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<!-- Fila6Hijo -->
						<xsl:if test="string($codProcedimiento) = ''">
							<fo:table-row>
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Motivo:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="normal">
												<xsl:value-of select="$finalidad"/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
						<xsl:if test="string($codProcedimiento)  != ''">
							<fo:table-row>
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Numero Expediente:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="normal">
												<xsl:value-of select="$idExpediente"/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Unidad Tramitadora:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="normal">
												<xsl:value-of select="$unidadTramitadora"/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<fo:table-row>
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Código Procedimiento:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="normal">
												<xsl:value-of select="$codProcedimiento"/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Nombre Procedimiento:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="normal">
												<xsl:value-of select="$nomProcedimiento"/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<fo:table-row>
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Finalidad:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="normal">
												<xsl:value-of select="$finalidad"/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
					</fo:table-body>
				</fo:table>
			</fo:block>
			<fo:block text-align="left" margin-top="25pt">
				<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
					<fo:inline font-weight="normal">
						<xsl:text>Se han obtenido los siguientes datos de Residendia:</xsl:text>
					</fo:inline>
				</fo:block>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	<xsl:template name="footer">
		<fo:static-content flow-name="xsl-region-after">
			<fo:table>
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="2" padding="0" display-align="center">
							<fo:block>
								<fo:block text-align="center">
									<fo:leader leader-pattern="rule" rule-thickness="1" leader-length="100%" color="#2F4F4F"/>
								</fo:block>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="2" padding="0" display-align="center">
							<fo:block>
								<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" font-style="italic" text-align="justify" color="#2F4F4F">
									<xsl:value-of select="$responsabilidadTituloFooter"/>
								</fo:block>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="2" padding="0" display-align="center">
							<fo:block>
								<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" font-style="italic" text-align="justify" color="#2F4F4F">
									<xsl:value-of select="$responsabilidadTexto"/>
								</fo:block>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="2" padding="0" display-align="center">
							<fo:block>
								<fo:block text-align="center">
									<fo:leader leader-pattern="rule" rule-thickness="1" leader-length="100%" color="#2F4F4F"/>
								</fo:block>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
			<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" text-align="center">
    - <fo:page-number/> de <fo:page-number-citation ref-id="last-page"/> -
					</fo:block>
		</fo:static-content>
	</xsl:template>
	<xsl:template name="body">
		<fo:flow flow-name="xsl-region-body">
			<xsl:apply-templates select="//*[local-name()='DatosEspecificos']"/>
			<fo:block id="last-page"/>
		</fo:flow>
	</xsl:template>
	<xsl:template match="//*[local-name()='DatosEspecificos']">
		<xsl:variable name="respuesta" select="/*[local-name()='Respuesta']"/>
		<xsl:variable name="datosEspecificos" select="$respuesta/*[local-name()='Transmisiones']/*[local-name()='TransmisionDatos']/*[local-name()='DatosEspecificos']"/>
		<xsl:variable name="domicilio" select="$datosEspecificos/*[local-name()='Domicilio']"/>
		<xsl:variable name="direccion" select="$domicilio/*[local-name()='Direccion']"/>
		<fo:block>
			<xsl:choose>
				<!-- Miramos el Codigo de Error de la etiqueta Atributos-->
				<xsl:when test="$datosEspecificos/*[local-name()='Estado']/*[local-name()='CodigoEstado'] != '0003' ">
					<xsl:variable name="estado" select="$datosEspecificos/*[local-name()='Estado']"/>
					<fo:block border-style="solid" border-width="1px" border-color="#2F4F4F">
						<fo:table table-layout="fixed" border-width="1px 1px 1px 1px" width="100%" border-spacing="2pt">
							<fo:table-body start-indent="0pt">
								<fo:table-row>
									<fo:table-cell number-columns-spanned="1" padding="0" height="30" display-align="center">
										<fo:block text-indent="40mm" font-family="Arial,sans-serif" font-size="8pt">
											<fo:inline font-style="bold" margin="10px 10px 10px 10px" space-before="25mm" space-after="25mm">
												<xsl:text>CONSULTA REALIZADA CORRECTAMENTE:      </xsl:text>
												<xsl:value-of select="$estado/*[local-name()='CodigoEstado']"/>
												<xsl:text>  -  </xsl:text>
												<xsl:value-of select="$estado/*[local-name()='LiteralError']"/>
											</fo:inline>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
				</xsl:when>
				<!-- FIN Miramos el Codigo de Error de la etiqueta Atributos-->
				<xsl:when test="$datosEspecificos/*[local-name()='Estado']/*[local-name()='CodigoEstado'] = '0003'">
					<!-- Panel Datos Residencia -->
					<fo:block border-style="solid" border="1px 0 0 0" text-indent="3mm" font-family="Arial,sans-serif" font-size="10pt" space-before="5mm" space-after="1mm">
						<fo:table table-layout="fixed" width="100%" border-spacing="5pt" space-after="1mm" border-style="solid" border="1px 1px 1px 1px">
							<fo:table-body start-indent="0pt">
								<fo:table-row>
									<fo:table-cell padding="3pt" display-align="center" background-color="#F8F8FF">
										<fo:block>
											<fo:inline font-weight="bold" display-align="after">
												<xsl:text>Datos Residencia</xsl:text>
											</fo:inline>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
						<fo:table table-layout="fixed" width="100%" border-spacing="5pt" space-before="2mm">
							<fo:table-body start-indent="0pt">
								<!-- Fila 1 Hijo -->
								<fo:table-row>
									<fo:table-cell padding="2pt" display-align="center">
										<fo:block>
											<fo:inline-container>
												<fo:block>
													<xsl:text>&#x2029;</xsl:text>
												</fo:block>
											</fo:inline-container>
										</fo:block>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Provincia:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($domicilio/*[local-name()='ProvinciaRespuesta']/*[local-name()='Nombre']))"/> ( 
								<xsl:value-of select="str:imprimeTexto(string($domicilio/*[local-name()='ProvinciaRespuesta']/*[local-name()='Codigo']))"/>
								)
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell padding="2pt" display-align="center">
										<fo:block>
											<fo:inline-container>
												<fo:block>
													<xsl:text>&#x2029;</xsl:text>
												</fo:block>
											</fo:inline-container>
										</fo:block>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Municipio:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($domicilio/*[local-name()='MunicipioRespuesta']/*[local-name()='Nombre']))"/> ( 
								<xsl:value-of select="str:imprimeTexto(string($domicilio/*[local-name()='MunicipioRespuesta']/*[local-name()='Codigo']))"/>
								)
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<!-- Fila2 Hijo -->
								<fo:table-row>
									<fo:table-cell padding="2pt" display-align="center">
										<fo:block>
											<fo:inline-container>
												<fo:block>
													<xsl:text>&#x2029;</xsl:text>
												</fo:block>
											</fo:inline-container>
										</fo:block>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Entidad Colectiva:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($domicilio/*[local-name()='EntColectiva']/*[local-name()='Nombre']))"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell padding="2pt" display-align="center">
										<fo:block>
											<fo:inline-container>
												<fo:block>
													<xsl:text>&#x2029;</xsl:text>
												</fo:block>
											</fo:inline-container>
										</fo:block>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Entidad Singular:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($domicilio/*[local-name()='EntSingular']/*[local-name()='Nombre']))"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<!-- Fila3Hijo -->
								<fo:table-row>
									<fo:table-cell padding="2pt" display-align="center">
										<fo:block>
											<fo:inline-container>
												<fo:block>
													<xsl:text>&#x2029;</xsl:text>
												</fo:block>
											</fo:inline-container>
										</fo:block>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Código Unidad Poblacional:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($domicilio/*[local-name()='CodUnidadPoblacional']))"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell padding="2pt" display-align="center">
										<fo:block>
											<fo:inline-container>
												<fo:block>
													<xsl:text>&#x2029;</xsl:text>
												</fo:block>
											</fo:inline-container>
										</fo:block>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Núcleo / Diseminado:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($domicilio/*[local-name()='Nucleo']/*[local-name()='Nombre']))"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<!-- Fila4Hijo -->
								<fo:table-row>
									<fo:table-cell padding="2pt" display-align="center">
										<fo:block>
											<fo:inline-container>
												<fo:block>
													<xsl:text>&#x2029;</xsl:text>
												</fo:block>
											</fo:inline-container>
										</fo:block>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Código Postal:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='CodPostal']))"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<!-- Fila5Hijo -->
								<fo:table-row>
									<fo:table-cell padding="2pt" display-align="center">
										<fo:block>
											<fo:inline-container>
												<fo:block>
													<xsl:text>&#x2029;</xsl:text>
												</fo:block>
											</fo:inline-container>
										</fo:block>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Tipo de Vía:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Via']/*[local-name()='Tipo']))"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell padding="2pt" display-align="center">
										<fo:block>
											<fo:inline-container>
												<fo:block>
													<xsl:text>&#x2029;</xsl:text>
												</fo:block>
											</fo:inline-container>
										</fo:block>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Nombre de Vía:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Via']/*[local-name()='Nombre']))"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
						<fo:table table-layout="fixed" width="100%" space-before="2mm" text-indent="3mm">
							<fo:table-body start-indent="0pt">
								<!-- datos de la Direccion -->
								<fo:table-row>
									<fo:table-cell>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="8pt" space-after.optimum="0pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Número:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" space-after.optimum="0pt" line-height="8pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Superior:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell display-align="center">
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="8pt" space-after.optimum="0pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Km:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell display-align="center">
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="8pt" space-after.optimum="0pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Hm:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell display-align="center">
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="8pt" space-after.optimum="0pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Bloque:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell display-align="center">
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="8pt" space-after.optimum="0pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Portal:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell display-align="center">
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="8pt" space-after.optimum="0pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Escalera:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell display-align="center">
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="8pt" space-after.optimum="0pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Planta:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell display-align="center">
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="8pt" space-after.optimum="0pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Puerta:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<fo:table-row>
									<fo:table-cell>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="8pt" space-after.optimum="0pt" display-align="after">
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Numero']/*[local-name()='Valor']))"/>
													<xsl:if test="$direccion/*[local-name()='Numero']/*[local-name()='Calificador'] != '' ">
													 - 
									<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Numero']/*[local-name()='Calificador']))"/>
													</xsl:if>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="8pt" space-after.optimum="0pt" display-align="after">
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='NumeroSuperior']/*[local-name()='Valor']))"/>
													<xsl:if test="$direccion/*[local-name()='NumeroSuperior']/*[local-name()='Calificador'] != '' ">										
													 - 
									<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='NumeroSuperior']/*[local-name()='Calificador']))"/>
													</xsl:if>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell display-align="center">
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="8pt" space-after.optimum="0pt" display-align="after">
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Kmt']))"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell display-align="center">
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="8pt" space-after.optimum="0pt" display-align="after">
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Hmt']))"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell display-align="center">
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="8pt" space-after.optimum="0pt" display-align="after">
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Bloque']))"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell display-align="center">
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="8pt" space-after.optimum="0pt" display-align="after">
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Portal']))"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell display-align="center">
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="8pt" space-after.optimum="0pt" display-align="after">
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Escalera']))"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell display-align="center">
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="8pt" space-after.optimum="0pt" display-align="after">
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Planta']))"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell display-align="center">
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="8pt" space-after.optimum="0pt" display-align="after">
												<fo:inline font-style="normal">
													<xsl:value-of select="str:imprimeTexto(string($direccion/*[local-name()='Puerta']))"/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
				</xsl:when>
			</xsl:choose>
		</fo:block>
		<fo:block text-align="left" margin-top="25pt">
			<fo:block font-size="8pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="1pt" display-align="after">
				<fo:inline font-weight="normal">
					<xsl:text>Si desea verificar la consulta realizada utilize el siguiente identificador de petición:</xsl:text>
					<xsl:value-of select="$idPeticion"/>
					<fo:leader leader-pattern="space"/>
				</fo:inline>
			</fo:block>
		</fo:block>
	</xsl:template>
</xsl:stylesheet>
