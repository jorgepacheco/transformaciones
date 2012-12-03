<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
	<xsl:output version="1.0" method="xml" encoding="UTF-8" indent="no"/>
	<xsl:param name="SV_OutputFormat" select="'PDF'"/>
	<xsl:param name="webContextName"/>
	<xsl:param name="tituloConsulta"/>
	<xsl:param name="justificanteTituloHeader"/>
	<xsl:param name="justificanteTexto"/>
	<xsl:param name="responsabilidadTituloFooter"/>
	<xsl:param name="responsabilidadTexto"/>
	<xsl:param name="codProcedimiento"/>
	<xsl:param name="nomProcedimiento"/>
	<xsl:param name="idExpediente"/>
	<xsl:param name="unidadTramitadora"/>
	<xsl:template match="/">
		<fo:root>
			<fo:layout-master-set>
				<fo:simple-page-master master-name="default-page" page-height="11in" page-width="8.5in" margin-top="0.2in" margin-left="0.6in" margin-right="0.6in">
					<fo:region-body margin-top="90" margin-bottom="120"/>
					<fo:region-before extent="100"/>
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
										</xsl:attribute>
									</fo:external-graphic>
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
			<xsl:apply-templates select="//*[local-name()='Atributos']"/>
			<xsl:apply-templates select="//*[local-name()='Emisor']"/>
			<xsl:apply-templates select="//*[local-name()='Solicitante']"/>
			<xsl:apply-templates select="//*[local-name()='Titular']"/>
			<xsl:apply-templates select="//*[local-name()='Transmision']"/>
			<xsl:apply-templates select="//*[local-name()='DatosEspecificos']"/>
			<fo:block id="last-page"/>
		</fo:flow>
	</xsl:template>
	<xsl:template match="//*[local-name()='Atributos']">
		<fo:block text-align="justify">
			<fo:inline font-size="12pt" font-family="Arial,Helvetica,sans-serif" font-weight="bold" color="#DC143C" line-height="13pt" space-after.optimum="2pt" display-align="after">
				<xsl:value-of select="$justificanteTexto"/>
			</fo:inline>
		</fo:block>
		<fo:block>
			<fo:leader leader-pattern="space"/>
		</fo:block>
		<fo:block>
			<fo:leader leader-pattern="space"/>
		</fo:block>
		<fo:block text-align="justify">
			<fo:inline font-size="13pt" font-family="Arial,Helvetica,sans-serif" font-weight="bold" line-height="13pt" space-after.optimum="2pt" display-align="after">
				<xsl:value-of select="$tituloConsulta"/>
			</fo:inline>
		</fo:block>
		<fo:block>
			<fo:leader leader-pattern="space"/>
		</fo:block>
		<fo:block text-align="center">
			<fo:inline font-size="12pt" font-family="Arial,Helvetica,sans-serif" font-weight="bold" line-height="13pt" space-after.optimum="2pt" display-align="after">
				<xsl:text>El detalle de la respuesta a la consulta realizada se muestra a continuación:</xsl:text>
			</fo:inline>
		</fo:block>
		<fo:block>
			<fo:leader leader-pattern="space"/>
		</fo:block>
		<fo:block>
			<fo:block>
				<fo:inline-container>
					<fo:block>
						<xsl:text>&#x2029;</xsl:text>
					</fo:block>
				</fo:inline-container>
			</fo:block>
			<fo:block text-align="left" margin="0pt">
				<fo:block font-size="14pt" font-family="Arial,Helvetica,sans-serif" line-height="16pt" space-after.optimum="3pt" text-align="justify" padding-top="20pt">
					<fo:table table-layout="fixed" width="100%" border="solid 1pt #F8F8FF" border-spacing="1pt">
						<fo:table-body start-indent="0pt">
							<fo:table-row>
								<fo:table-cell padding="1pt" display-align="center" background-color="#F8F8FF">
									<fo:block>
										<fo:inline font-weight="bold" display-align="after">
											<xsl:value-of select="local-name(.)"/>
										</fo:inline>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
				<fo:table table-layout="fixed" width="100%" border-spacing="2pt">
					<fo:table-body start-indent="0pt">
						<fo:table-row>
							<xsl:for-each select="//*[local-name()='Atributos']//*[local-name()='IdPeticion']">
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Identificador Petición:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="italic">
												<xsl:value-of select="."/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
							<xsl:for-each select="//*[local-name()='Atributos']//*[local-name()='TimeStamp']">
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Fecha:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="italic">
												<xsl:value-of select="."/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			<fo:block text-align="left" margin="1pt">
				<fo:block>
					<fo:inline-container>
						<fo:block>
							<xsl:text>&#x2029;</xsl:text>
						</fo:block>
					</fo:inline-container>
				</fo:block>
				<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="10pt" space-after.optimum="3pt" text-align="justify" padding-top="8pt">
					<fo:table table-layout="fixed" width="100%" border-width="0px 0px thick 0px" border="solid 1pt #F8F8FF" border-spacing="1pt">
						<fo:table-body start-indent="2pt">
							<fo:table-row>
								<fo:table-cell padding="1pt" display-align="center">
									<fo:block>
										<fo:inline font-weight="bold" display-align="after">
											<xsl:text>Estado</xsl:text>
										</fo:inline>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
				<fo:table table-layout="fixed" width="100%" border-spacing="2pt">
					<fo:table-body start-indent="0pt">
						<fo:table-row>
							<xsl:for-each select="//*[local-name()='Atributos']//*[local-name()='Estado']//*[local-name()='CodigoEstado']">
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Estado:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="italic">
												<xsl:value-of select="."/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
							<xsl:for-each select="//*[local-name()='Atributos']//*[local-name()='Estado']//*[local-name()='LiteralError']">
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Descripción:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="italic">
												<xsl:value-of select="."/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</fo:block>
	</xsl:template>
	<xsl:template match="//*[local-name()='Emisor']">
		<fo:block>
			<fo:block>
				<fo:inline-container>
					<fo:block>
						<xsl:text>&#x2029;</xsl:text>
					</fo:block>
				</fo:inline-container>
			</fo:block>
			<fo:block text-align="left" margin="0pt">
				<fo:block font-size="14pt" font-family="Arial,Helvetica,sans-serif" line-height="16pt" space-after.optimum="3pt" text-align="justify" padding-top="20pt">
					<fo:table table-layout="fixed" width="100%" border="solid 1pt #F8F8FF" border-spacing="1pt">
						<fo:table-body start-indent="0pt">
							<fo:table-row>
								<fo:table-cell padding="1pt" display-align="center" background-color="#F8F8FF">
									<fo:block>
										<fo:inline font-weight="bold" display-align="after">
											<xsl:value-of select="local-name(.)"/>
										</fo:inline>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
				<fo:table table-layout="fixed" width="100%" border-spacing="2pt">
					<fo:table-body start-indent="0pt">
						<fo:table-row>
							<xsl:for-each select="//*[local-name()='Emisor']//*[local-name()='NifEmisor']">
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>NIF:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="italic">
												<xsl:value-of select="."/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
							<xsl:for-each select="//*[local-name()='Emisor']//*[local-name()='NombreEmisor']">
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Nombre:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="italic">
												<xsl:value-of select="."/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</fo:block>
	</xsl:template>
	<xsl:template match="//*[local-name()='Solicitante']">
		<fo:block>
			<fo:block>
				<fo:inline-container>
					<fo:block>
						<xsl:text>&#x2029;</xsl:text>
					</fo:block>
				</fo:inline-container>
			</fo:block>
			<fo:block text-align="left" margin="0pt">
				<fo:block font-size="14pt" font-family="Arial,Helvetica,sans-serif" line-height="16pt" space-after.optimum="3pt" text-align="justify" padding-top="20pt">
					<fo:table table-layout="fixed" width="100%" border="solid 1pt #F8F8FF" border-spacing="1pt">
						<fo:table-body start-indent="0pt">
							<fo:table-row>
								<fo:table-cell padding="1pt" display-align="center" background-color="#F8F8FF">
									<fo:block>
										<fo:inline font-weight="bold" display-align="after">
											<xsl:value-of select="local-name(.)"/>
										</fo:inline>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
				<fo:table table-layout="fixed" width="100%" border-spacing="2pt">
					<fo:table-body start-indent="0pt">
						<fo:table-row>
							<xsl:for-each select="//*[local-name()='Solicitante']//*[local-name()='IdentificadorSolicitante']">
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Identificador:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="italic">
												<xsl:value-of select="."/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
							<xsl:for-each select="//*[local-name()='Solicitante']//*[local-name()='NombreSolicitante']">
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Nombre:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="italic">
												<xsl:value-of select="."/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
						</fo:table-row>
						<fo:table-row>
							<xsl:for-each select="//*[local-name()='Solicitante']//*[local-name()='Consentimiento']">
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Consentimiento:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="italic">
												<xsl:value-of select="."/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
							<xsl:for-each select="//*[local-name()='Solicitante']//*[local-name()='Finalidad']">
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Finalidad:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="italic">
												<xsl:value-of select="."/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
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
									<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
										<fo:inline font-weight="bold">
											<xsl:text>Código Procedimiento:</xsl:text>
											<fo:leader leader-pattern="space"/>
										</fo:inline>
										<fo:inline font-style="italic">
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
									<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
										<fo:inline font-weight="bold">
											<xsl:text>Procedimiento:</xsl:text>
											<fo:leader leader-pattern="space"/>
										</fo:inline>
										<fo:inline font-style="italic">
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
									<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
										<fo:inline font-weight="bold">
											<xsl:text>Identificador Expediente:</xsl:text>
											<fo:leader leader-pattern="space"/>
										</fo:inline>
										<fo:inline font-style="italic">
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
									<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
										<fo:inline font-weight="bold">
											<xsl:text>Unidad Tramitadora:</xsl:text>
											<fo:leader leader-pattern="space"/>
										</fo:inline>
										<fo:inline font-style="italic">
											<xsl:value-of select="$unidadTramitadora"/>
										</fo:inline>
									</fo:block>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</fo:block>
	</xsl:template>
	<xsl:template match="//*[local-name()='Titular']">
		<fo:block>
			<fo:block>
				<fo:inline-container>
					<fo:block>
						<xsl:text>&#x2029;</xsl:text>
					</fo:block>
				</fo:inline-container>
			</fo:block>
			<fo:block text-align="left" margin="0pt">
				<fo:block font-size="14pt" font-family="Arial,Helvetica,sans-serif" line-height="16pt" space-after.optimum="3pt" text-align="justify" padding-top="20pt">
					<fo:table table-layout="fixed" width="100%" border="solid 1pt #F8F8FF" border-spacing="1pt">
						<fo:table-body start-indent="0pt">
							<fo:table-row>
								<fo:table-cell padding="1pt" display-align="center" background-color="#F8F8FF">
									<fo:block>
										<fo:inline font-weight="bold" display-align="after">
											<xsl:value-of select="local-name(.)"/>
										</fo:inline>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
				<fo:block>
					<fo:table table-layout="fixed" width="100%" border-spacing="2pt">
						<fo:table-body start-indent="0pt">
							<fo:table-row>
								<xsl:for-each select="//*[local-name()='Titular']//*[local-name()='TipoDocumentacion']">
									<fo:table-cell padding="2pt" display-align="center">
										<fo:block>
											<fo:inline-container>
												<fo:block>
													<xsl:text>&#x2029;</xsl:text>
												</fo:block>
											</fo:inline-container>
										</fo:block>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Tipo Documentación:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
												<fo:inline font-style="italic">
													<xsl:value-of select="."/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
								</xsl:for-each>
								<xsl:for-each select="//*[local-name()='Titular']//*[local-name()='Nombre']">
									<fo:table-cell padding="2pt" display-align="center">
										<fo:block>
											<fo:inline-container>
												<fo:block>
													<xsl:text>&#x2029;</xsl:text>
												</fo:block>
											</fo:inline-container>
										</fo:block>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Nombre:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
												<fo:inline font-style="italic">
													<xsl:value-of select="."/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
								</xsl:for-each>
							</fo:table-row>
							<fo:table-row>
								<xsl:for-each select="//*[local-name()='Titular']//*[local-name()='Documentacion']">
									<fo:table-cell padding="2pt" display-align="center">
										<fo:block>
											<fo:inline-container>
												<fo:block>
													<xsl:text>&#x2029;</xsl:text>
												</fo:block>
											</fo:inline-container>
										</fo:block>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Documentación:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
												<fo:inline font-style="italic">
													<xsl:value-of select="."/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
								</xsl:for-each>
								<xsl:for-each select="//*[local-name()='Titular']//*[local-name()='Apellido1']">
									<fo:table-cell padding="2pt" display-align="center">
										<fo:block>
											<fo:inline-container>
												<fo:block>
													<xsl:text>&#x2029;</xsl:text>
												</fo:block>
											</fo:inline-container>
										</fo:block>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Primer Apellido:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
												<fo:inline font-style="italic">
													<xsl:value-of select="."/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
								</xsl:for-each>
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
										<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text/>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="italic">
													
												</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
								<xsl:for-each select="//*[local-name()='Titular']//*[local-name()='Apellido2']">
									<fo:table-cell padding="2pt" display-align="center">
										<fo:block>
											<fo:inline-container>
												<fo:block>
													<xsl:text>&#x2029;</xsl:text>
												</fo:block>
											</fo:inline-container>
										</fo:block>
										<fo:block text-align="left" margin="0pt">
											<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
												<fo:inline font-weight="bold">
													<xsl:text>Segundo Apellido:</xsl:text>
													<fo:leader leader-pattern="space"/>
												</fo:inline>
												<fo:inline font-style="italic">
													<xsl:value-of select="."/>
												</fo:inline>
											</fo:block>
										</fo:block>
									</fo:table-cell>
								</xsl:for-each>
							</fo:table-row>
							<xsl:if test="(//*[local-name()='Titular']//*[local-name()='NombreCompleto'])">
								<fo:table-row>
									<xsl:for-each select="//*[local-name()='Titular']//*[local-name()='NombreCompleto']">
										<fo:table-cell padding="2pt" display-align="center">
											<fo:block>
												<fo:inline-container>
													<fo:block>
														<xsl:text>&#x2029;</xsl:text>
													</fo:block>
												</fo:inline-container>
											</fo:block>
											<fo:block text-align="left" margin="0pt">
												<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
													<fo:inline font-weight="bold">
														<xsl:text>Nombre Completo:</xsl:text>
														<fo:leader leader-pattern="space"/>
													</fo:inline>
													<fo:inline font-style="italic">
														<xsl:value-of select="."/>
													</fo:inline>
												</fo:block>
											</fo:block>
										</fo:table-cell>
									</xsl:for-each>
								</fo:table-row>
							</xsl:if>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</fo:block>
		</fo:block>
	</xsl:template>
	<xsl:template match="//*[local-name()='Transmision']">
		<fo:block>
			<fo:block>
				<fo:inline-container>
					<fo:block>
						<xsl:text>&#x2029;</xsl:text>
					</fo:block>
				</fo:inline-container>
			</fo:block>
			<fo:block text-align="left" margin="0pt">
				<fo:block font-size="14pt" font-family="Arial,Helvetica,sans-serif" line-height="16pt" space-after.optimum="3pt" text-align="justify" padding-top="20pt">
					<fo:table table-layout="fixed" width="100%" border="solid 1pt #F8F8FF" border-spacing="1pt">
						<fo:table-body start-indent="0pt">
							<fo:table-row>
								<fo:table-cell padding="1pt" display-align="center" background-color="#F8F8FF">
									<fo:block>
										<fo:inline font-weight="bold" display-align="after">
											<xsl:value-of select="local-name(.)"/>
										</fo:inline>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
				<fo:table table-layout="fixed" width="100%" border-spacing="2pt">
					<fo:table-body start-indent="0pt">
						<fo:table-row>
							<xsl:for-each select="//*[local-name()='Transmision']//*[local-name()='CodigoCertificado']">
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Código Certificado:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="italic">
												<xsl:value-of select="."/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
							<xsl:for-each select="//*[local-name()='Transmision']//*[local-name()='IdSolicitud']">
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Identificador Solicitud:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="italic">
												<xsl:value-of select="."/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
						</fo:table-row>
						<fo:table-row>
							<xsl:for-each select="//*[local-name()='Transmision']//*[local-name()='IdTransmision']">
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Identificador Transmisión:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="italic">
												<xsl:value-of select="."/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
							<xsl:for-each select="//*[local-name()='Transmision']//*[local-name()='FechaGeneracion']">
								<fo:table-cell padding="2pt" display-align="center">
									<fo:block>
										<fo:inline-container>
											<fo:block>
												<xsl:text>&#x2029;</xsl:text>
											</fo:block>
										</fo:inline-container>
									</fo:block>
									<fo:block text-align="left" margin="0pt">
										<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:text>Fecha Generación:</xsl:text>
												<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="italic">
												<xsl:value-of select="."/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</xsl:for-each>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</fo:block>
	</xsl:template>
	<xsl:template match="*">
		<fo:block>
			<xsl:choose>
				<xsl:when test="not(./*)">
					<fo:table table-layout="fixed" width="100%" border-spacing="2pt">
						<fo:table-column column-width="proportional-column-width(1)"/>
						<fo:table-body start-indent="0pt">
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
										<fo:block font-size="10pt" font-family="Arial,Helvetica,sans-serif" line-height="13pt" space-after.optimum="2pt" display-align="after">
											<fo:inline font-weight="bold">
												<xsl:value-of select="local-name(.)"/>:<fo:leader leader-pattern="space"/>
											</fo:inline>
											<fo:inline font-style="italic">
												<xsl:value-of select="."/>
											</fo:inline>
										</fo:block>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</xsl:when>
				<xsl:otherwise>
					<fo:inline-container>
						<fo:block>
							<xsl:text>&#x2029;</xsl:text>
						</fo:block>
					</fo:inline-container>
					<fo:block font-size="14pt" font-family="Arial,Helvetica,sans-serif" line-height="16pt" space-after.optimum="3pt" text-align="justify" padding-top="20pt">
						<fo:table table-layout="fixed" width="100%" border="solid 1pt #F8F8FF" border-spacing="1pt">
							<fo:table-body start-indent="0pt">
								<fo:table-row>
									<fo:table-cell padding="1pt" display-align="center" background-color="#F8F8FF">
										<fo:block>
											<fo:inline font-weight="bold" display-align="after">
												<xsl:value-of select="local-name(.)"/>
											</fo:inline>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
					<xsl:apply-templates select="./*"/>
				</xsl:otherwise>
			</xsl:choose>
		</fo:block>
	</xsl:template>
</xsl:stylesheet>
