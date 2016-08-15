package de.mxro.maven.tools.tests

import de.mxro.file.Jre.FilesJre
import de.mxro.maven.tools.WriteHashes
import java.io.File
import org.junit.Rule
import org.junit.Test
import org.junit.rules.TemporaryFolder

class TestGenerateHashes {
	
	@Rule
  public TemporaryFolder folder= new TemporaryFolder();
	
	@Test
	def void test() {
		
		val folder = FilesJre.wrap(folder.newFolder("test"))
		val pom = folder.createFile("pom.xml")
		
		pom.text = POM_CONTENT
		
		//WriteHashes.forFile(new File(pom.path).toPath)
		
		//println(folder.get("pom.xml.md5").text)
		
	
	}
	
	
	val static POM_CONTENT = '''<?xml version="1.0" encoding="UTF-8" standalone="no"?><!-- Template: Source 
		+ GWT + in workspace dependencies 27.11.2010 --><project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
		<groupId>org.javadelight</groupId>
		<artifactId>delight-nashorn-sandbox</artifactId>
		<version>0.0.6</version>
		<description>A safe sandbox to execute JavaScript code from Nashorn.</description>
		<url>https://github.com/javadelight/delight-nashorn-sandbox</url>
		
		<properties>
			<module.gwtVersion>2.5.1</module.gwtVersion>
			<module.importedPackages>
				org.junit,
				*
			</module.importedPackages>
			<module.exportedPackages>!delight.nashornsandbox.internal*,delight.nashornsandbox*
			</module.exportedPackages>
			<module.serviceDefinitions>
			</module.serviceDefinitions>
		</properties>
	
		<!-- Dependent Modules -->
		<dependencies>
	
			<dependency>
				<groupId>com.sun</groupId>
				<artifactId>tools</artifactId>
				<version>1.4.2</version>
				<scope>system</scope>
				<systemPath>${java.home}/../lib/tools.jar</systemPath>
			</dependency>
	
			<dependency>
				<groupId>org.eclipse.xtend</groupId>
				<artifactId>org.eclipse.xtend.lib</artifactId>
				<version>2.8.3</version>
			</dependency>
	
			<dependency>
				<groupId>junit</groupId>
				<artifactId>junit</artifactId>
				<version>4.7</version>
				<scope>test</scope>
			</dependency>
	
			<dependency>
				<groupId>org.javadelight</groupId>
				<artifactId>delight-async</artifactId>
				<version>0.0.9</version>
				
			</dependency>
	
		</dependencies>
	
	
		<!-- XXXXXXXXXXXXXX Maven declarations XXXXXXXXXXXXXXXXXX -->
	
		<modelVersion>4.0.0</modelVersion>
		<name>${project.artifactId}</name>
		<packaging>bundle</packaging>
		<build>
	
			<plugins>
				<plugin>
					<artifactId>maven-compiler-plugin</artifactId>
					<configuration>
						<source>1.8</source>
						<target>1.8</target>
					</configuration>
				</plugin>
				
				  <!-- <plugin>
					<groupId>org.apache.maven.plugins</groupId>
					<artifactId>maven-assembly-plugin</artifactId>
					<version>2.4</version>
					<executions>
						<execution>
							<goals>
								<goal>attached</goal>
							</goals>
							<phase>package</phase>
							<configuration>
								<descriptors>
									<descriptor>src/assemble/distribution.xml</descriptor>
								</descriptors>
	
							
							</configuration>
						</execution>
					</executions>
				</plugin> -->
				
	
	
				<!-- FOR BUNDLE MANAGEMENT -->
				<!-- The Maven bundle plugin generates Meta-data required for OSGi -->
	
				<plugin>
					<groupId>org.apache.felix</groupId>
					<artifactId>maven-bundle-plugin</artifactId>
					<extensions>true</extensions>
					<version>2.5.3</version>
					<configuration>
						<instructions>
							<Bundle-SymbolicName>${project.artifactId}</Bundle-SymbolicName>
							<Bundle-Version>${project.version}</Bundle-Version>
							<Import-Package>${module.importedPackages}</Import-Package>
							<Export-Package>${module.exportedPackages}</Export-Package>
							<Service-Component>${module.serviceDefinitions}
							</Service-Component>
							<Bundle-RequiredExecutionEnvironment>JavaSE-1.6
							</Bundle-RequiredExecutionEnvironment>
						</instructions>
					</configuration>
				</plugin>
	
	
				<!-- Keep the MANIFEST.MF used by eclipse in sync with the MANIFEST.MF 
					created by the maven bundle plugin -->
				<plugin>
					<artifactId>maven-antrun-plugin</artifactId>
					<executions>
						<execution>
							<phase>package</phase>
							<goals>
								<goal>run</goal>
							</goals>
							<configuration>
								<tasks>
									<delete file="${basedir}/META-INF/MANIFEST.MF"/>
									<copy file="target/classes/META-INF/MANIFEST.MF" tofile="${basedir}/META-INF/MANIFEST.MF"/>
								</tasks>
							</configuration>
						</execution>
					</executions>
				</plugin>
	
	
				<plugin>
					<groupId>org.codehaus.mojo</groupId>
					<artifactId>findbugs-maven-plugin</artifactId>
					<version>3.0.0</version>
				</plugin>
	
				<plugin>
					<groupId>org.apache.maven.plugins</groupId>
					<artifactId>maven-site-plugin</artifactId>
					<version>3.4</version>
					<configuration>
						<skipDeploy>true</skipDeploy>
	
						<reportPlugins>
							<plugin>
								<groupId>org.apache.maven.plugins</groupId>
								<artifactId>maven-project-info-reports-plugin</artifactId>
								<version>2.7</version>
								<reports>
									<report>index</report>
									<report>project-team</report>
									<report>license</report>
									<report>mailing-list</report>
									<report>dependencies</report>
									<report>dependency-convergence</report>
									<report>plugin-management</report>
									<report>cim</report>
									<report>issue-tracking</report>
									<report>scm</report>
									<report>summary</report>
								</reports>
							</plugin>
	
	
							<plugin>
								<groupId>org.apache.maven.plugins</groupId>
								<artifactId>maven-javadoc-plugin</artifactId>
								<version>2.9.1</version>
								<configuration>
									<links>
										<link>http://modules.appjangle.com/fn-api/latest/apidocs/</link>
										<link>http://modules.appjangle.com/async-api/latest/apidocs/</link>
										<link>http://modules.appjangle.com/service-api/latest/apidocs/</link>
										<link>http://modules.appjangle.com/async-map/latest/apidocs/</link>
										<link>http://modules.appjangle.com/factories/latest/apidocs/</link>
										<link>http://modules.appjangle.com/serializer-api/latest/apidocs/</link>
									</links>
								</configuration>
							</plugin>
	
							<plugin>
								<groupId>org.apache.maven.plugins</groupId>
								<artifactId>maven-jxr-plugin</artifactId>
								<version>2.1</version>
							</plugin>
	
							<plugin>
								<groupId>org.apache.maven.plugins</groupId>
								<artifactId>maven-surefire-report-plugin</artifactId>
								<version>2.6</version>
							</plugin>
	
							<plugin>
								<groupId>org.codehaus.mojo</groupId>
								<artifactId>findbugs-maven-plugin</artifactId>
								<version>3.0.0</version>
								<configuration>
									<xmlOutput>true</xmlOutput>
									<!-- Optional directory to put findbugs xdoc xml report -->
									<xmlOutputDirectory>target/site</xmlOutputDirectory>
								</configuration>
							</plugin>
	
							<plugin>
								<groupId>org.apache.maven.plugins</groupId>
								<artifactId>maven-pmd-plugin</artifactId>
								<version>2.5</version>
								<configuration>
									<linkXref>true</linkXref>
									<minimumTokens>100</minimumTokens>
									<minimumPriority>3</minimumPriority>
									<!-- Change minimum priority to see more or less messages -->
									<targetJdk>1.6</targetJdk>
								</configuration>
							</plugin>
	
							<plugin>
								<groupId>org.apache.maven.plugins</groupId>
								<artifactId>maven-checkstyle-plugin</artifactId>
								<version>2.6</version>
	
							</plugin>
							<plugin>
								<groupId>org.codehaus.mojo</groupId>
								<artifactId>jdepend-maven-plugin</artifactId>
								<version>2.0-beta-2</version>
							</plugin>
							<plugin>
								<groupId>org.codehaus.mojo</groupId>
								<artifactId>cobertura-maven-plugin</artifactId>
								<version>2.4</version>
							</plugin>
							<plugin>
								<groupId>org.codehaus.mojo</groupId>
								<artifactId>taglist-maven-plugin</artifactId>
								<version>2.4</version>
							</plugin>
	
	
	
	
	
						</reportPlugins>
					</configuration>
				</plugin>
	
			</plugins>
	
			<!-- RESOURCES -->
			<resources>
				<!-- Required to be valid GWT Library (requires *.java files in jar) -->
	
				<resource>
					<directory>src/main/java</directory>
					<includes>
						<include>**/*.java</include>
						<include>**/*.gwt.xml</include>
					</includes>
				</resource>
	
				<!-- This entry makes sure that resources, which lie in the same package 
					as Java classes, are copied into the target. Often external libraries require 
					resources, which are loaded using Class.getResource or Class.getResourceAsStream 
					and which are in a subpackage of the class. For instance, the NetBeans template 
					for the Swing Application Framework does so. -->
				<resource>
					<filtering>false</filtering>
					<directory>src/main/java</directory>
					<includes>
						<include>**</include>
					</includes>
					<excludes>
						<exclude>**/*.java</exclude>
					</excludes>
				</resource>
	
	
	
			</resources>
	
	
		</build>
	
	
		<repositories>
			<repository>
				<id>Appjangle Releases</id>
				<url>http://maven.appjangle.com/appjangle/releases</url>
			</repository>
		</repositories>
	
		<developers>
			<developer>
				<id>mxro</id>
				<name>Max Rohde</name>
				<email>noemail@mxro.de</email>
				<url>http://www.mxro.de/</url>
				<roles>
					<role>architect</role>
					<role>developer</role>
				</roles>
				<timezone>+10</timezone>
				<organization>pureleap</organization>
				<organizationUrl>http://pureleap.com</organizationUrl>
			</developer>
		</developers>
	
	
	
	</project>'''
	
}