<?xml version="1.0" encoding="utf-8" ?>
<updates>
	<!--
	Remember to update the internalversion number on all releases of Dynamicweb, and update the corresponding versionnumber
	in AssemblyInfo.vb (AssemblyInformationalVersionAttribute). Rules for version number can be found there as well.
	Internal Version number in updates.xml and ecom.xml has to be the same.
	-->
    <current version="954" releasedate="08-09-2015" internalversion="8.7.0.1" /> 
        
    <package version="954" releasedate="02-09-2015" internalversion="8.7.0.0">
        <setting key="/Globalsettings/Modules/UserManagement/EncryptNewPasswords" value="true" overwrite="true" />
    </package>
    
    <package version="953" releasedate="04-08-2015" internalversion="8.7.0.0">
        <database file="Access.mdb">
            <AccessUser>                
	            <sql conditional="">
                    ALTER TABLE [AccessUser] ADD
                    [AccessUserItemType] NVARCHAR(255) NULL,
                    [AccessUserItemId] NVARCHAR(255) NULL,
                    [AccessUserDefaultUserItemType] NVARCHAR(255) NULL
                </sql>
	        </AccessUser>
        </database>
    </package>

    <package version="952" releasedate="28-07-2015" internalversion="8.7.0.0">
        <database file="Access.mdb">
            <FolderPermission>
                <sql conditional="">
                    ALTER TABLE [AccessElementPermission] ADD
                        [AccessElementPermissionWriteTypePermission] nvarchar(50) NULL
                </sql>
            </FolderPermission>
        </database>
    </package>

    <package version="951" releasedate="02-07-2015" internalversion="8.7.0.0">
        <database file="Statisticsv2.mdb">
            <NonBrowserSession>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_NonBrowserSession_SessionId_EmailClient] ON [NonBrowserSession]
                    (
	                    [SessionSessionId] ASC,
	                    [SessionUserAgentEmailClient] ASC
                    )
                </sql>
                <sql conditional="">
                    DROP INDEX [DW_IX_NonBrowserSession_SessionId] ON [NonBrowserSession]
                </sql>
            </NonBrowserSession>
        </database>
    </package>

     <package version="950" releasedate="15-06-2015" internalversion="8.7.0.0">
        <database file="Dynamic.mdb">
            <Clustering>
                <sql conditional="">
                    ALTER TABLE ClusteringInstance ADD InstanceHostName  nvarchar(255) NULL 
                </sql>
            </Clustering>
        </database>
    </package>
	<package version="949" date="05-05-2015" internalversion="8.7.0.0">
		<database file="Dynamic.mdb">
		    <page>
			    <sql conditional="">
                    ALTER TABLE [Area] ADD
	                    [AreaIsCdnActive] bit NULL,
	                    [AreaCdnHost] nvarchar(255) NULL,
	                    [AreaCdnImageHost] nvarchar(255) NULL 
			    </sql>
		    </page>
		</database>
	</package>

     <package version="948" releasedate="29-04-2014" internalversion="8.7.0.0">
        <database file="Dynamic.mdb">
            <QueryPublisher>
                <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'QueryPublisher'">
                    INSERT INTO [Module]
                    ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleParagraph], [ModuleIsBeta], [ModuleParagraphEditPath])
                    VALUES
                    ('QueryPublisher', 'Query publisher', blnTrue, blnTrue, blnTrue, '/Admin/Module/QueryPublisher')
                </sql>
            </QueryPublisher>
        </database>
         <file name="List.cshtml" source="/Files/Templates/QueryPublisher" target="/Files/Templates/QueryPublisher" overwrite="false" />   
    </package>

    <package version="947" releasedate="22-04-2015" internalversion="8.7.0.0">
        <database file="Dynamic.mdb">
            <SmsMessage>                
				<sql conditional="">
                    UPDATE [Module] SET [ModuleIsBeta] = blnFalse WHERE [ModuleSystemName] = 'Sms'
                </sql>
            </SmsMessage>
        </database>
    </package>

    <package  version="946" releasedate="30-03-2015" internalversion="8.7.0.0">
        <file name="ItemCreator.css" source="/Files/Templates/ItemCreator" target="/Files/Templates/ItemCreator" />
        <file name="Edit.html" source="/Files/Templates/ItemPublisher/Edit" target="/Files/Templates/ItemPublisher/Edit" />
    </package>

    <package version="945" releasedate="26-03-2015" internalversion="8.7.0.0">
    </package>

    <package version="944" releasedate="26-03-2015" internalversion="8.7.0.0">
        <database file="Dynamic.mdb">
            <Module>
                <sql conditional="">
                    IF EXISTS (SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Form' AND [ModuleAccess] = blnTrue)
                        UPDATE [Module] SET [ModuleAccess] = blnTrue WHERE [ModuleSystemName] = 'BasicForms'                   
                </sql>
            </Module>
        </database>
    </package>

    <package version="943" releasedate="17-03-2015" internalversion="8.7.0.0">
        <database file="Dynamic.mdb">
		<sql conditional="">
			CREATE TABLE [FormRule]
            (
	            [FormRuleId] int IDENTITY(1,1) NOT NULL,
		        [FormRuleType] int NULL DEFAULT ((0)),
		        [FormRuleFormID] int NULL,
	            [FormRuleName] nvarchar(255) NULL,
	            [FormRuleActive] bit NULL DEFAULT ((1)),
	            [FormRuleMessage] nvarchar(MAX) NULL,
		        CONSTRAINT [DW_PK_FormRule] PRIMARY KEY CLUSTERED ([FormRuleId] ASC)
        	)
		</sql>
		<sql conditional="">
			CREATE TABLE [FormRuleCondition]
            (
	            [FormRuleConditionId] int IDENTITY(1,1) NOT NULL,
                [FormRuleConditionSort] int NULL DEFAULT ((1)),
                [FormRuleConditionOperatorPrevious] int NULL DEFAULT ((0)),
	            [FormRuleConditionRuleId] int NULL,
	            [FormRuleConditionFieldId] int NULL,
	            [FormRuleConditionType] int NULL,
	            [FormRuleConditionParam1] nvarchar(MAX) NULL,
                [FormRuleConditionParam2] nvarchar(MAX) NULL,
	            CONSTRAINT [DW_PK_FormRuleCondition] PRIMARY KEY CLUSTERED ([FormRuleConditionId] ASC)
            )
		</sql>				
        </database>
    </package>

	 <package version="942" releasedate="13-03-2015" internalversion="8.6.1.0">
        <database file="Dynamic.mdb">
            <form>
                <sql conditional="">
					ALTER TABLE Form ADD [FormFieldSize] int NULL
                </sql>
            </form>
        </database>
    </package>
    
	 <package version="941" releasedate="13-03-2015" internalversion="8.6.1.0">
        <database file="Dynamic.mdb">
            <form>
                <sql conditional="">
					ALTER TABLE FormSubmit ADD [FormSubmitPageId] int NULL
                </sql>
            </form>
        </database>
    </package>

    <package version="940" releasedate="10-03-2015" internalversion="8.6.1.0">
        <database file="Dynamic.mdb">
            <Clustering>
                <sql conditional="">
                    ALTER TABLE ClusteringInstance ADD InstanceEnabled BIT NOT NULL DEFAULT 0
                </sql>
            </Clustering>
        </database>
    </package>

    <package version="939" date="06-03-2014" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
	        <Page>                
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [IX_Page_Item] ON [Page] ( [PageItemId] ASC, [PageItemType] ASC )
                </sql>
            </Page>
            <Paragraph>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [IX_Paragraph_Item] ON [Paragraph] ( [ParagraphItemId] ASC, [ParagraphItemType] ASC )
                </sql>
	        </Paragraph>
        </database>        
    </package>

    <package version="938" releasedate="11-02-2015" internalversion="8.6.0.0">
        <file name="user_details.html" source="/Files/Templates/UserManagement/UserProvider" target="/Files/Templates/UserManagement/UserProvider" overwrite="false" />        
    </package>

	<package version="937" releasedate="09-02-2015" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
            <Module>
                <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'BasicForms'">
                    INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleIsBeta], [ModuleAccess], [ModuleParagraph], [ModuleScript])
                    VALUES ('BasicForms', 'Forms for editors', blnFalse, blnFalse, blnTrue, 'BasicForms/ListForms.aspx')
                </sql>
            </Module>
        </database>
    </package>
	 <package version="936" releasedate="09-02-2015" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
            <form>
                <sql conditional="">
					ALTER TABLE Form
ADD
[FormMaxSubmits] int NULL,
[FormDefaultTemplate] NVARCHAR(255) NULL,
[FormCssClass] NVARCHAR(255) NULL,
[FormCreatedDate] datetime NULL,
[FormUpdatedDate] datetime NULL,
[FormCreatedBy] int NULL,
[FormUpdatedBy] int NULL
					</sql>
				<sql conditional="">

ALTER TABLE FormField
ADD
[FormFieldCreatedDate] datetime NULL,
[FormFieldUpdatedDate] datetime NULL,
[FormFieldCreatedBy] int NULL,
[FormFieldUpdatedBy] int NULL,
[FormFieldGroupID] int NULL,
[FormFieldCssClass] NVARCHAR(255) NULL,
[FormFieldPlaceholder] NVARCHAR(255) NULL,
[FormFieldDescription] NVARCHAR(MAX) NULL,
[FormFieldPrepend] NVARCHAR(255) NULL,
[FormFieldAppend] NVARCHAR(255) NULL
					</sql>
				<sql conditional="">
						CREATE TABLE [FormSubmit]
(
	[FormSubmitID] int IDENTITY(1,1) NOT NULL,
	[FormSubmitFormID] int NULL DEFAULT ((0)),
	[FormSubmitDate] datetime NULL DEFAULT (getdate()),
	[FormSubmitIp] nvarchar(30) NULL,
	[FormSubmitSessionId] nvarchar(30) NULL,
					CONSTRAINT [DW_PK_FormSubmit] PRIMARY KEY CLUSTERED ([FormSubmitID] ASC)
)
					</sql>
				<sql conditional="">
					CREATE TABLE [FormSubmitData](
	[FormSubmitDataID] int IDENTITY(1,1) NOT NULL,
	[FormSubmitDataSubmitID] int NULL DEFAULT ((0)),
	[FormSubmitDataFieldID] int NULL DEFAULT ((0)),
	[FormSubmitDataFieldname] nvarchar(255) NULL,
	[FormSubmitDataValue] nvarchar(max) NULL
					CONSTRAINT [DW_PK_FormSubmitData] PRIMARY KEY CLUSTERED ([FormSubmitDataID] ASC))

					</sql>
            </form>
        </database>
    </package>
	

    <package version="935" releasedate="30-01-2015" internalversion="8.6.1.0">
      <invoke type="Dynamicweb.Content.Management.UpdateScripts, Dynamicweb" method="FixSmartSearchCategoryRules" />
    </package>
     
    <package version="934" releasedate="19-01-2015" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
            <Clustering>
                <sql conditional="">
                    Alter table ClusteringInstance alter column	InstanceIP  nvarchar(15) NULL
                </sql>
            </Clustering>
        </database>
    </package>

    <package version="933" releasedate="19-01-2015" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
            <Clustering>
                <sql conditional="">
                    CREATE TABLE [ClusteringInstance]
                    (
                        [InstanceId] int IDENTITY(1,1) NOT NULL,
                        [InstanceName] nvarchar(255) NULL,
                                                [InstanceMachineName] nvarchar(255) NULL,
                                                [InstanceIP] nvarchar(15) NULL,
                                                [InstanceStartup] datetime NULL,
                                                [InstanceUpdateDate] datetime NULL,
                        CONSTRAINT ClusteringInstance_PrimaryKey PRIMARY KEY([InstanceId])
                    )
                </sql>
            </Clustering>
        </database>
    </package>

    <package version="932" releasedate="19-01-2015" internalversion="8.6.0.0">
        <file name="ListForumPublicUnsubscribe.html" source="/Files/Templates/BasicForum/ListForum" target="/Files/Templates/BasicForum/ListForum" overwrite="false" />
        <file name="ListThreadActivationPublicUnsubscribe.html" source="/Files/Templates/BasicForum/ListThread" target="/Files/Templates/BasicForum/ListThread" overwrite="false" />
        <file name="ListThreadPublicUnsubscribe.html" source="/Files/Templates/BasicForum/ListThread" target="/Files/Templates/BasicForum/ListThread" overwrite="false" />
        <file name="ShowThreadPublicUnsubscribe.html" source="/Files/Templates/BasicForum/ShowThread" target="/Files/Templates/BasicForum/ShowThread" overwrite="false" />
        <file name="UpdatePublicUnsubscribe.html" source="/Files/Templates/BasicForum/Subscription" target="/Files/Templates/BasicForum/Subscription" overwrite="false" />
    </package>

      <package version="931" releasedate="13-01-2015" internalversion="8.6.0.0">
        <database file="Access.mdb">
            <Modules>                
                <sql conditional="">
                    delete from module where ModuleSystemName='QuerySandbox'
                </sql>
            </Modules>
        </database>
    </package>  

    <package version="930" releasedate="12-01-2015" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    ALTER TABLE EmailMarketingEmail ADD EmailIncludePlainTextContent BIT NULL
                </sql>
                <sql conditional="">
                    ALTER TABLE EmailMarketingEmail ADD EmailPlainTextContent NVARCHAR(MAX) NULL
                </sql>
                <sql conditional="">
                    ALTER TABLE EmailMessage ADD MessageIncludePlainTextBody BIT NULL
                </sql>
                <sql conditional="">
                    ALTER TABLE EmailMessage ADD MessagePlainTextBody NVARCHAR(MAX) NULL
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="929" releasedate="02-01-2015" internalversion="8.6.0.0">
        <database file="Access.mdb">
            <AccessUser>                
                <sql conditional="">
                    ALTER TABLE [AccessUser] ADD [AccessUserExported] DATETIME NULL
                </sql>
            </AccessUser>
            <AccessUserAddress>                
                <sql conditional="">
                    ALTER TABLE [AccessUserAddress] ADD [AccessUserAddressExported] DATETIME NULL
                </sql>
            </AccessUserAddress>
        </database>
    </package>  

    <package version="928" releasedate="15-12-2014" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
            <EmailMessaging>
                <sql conditional="">
                    ALTER TABLE EmailMessage ADD MessageQuarantinePeriod INT NULL
                </sql>
            </EmailMessaging>
        </database>
    </package>

    <package version="927" releasedate="12-12-2014" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    ALTER TABLE EmailMarketingEmail ADD EmailQuarantinePeriod INT NULL
                </sql>
                <sql conditional="">
                    ALTER TABLE EmailMarketingTopFolder ADD TopFolderQuarantinePeriod INT NULL
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="926" releasedate="12-12-2014" internalversion="8.6.0.0">
        <database file="Access.mdb">
            <AccessUser>
                <sql conditional="">
                    ALTER TABLE [AccessUser] DROP [GroupSmartSearch], [LastCalculated]
                </sql> 
                <sql conditional="">
                    ALTER TABLE [AccessUser] ADD [AccessUserGroupSmartSearch] NVARCHAR(50) NULL,
                                                 [AccessUserGroupSmartSearchLastCalculatedTime] DATETIME NULL
                </sql>
            </AccessUser>
        </database>
    </package>  

    <package version="925" releasedate="11-12-2014" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
            <TrashBin>
				<sql conditional="">ALTER TABLE [TrashBin] ADD [TrashBinItemValue] NVARCHAR(MAX) NULL</sql>
			</TrashBin>			                  
        </database>
    </package>

   <package version="924" releasedate="10-12-2014" internalversion="8.6.0.0">
        <database file="Access.mdb">
            <AccessUser>
                <sql conditional="">
                    ALTER TABLE [AccessUser] DROP [RecalculateInterval]
                </sql>                  
            </AccessUser>
        </database>
    </package>

    <package version="923" releasedate="28-11-2014" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
            <Page>
				<sql conditional="">ALTER TABLE [Page] ADD [PageNavigationProvider] NVARCHAR(255) NULL</sql>
			</Page>			                  
        </database>
    </package>

    <package version="921" date="6-11-2014" internalversion="8.6.0.0">
        <file name="login.html" source="/Files/Templates/UserManagement/Login/" target="/Files/Templates/UserManagement/Login/" overwrite="true"/>
        <file name="password_reset.html" source="/Files/Templates/UserManagement/Login/" target="/Files/Templates/UserManagement/Login/" overwrite="true"/>
        <file name="password_recovery.html" source="/Files/Templates/UserManagement/Login/" target="/Files/Templates/UserManagement/Login/" overwrite="true"/>
    </package>

    <package version="919" date="31-10-2014" internalversion="8.6.0.0">
        <database file="Access.mdb">
	        <AccessUser>
                <sql conditional="">
                    ALTER TABLE [AccessUser] ADD [AccessUserPasswordRecoveryToken] NVARCHAR(128) NULL,
                                                 [AccessUserPasswordRecoveryTokenExpirationTime] DateTime NULL
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_AccessUser_AccessUserPasswordRecoveryToken] ON [AccessUser] 
                    (
	                    [AccessUserPasswordRecoveryToken] ASC
                    )
                </sql>
	        </AccessUser>
        </database>
        
        <file name="login.html" source="/Files/Templates/UserManagement/Login/" target="/Files/Templates/UserManagement/Login/" overwrite="false"/>
        <file name="password_recovery_email.html" source="/Files/Templates/UserManagement/Login/" target="/Files/Templates/UserManagement/Login/" overwrite="false"/>
    </package>

    <package version="918" releasedate="23-10-2014" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
            <RecommendationModel>
                <sql conditional="">
                    ALTER TABLE [RecommendationModel] ADD [RecommendationModelServiceModelData] NVARCHAR(MAX) NULL,
                                                          [RecommendationModelRecommendationsCacheLifetime] INT NULL,
                                                          [RecommendationModelExportRebuildServiceModel] BIT NULL
                </sql>
            </RecommendationModel>
        </database>
    </package>

    <package version="917" releasedate="21-10-2014" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
            <Discount>
	            <sql conditional="">ALTER TABLE [EcomDiscount] ADD [DiscountProductIdByDiscount] NVARCHAR(30) NULL, 
                                                                   [DiscountProductVariantIdByDiscount] nvarchar(255) NULL
                </sql>
            </Discount>
        </database>
     </package>

    <package version="916" date="15-10-2014" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
	        <Module>
                <sql conditional="">
                    UPDATE [Module] SET ModuleIsBeta = 0 WHERE ModuleSystemName = 'eCom_DataIntegrationERPBatch'
                </sql>
                <sql conditional="">
                    UPDATE [Module] SET ModuleIsBeta = 0 WHERE ModuleSystemName = 'eCom_DataIntegrationERPLiveIntegration'
                </sql>
                <sql conditional="">
                    UPDATE [Module] SET ModuleIsBeta = 0 WHERE ModuleSystemName = 'eCom_IntegrationCustomerCenter'
                </sql>
	        </Module>
        </database>
    </package>

    <package version="915" releasedate="13-10-2014" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
            <Page>
	            <sql conditional="">
	                ALTER TABLE [ItemTypeDefinitions] ADD [ItemTypeDefinitionsModified] datetime NOT NULL
	            </sql>
            </Page>
        </database>
    </package>

    <package version="914" releasedate="08-10-2014" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
            <Module>
                <sql conditional="">ALTER TABLE [NonBrowserSession] ADD [SessionUserAgentEmailClient] NVARCHAR(50) NULL</sql>
            </Module>
        </database>
    </package>

    <package version="913" releasedate="07-10-2014" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
            <Module>
                <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'LoadBalancing'">
                    INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleIsBeta], [ModuleAccess], [ModuleParagraph])
                    VALUES ('LoadBalancing', 'Load balancing', blnFalse, blnFalse, blnFalse)
                </sql>
            </Module>
        </database>
    </package>

    <package version="912" releasedate="03-10-2014" internalversion="8.6.0.0">
        <database file="Statistics.mdb">
            <StatExtranet>
                <sql conditional="">
                    CREATE TABLE [StatExtranet] (
	                    [StatExtranetAccessUserID] INT NULL,
	                    [StatExtranetTimeStamp] DATETIME NULL,
	                    [StatExtranetPageID] INT NULL
                    )
                </sql>
            </StatExtranet>
        </database>
    </package>

    <package version="911" releasedate="30-09-2014" internalversion="8.6.0.0">
        <file name="Search words - Top 5.xml" target="Files/System/OMC/Reports/Marketing reports/Search Words" source="Files/System/OMC/Reports/Search Words" overwrite="true"/>
        <file name="Search words.xml" target="Files/System/OMC/Reports/Marketing reports/Search Words" source="Files/System/OMC/Reports/Search Words" overwrite="true"/>
        <file name="Search words - No results.xml" target="Files/System/OMC/Reports/Marketing reports/Search Words" source="Files/System/OMC/Reports/Search Words" overwrite="true"/>
    </package>

    <package version="910" date="30-09-2014" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
            <Page>
                 <sql conditional="">UPDATE [Module] SET [ModuleName] = 'Personalization' WHERE [ModuleSystemName] = 'Profiling' AND [ModuleName] ='Profiling' </sql>
            </Page>
        </database>
    </package>

    <package version="909" date="17-09-2014" internalversion="8.5.1.0">
        <database file="Dynamic.mdb">
            <Page>
                 <sql conditional="">UPDATE [Page] SET [PageSort] = 999 WHERE [PageSort] = 100 AND [PageMenuText] = 'Page templates'</sql>
            </Page>
        </database>
    </package>

    <package version="908" date="05-09-2014" internalversion="8.5.1.0">
        <database file="Dynamic.mdb">
	        <Module>
	        <sql conditional="">UPDATE [Module] SET ModuleIsBeta = 0 WHERE ModuleSystemName = 'ItemCreator'</sql>
	        </Module>
        </database>
    </package>

    <package version="906" releasedate="15-08-2014" internalversion="8.5.0.0">
        <file name="Recommendation.cshtml" source="/Files/Templates/Recommendation/" target="/Files/Templates/Recommendation/" overwrite="false"/>
        <file name="Recommendation.angularjs.cshtml" source="/Files/Templates/Recommendation/" target="/Files/Templates/Recommendation/" overwrite="false"/>
        <file name="recommendation.js" source="/Files/Templates/Recommendation/javascripts/" target="/Files/Templates/Recommendation/javascripts/" overwrite="false"/>
    </package>

    <package version="905" releasedate="11-08-2014" internalversion="8.5.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketingSplitTest>
                <sql conditional="">
                     ALTER TABLE [EmailMarketingSplitTest] ADD [SplitTestWinnerEndDate] DATETIME NULL                    
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_SplitTest_SplitTestWinnerEndDate] ON [EmailMarketingSplitTest] 
                    (
	                    [SplitTestWinnerEndDate] ASC
                    )
                </sql>
            </EmailMarketingSplitTest>            
        </database>
    </package>

    <package version="904" releasedate="29-07-2014" internalversion="8.5.0.0">
        <database file="Dynamic.mdb">
            <RecommendationModel>
                <sql conditional="">
                    CREATE TABLE [RecommendationModel] (
                        [RecommendationModelId]                     IDENTITY       NOT NULL,
                        [RecommendationModelServiceUrl]             NVARCHAR (255) NULL,
                        [RecommendationModelServiceClientId]        NVARCHAR (255) NULL,
                        [RecommendationModelServiceModelId]         NVARCHAR (255) NULL,
                        [RecommendationModelServiceModelParameters] NVARCHAR (MAX) NULL,
                        [RecommendationModelName]                   NVARCHAR (255) NULL,
                        [RecommendationModelExportDataType]         NVARCHAR (255) NULL,
                        [RecommendationModelExportStartTime]        DATETIME       NULL,
                        [RecommendationModelExportInterval]         INT            NULL,
                        [RecommendationModelExportStatus]           NVARCHAR (255) NULL,
                        [RecommendationModelExportStartedAt]        DATETIME       NULL,
                        [RecommendationModelExportFinishedAt]       DATETIME       NULL,
                        CONSTRAINT [DW_PK_RecommendationModel] PRIMARY KEY CLUSTERED ([RecommendationModelId] ASC)
                    )
                </sql>
            </RecommendationModel>
            <Module>
                <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Recommendation'">
                    INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleIsBeta], [ModuleAccess], [ModuleParagraph])
                    VALUES ('Recommendation', 'Recommendation', 1, 0, 1)
                </sql>
            </Module>
        </database>
    </package>

    <package version="903" releasedate="25-07-2014" internalversion="8.5.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] ADD [EmailLastExportDate] DATETIME NULL
                </sql>                
            </EmailMarketing>
        </database>
    </package>
    <package version="902" releasedate="24-07-2014" internalversion="8.5.0.0">
        <database file="Dynamic.mdb">
            <AccessUser>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_AccessUser_AccessUserCreatedOn] ON [AccessUser] 
                    (
	                    [AccessUserCreatedOn] ASC
                    )
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_AccessUser_AccessUserUpdatedOn] ON [AccessUser] 
                    (
	                    [AccessUserUpdatedOn] ASC
                    )
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_AccessUser_AccessUserCreatedBy] ON [AccessUser] 
                    (
	                    [AccessUserCreatedBy] ASC
                    )
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_AccessUser_AccessUserUpdatedBy] ON [AccessUser] 
                    (
	                    [AccessUserUpdatedBy] ASC
                    )
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_AccessUser_AccessUserEmailPermissionUpdatedOn] ON [AccessUser] 
                    (
	                    [AccessUserEmailPermissionUpdatedOn] ASC
                    )
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_AccessUser_AccessUserLastLoginOn] ON [AccessUser] 
                    (
	                    [AccessUserLastLoginOn] ASC
                    )
                </sql>
            </AccessUser>
        </database>
    </package>
    <package version="901" releasedate="24-07-2014" internalversion="8.5.0.0">
        <database file="Dynamic.mdb">
            <AccessUser>
                <sql conditional="">
                    ALTER TABLE [AccessUser] ADD [AccessUserLastOrderDate]  datetime NULL
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_AccessUser_AccessUserLastOrderDate] ON [AccessUser] 
                    (
	                    [AccessUserLastOrderDate] ASC
                    )
                </sql>
            </AccessUser>
        </database>
    </package>   
	<package version="899" releasedate="21-07-2014" internalversion="8.5.0.0">
        <database file="Dynamic.mdb">
            <SmsMessage>
                <sql conditional="">
                    CREATE TABLE [SmsMessage]
                    (
                        [SmsMessageID] IDENTITY NOT NULL,
                        [SmsMessageName] nvarchar(max) NULL,
						[SmsMessageText] nvarchar(max) NULL,
						[SmsMessageSendToGroup] nvarchar(max) NULL,
						[SmsMessageCreated] datetime NULL,
						[SmsMessageUpdated] datetime NULL,
						[SmsMessageCreatedBy] int NULL,
						[SmsMessageUpdatedBy] int NULL,
						[SmsMessageRecipientCount] int NULL,
						[SmsMessageFirstMessageSent] datetime NULL,
						[SmsMessageLastMessageSent] datetime NULL,
                        [SmsMessageDeliveredCount] int NULL,
                        CONSTRAINT SmsMessage_PrimaryKey PRIMARY KEY([SmsMessageID])
                    
                    )
                </sql>
            </SmsMessage>
        </database>
    </package>
<package version="898" releasedate="21-07-2014" internalversion="8.5.0.0">
		<database file="Dynamic.mdb">
            <Module>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Sms'">
				INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleParagraph], [ModuleIsBeta], [ModuleScript])
									   VALUES ('Sms', 'Sms', blnFalse, blnFalse, blnTrue, 'Sms/SmsList.aspx')
				</sql>
			</Module>
		</database>
    </package>

	<package version="897" releasedate="10-07-2014" internalversion="8.5.0.0">
        <database file="Dynamic.mdb">
            <SmsMessage>
                <sql conditional="">
                    ALTER TABLE [SmsMessage] ADD [SmsMessageDeliveredCount]  int NULL
                </sql>
				<sql conditional="">
                    UPDATE [Module] SET [ModuleScript] = '' WHERE [ModuleSystemName] = 'Sms'
                </sql>
            </SmsMessage>
        </database>
    </package>
    <package version="896" releasedate="15-07-2014" internalversion="8.5.0.0">
        <database file="Dynamic.mdb">
            <OMCParagraphSegment>
                <sql conditional="">
                    CREATE TABLE [OMCParagraphSegment]
                    (
                    ParagraphSegmentID IDENTITY NOT NULL,
                    ParagraphSegmentParagraphID INT NOT NULL,
                    ParagraphSegmentShowAsDefault BIT NOT NULL DEFAULT blnTrue,
                    CONSTRAINT DW_PK_OMCParagraphSegment PRIMARY KEY CLUSTERED (ParagraphSegmentID ASC)
                    )
                </sql>
		        <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_OMCParagraphSegmentParagraph] 
                    ON [OMCParagraphSegment] (
                        [ParagraphSegmentParagraphID] ASC
                    )
                    INCLUDE 
                        ([ParagraphSegmentID])                    
                </sql>
                <sql conditional="">
                    CREATE TABLE [OMCParagraphSegmentSelection]
                    (
                    ParagraphSegmentSelectionID IDENTITY NOT NULL,
                    ParagraphSegmentSelectionSegmentID INT NOT NULL,
                    ParagraphSegmentSelectionSmartSearchID NVARCHAR(50) NOT NULL,
                    ParagraphSegmentSelectionSelected BIT NOT NULL DEFAULT blnFalse,
                    CONSTRAINT DW_PK_OMCParagraphSegmentSelection PRIMARY KEY CLUSTERED (ParagraphSegmentSelectionID ASC)
                    )
                </sql>
		        <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_OMCParagraphSegmentSelectionSegment] 
                    ON [OMCParagraphSegmentSelection] (
                        [ParagraphSegmentSelectionSegmentID] ASC
                    )
                    INCLUDE 
                        ([ParagraphSegmentSelectionID])                    
                </sql>

                <sql conditional="">
                    CREATE TABLE [OMCParagraphSegment]
                    (
                    ParagraphSegmentID INT NOT NULL,
                    ParagraphSegmentParagraphID INT NOT NULL,
                    ParagraphSegmentShowAsDefault BIT NOT NULL ,
                    CONSTRAINT DW_PK_OMCParagraphSegment PRIMARY KEY (ParagraphSegmentID )
                    )
                </sql>
		        <sql conditional="">
                    CREATE INDEX [DW_IX_OMCParagraphSegmentParagraph] 
                    ON [OMCParagraphSegment] (
                        [ParagraphSegmentParagraphID] ASC
                    )                 
                </sql>
                <sql conditional="">
                    CREATE TABLE [OMCParagraphSegmentSelection]
                    (
                    ParagraphSegmentSelectionID INT NOT NULL,
                    ParagraphSegmentSelectionSegmentID INT NOT NULL,
                    ParagraphSegmentSelectionSmartSearchID VARCHAR(50) NOT NULL,
                    ParagraphSegmentSelectionSelected BIT NOT NULL ,
                    CONSTRAINT DW_PK_OMCParagraphSegmentSelection PRIMARY KEY  (ParagraphSegmentSelectionID )
                    )
                </sql>
		        <sql conditional="">
                    CREATE INDEX [DW_IX_OMCParagraphSegmentSelectionSegment] 
                    ON [OMCParagraphSegmentSelection] (
                        [ParagraphSegmentSelectionSegmentID] ASC
                    )
                </sql>
            </OMCParagraphSegment>
        </database>
    </package>

    <package version="895" releasedate="04-07-2014" internalversion="8.5.0.0">
        <database file="Dynamic.mdb">
            <NamedItemList>
                <sql conditional="">
                    CREATE TABLE [ItemNamedItemList]
                    (
                    ItemNamedItemListId IDENTITY NOT NULL,
                    ItemNamedItemListName NVARCHAR(255) NOT NULL,
                    ItemNamedItemListSourceType NVARCHAR(50) NOT NULL,
                    ItemNamedItemListSourceId BIGINT NOT NULL,
                    ItemNamedItemListItemListId INT NOT NULL,
                    CONSTRAINT DW_PK_ItemNamedItemList PRIMARY KEY CLUSTERED (ItemNamedItemListId ASC)
                    )
                </sql>
		        <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_ItemNamedItemListName] 
                    ON [ItemNamedItemList] (
                        [ItemNamedItemListName] ASC
                    )
                    INCLUDE 
                        ([ItemNamedItemListId])                    
                </sql>
		        <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_ItemNamedItemListSource] 
                    ON [ItemNamedItemList] (
                        [ItemNamedItemListSourceType] ASC,
                        [ItemNamedItemListSourceId] ASC
                    )
                    INCLUDE 
                        ([ItemNamedItemListId])                    
                </sql>
            </NamedItemList>
        </database>
    </package>

    <package version="894" releasedate="02-07-2014" internalversion="8.5.0.0">
        <setting key="/Globalsettings/Settings/Dictionary/HideOldTranslationButton" value="false" overwrite="false" />
    </package>

    <package version="893" releasedate="01-07-2014" internalversion="8.5.0.0">
        <database file="Dynamic.mdb">
            <VAT>
                <sql conditional="">
                    ALTER TABLE [Area] ADD [AreaEcomPricesWithVat] NVARCHAR(10)
                </sql>
            </VAT>
        </database>
    </package>

    <package version="892" releasedate="12-11-2013" internalversion="8.4.0.0">
      <invoke type="Dynamicweb.Content.Management.UpdateScripts, Dynamicweb" method="MakeInheritableItemTypes" />
    </package>

    <package version="891" releasedate="27-06-2014" internalversion="8.5.0.0">
        <setting key="/Globalsettings/Modules/UserManagement/ExtranetPasswordSecurity/LoginAttempts" value="3" overwrite="false" />
    </package>

    <package version="890" releasedate="24-06-2014" internalversion="8.5.0.0">
        <setting key="/Globalsettings/Modules/UserManagement/ExtranetPasswordSecurity/PeriodLoginFailure" value="10" overwrite="false" />
        <setting key="/Globalsettings/Modules/UserManagement/ExtranetPasswordSecurity/BlockingPeriod" value="10" overwrite="false" />
    </package>

    <package version="889" releasedate="23-06-2014" internalversion="8.4.1.0">
        <file name="ListThreadActivation.html" source="/Files/Templates/BasicForum/ListThread" target="/Files/Templates/BasicForum/ListThread" overwrite="false" />
    </package>

    <package version="888" date="16-06-2014" internalversion="8.5.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketingTopFolder>
                <sql conditional="">ALTER TABLE [EmailMarketingTopFolder] ADD [TopFolderRecipientProviderConfiguration] NVARCHAR(MAX) NULL</sql>
            </EmailMarketingTopFolder>
        </database>
    </package>

    <package version="887"  releasedate="10-06-2014" internalversion="8.5.0.0">
        <database file="Dynamic.mdb">
            <Forum>
                <sql conditional="">
                    ALTER TABLE [ForumMessage] ADD [ForumMessageIsActive] BIT NOT NULL DEFAULT blnTrue
                </sql>
            </Forum>
        </database>
    </package>

    <package version="886" releasedate="05-06-2014" internalversion="8.5.0.0">
        <database file="Dynamic.mdb">
            <ItemList>
                <sql conditional="">
                    CREATE TABLE [ItemList]
                    (
                        ItemListId IDENTITY NOT NULL,
                        ItemListItemType NVARCHAR(255) NOT NULL,
                        CONSTRAINT ItemList_PrimaryKey PRIMARY KEY([ItemListId])
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE [ItemListRelation]
                    (
                        ItemListRelationId IDENTITY NOT NULL,
                        ItemListRelationItemListId INT NOT NULL,
                        ItemListRelationItemId NVARCHAR(255) NOT NULL,
                        ItemListRelationSort INT NOT NULL,
                        CONSTRAINT ItemListRelation_PrimaryKey PRIMARY KEY([ItemListRelationId]),
                        CONSTRAINT ItemListRelation_FKItemListId FOREIGN KEY(ItemListRelationItemListId) REFERENCES ItemList(ItemListId)
                    )
                </sql>
            </ItemList>
        </database>
    </package>

    <package version="885" releasedate="20-05-2014" internalversion="8.5.0.0">
        <database file="Dynamic.mdb">
            <QuerySandbox>
                <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'QuerySandbox'">
                    INSERT INTO [Module]
                    ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleParagraph], [ModuleIsBeta], [ModuleParagraphEditPath])
                    VALUES
                    ('QuerySandbox', 'Query sandbox', blnFalse, blnTrue, blnTrue, '/Admin/Module/QuerySandbox')
                </sql>
            </QuerySandbox>
        </database>
    </package>

    <package version="884"  releasedate="20-05-2014" internalversion="8.5.0.0">
        <database file="Dynamic.mdb">
            <SocialMessage>
                <sql conditional="">
                    ALTER TABLE [SocialMessage] ADD [MessageFolderId] INT NULL, [MessageTopFolderId] INT NULL
                </sql>
            </SocialMessage>
            <SocialFolder>
                <sql conditional="">
                    CREATE TABLE [SocialFolder]
                    (
                        FolderId IDENTITY NOT NULL,
                        FolderParentId  INT NULL,
                        FolderName NVARCHAR(255) NULL,
                        FolderTopFolderId INT NULL,
                        CONSTRAINT SocialFolder_PrimaryKey PRIMARY KEY([FolderId])
                    )
                </sql>
            </SocialFolder>
            <SocialTopFolder>
                <sql conditional="">
                    CREATE TABLE [SocialTopFolder]
                    (
                        TopFolderId IDENTITY NOT NULL,
                        TopFolderName NVARCHAR(255) NULL,
                        TopFolderChannelIds NVARCHAR(MAX) NULL,
                        CONSTRAINT SocialTopFolder_PrimaryKey PRIMARY KEY([TopFolderId])
                    )
                </sql>
            </SocialTopFolder>
            <SocialFolder>
                <sql conditional="SELECT COUNT(*) FROM [SocialFolder] WHERE [FolderName] = 'Drafts' AND [FolderParentId] = 0 AND [FolderTopFolderId] = 1">
                    INSERT INTO SocialFolder ([FolderParentId], [FolderName], [FolderTopFolderId])
                    VALUES (0, 'Drafts', 1)
                </sql>
                <sql conditional="SELECT COUNT(*) FROM [SocialFolder] WHERE [FolderName] = 'Scheduled' AND [FolderParentId] = 0 AND [FolderTopFolderId] = 1">
                    INSERT INTO SocialFolder ([FolderParentId], [FolderName], [FolderTopFolderId])
                    VALUES (0, 'Scheduled', 1)
                </sql>
                <sql conditional="SELECT COUNT(*) FROM [SocialFolder] WHERE [FolderName] = 'Published' AND [FolderParentId] = 0 AND [FolderTopFolderId] = 1">
                    INSERT INTO SocialFolder ([FolderParentId], [FolderName], [FolderTopFolderId])
                    VALUES (0, 'Published', 1)
                </sql>
            </SocialFolder>
        </database>
    </package>

    <package version="883" releasedate="08-05-2014" internalversion="8.5.0.0">
        <database file="Access.mdb">
            <AccessUser>
	            <sql conditional="">
	                ALTER TABLE [AccessUser] ADD 
                        [AccessUserTitle] NVARCHAR(255) NULL, 
                        [AccessUserFirstName] NVARCHAR(255) NULL, 
                        [AccessUserHouseNumber] NVARCHAR(255) NULL
	            </sql>
            </AccessUser>
            <EcomOrders>
	            <sql conditional="">
	                ALTER TABLE [EcomOrders] ADD 
                        [OrderCustomerTitle] NVARCHAR(255) NULL,
                        [OrderCustomerFirstName] NVARCHAR(255) NULL,
                        [OrderCustomerMiddleName] NVARCHAR(255) NULL,
                        [OrderCustomerHouseNumber] NVARCHAR(255) NULL,
                        [OrderDeliveryTitle] NVARCHAR(255) NULL,
                        [OrderDeliveryFirstName] NVARCHAR(255) NULL,
                        [OrderDeliveryMiddleName] NVARCHAR(255) NULL,
                        [OrderDeliveryHouseNumber] NVARCHAR(255) NULL 
	            </sql>
            </EcomOrders>
        </database>
    </package>
    
    <package version="882" releasedate="23-04-2014" internalversion="8.4.1.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_NonBrowserSession_SessionId] ON [dbo].[NonBrowserSession]
                    (
	                    [SessionSessionId] ASC
                    )
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="881" releasedate="09-11-2013" internalversion="8.4.1.0">
		<database file="Dynamic.mdb">
            <Module>
				<sql conditional="SELECT COUNT(*) FROM [EcomFilterDefinitionTranslation]">
				    INSERT INTO [EcomFilterDefinitionTranslation] ([EcomFilterDefinitionTranslationFilterDefinitionId], [EcomFilterDefinitionTranslationFilterDefinitionLanguageId], [EcomFilterDefinitionTranslationFilterDefinitionName])
                        SELECT EcomFilterDefinitionID, LanguageID,  EcomFilterDefinitionName FROM [EcomLanguages] CROSS JOIN [EcomFilterDefinition] ORDER BY EcomFilterDefinitionID
				</sql>
			</Module>
		</database>
    </package>

    <package version="880" releasedate="04-04-2014" internalversion="8.4.1.0">
        <database file="Statisticsv2.mdb">
            <Statv2SessionBot>
                <sql conditional="">
                    IF NOT EXISTS (SELECT * FROM sys.indexes WHERE ( name = N'DW_PK_Statv2SessionBot' ))
                        ALTER TABLE [Statv2SessionBot] ADD CONSTRAINT
	                        [DW_PK_Statv2SessionBot] PRIMARY KEY NONCLUSTERED ( Statv2SessionID ASC )
                </sql>
            </Statv2SessionBot>
        </database>
    </package>

    <package version="879" releasedate="04-04-2014" internalversion="8.4.1.0">
        <file name="ExportUsersWithSelectedColumns.xml" source="/Files/System/Integration/Jobs/ModuleSpecificJobs/UserManagementModuleJobs/ExportJobs" target="/Files/System/Integration/Jobs/ModuleSpecificJobs/UserManagementModuleJobs/ExportJobs" overwrite="false" />
    </package>

    <package version="878" releasedate="03-04-2014" internalversion="8.4.1.0">
        <database file="Access.mdb">
            <AccessUserExternalLogin>                
                <sql conditional="">
                    IF NOT EXISTS(SELECT * FROM sys.columns WHERE ( name = 'ProviderUserName' ) AND ( object_id = ( SELECT object_id FROM sys.tables WHERE ( name = 'AccessUserExternalLogin' ) ) ) )
                        ALTER TABLE [AccessUserExternalLogin] ADD [ProviderUserName] NVARCHAR(255) NULL                                     
                </sql>
                <sql conditional="SELECT NOW()">
                    ALTER TABLE [AccessUserExternalLogin] ADD [ProviderUserName] NVARCHAR(255) NULL
                </sql>
            </AccessUserExternalLogin>
        </database>
    </package>

    <package version="877" releasedate="01-04-2014" internalversion="8.4.1.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    IF NOT EXISTS (SELECT * FROM sys.indexes WHERE ( name = N'DW_IX_EmailRecipient_MessageId' ))
                        CREATE NONCLUSTERED INDEX [DW_IX_EmailRecipient_MessageId] ON [EmailRecipient]
                        (
	                        [RecipientMessageId] ASC
                        )
                        INCLUDE
                        (
	                        [RecipientId],
	                        [RecipientKey],
	                        [RecipientName],
	                        [RecipientEmailAddress],
	                        [RecipientSentTime],
	                        [RecipientErrorMessage],
	                        [RecipientErrorTime],
	                        [RecipientTags],
	                        [RecipientSecret]
                        )
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="876" releasedate="01-04-2014" internalversion="8.4.1.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    IF NOT EXISTS (SELECT * FROM sys.indexes WHERE ( name = N'DW_IX_EmailAction_MessageId_RecipientId_Type' ))
                        CREATE NONCLUSTERED INDEX [DW_IX_EmailAction_MessageId_RecipientId_Type] ON [EmailAction]
                        (
	                        [ActionMessageId] ASC,
	                        [ActionRecipientId] ASC,
	                        [ActionType] ASC
                        )
                </sql>
                <sql conditional="">
                    IF NOT EXISTS (SELECT * FROM sys.indexes WHERE ( name = N'DW_IX_EmailRecipient_MessageId_Id' ))
                        CREATE NONCLUSTERED INDEX [DW_IX_EmailRecipient_MessageId_Id] ON [EmailRecipient]
                        (
	                        [RecipientMessageId] ASC,
	                        [RecipientId] ASC
                        )
                        INCLUDE 
                        (
	                        [RecipientKey],
	                        [RecipientName],
	                        [RecipientEmailAddress]
                        )
                </sql>
                <sql conditional="">
                    IF NOT EXISTS (SELECT * FROM sys.indexes WHERE ( name = N'DW_IX_Statv2Object_Type' ))
                        CREATE NONCLUSTERED INDEX [DW_IX_Statv2Object_Type] ON [Statv2Object]
                        (
	                        [Statv2ObjectType] ASC
                        )
                        INCLUDE
                        (
	                        [Statv2ObjectSessionID],
	                        [Statv2ObjectElement]
                        )
                </sql>
                <sql conditional="">
                    IF NOT EXISTS (SELECT * FROM sys.indexes WHERE ( name = N'DW_IX_EcomOrders_OrderID' ))
                        CREATE NONCLUSTERED INDEX [DW_IX_EcomOrders_OrderID] ON [EcomOrders]
                        (
	                        [OrderID] ASC
                        )
                        INCLUDE
                        (
	                        [OrderPriceBeforeFeesWithVAT]
                        )
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="875" releasedate="25-04-2014" internalversion="8.5.0.0">
        <database file="Access.mdb">
            <AccessUser>
                <sql conditional="">
                    ALTER TABLE AccessUser ADD AccessUserAdministratorInGroups NVARCHAR(MAX) NULL
                </sql>
            </AccessUser>
        </database>
    </package>

    <package version="874" releasedate="21-04-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <EcomFilterDefinition>
                <sql conditional="">
                    CREATE TABLE EcomValidationGroupsTranslation
                    (
                        EcomValidationGroupsTranslationValidationGroupID NVARCHAR(50) NOT NULL,
                        EcomValidationGroupsTranslationValidationGroupLanguageID NVARCHAR(50) NOT NULL,
                        EcomValidationGroupsTranslationValidationGroupName NVARCHAR(255) NULL,
                        CONSTRAINT EcomValidationGroupsTranslation_PK PRIMARY KEY(EcomValidationGroupsTranslationValidationGroupID, EcomValidationGroupsTranslationValidationGroupLanguageID),
                        CONSTRAINT EcomValidationGroupsTranslation_FKValidationGroupID FOREIGN KEY(EcomValidationGroupsTranslationValidationGroupID) REFERENCES EcomValidationGroups(ValidationGroupID),
                        CONSTRAINT EcomValidationGroupsTranslation_FKLanguageID FOREIGN KEY(EcomValidationGroupsTranslationValidationGroupLanguageID) REFERENCES EcomLanguages(LanguageID)
                    )
                </sql>
          		<sql conditional="SELECT COUNT(*) FROM [EcomValidationGroupsTranslation]">
				    INSERT INTO [EcomValidationGroupsTranslation] ([EcomValidationGroupsTranslationValidationGroupID], [EcomValidationGroupsTranslationValidationGroupLanguageID], [EcomValidationGroupsTranslationValidationGroupName])
                        SELECT ValidationGroupID, LanguageID,  ValidationGroupName FROM [EcomLanguages] CROSS JOIN [EcomValidationGroups] ORDER BY ValidationGroupID
				</sql>
            </EcomFilterDefinition>
        </database>
    </package>

    <package  version="873" releasedate="17-04-2014" internalversion="8.5.0.0">
        <file name="CreatePost.html" target="Files/Templates/BasicForum/CreatePost" source="Files/Templates/BasicForum/CreatePost" overwrite="false"/>
        <file name="functions.js" target="Files/Templates/BasicForum" source="Files/Templates/BasicForum" overwrite="false"/>
    </package>   

    <package version="872" releasedate="08-04-2014" internalversion="8.5.0.0">
        <file name="ExportUsersToExcel.xml" source="/Files/System/Integration/Jobs/ModuleSpecificJobs/UserManagementModuleJobs/ExportJobs" target="/Files/System/Integration/Jobs/ModuleSpecificJobs/UserManagementModuleJobs/ExportJobs" overwrite="false" />
        <file name="ExportUsersWithSelectedColumns.xml" source="/Files/System/Integration/Jobs/ModuleSpecificJobs/UserManagementModuleJobs/ExportJobs" target="/Files/System/Integration/Jobs/ModuleSpecificJobs/UserManagementModuleJobs/ExportJobs" overwrite="false" />
        <file name="ImportUsersFromExcel.xml" source="/Files/System/Integration/Jobs/ModuleSpecificJobs/UserManagementModuleJobs/ImportJobs" target="/Files/System/Integration/Jobs/ModuleSpecificJobs/UserManagementModuleJobs/ImportJobs" overwrite="false" />
    </package>

    <package version="871" releasedate="26-03-2014" internalversion="8.4.1.0">
        <database file="Dynamic.mdb">
            <EmailMessaging>
                <sql conditional="">
                    IF NOT EXISTS(SELECT * FROM sys.columns WHERE ( name = 'RecipientSecret' ) AND ( object_id = ( SELECT object_id FROM sys.tables WHERE ( name = 'EmailRecipient' ) ) ) )
                        ALTER TABLE [EmailRecipient] ADD [RecipientSecret] NVARCHAR(50) NULL
                </sql>
                <sql conditional="SELECT NOW()">
                    ALTER TABLE [EmailRecipient] ADD [RecipientSecret] NVARCHAR(50) NULL
                </sql>
            </EmailMessaging>
        </database>
    </package>

	<package version="870" date="19-03-2014" internalversion="8.4.1.0">
		<file name="developer.js" source="/Files/System/Editor/ckeditor/config/" target="/Files/System/Editor/ckeditor/config/" overwrite="false" />
	</package>

	<package version="869" date="17-03-2014" internalversion="8.4.1.0">
		<database file="Dynamic.mdb">
		<Page>
			<sql conditional="">
                    ALTER TABLE [Area] ADD [AreaSSLMode] INT NULL
			</sql>
		</Page>
		</database>
	</package>

    <package version="868" releasedate="11-03-2014" internalversion="8.4.1.0">
        <database file="Statisticsv2.mdb">
            <OMCLeadEmail>
                <sql conditional="">
                    IF NOT EXISTS(SELECT * FROM sys.columns WHERE ( name = 'LeadEmailLeadStates' ) AND ( object_id = ( SELECT object_id FROM sys.tables WHERE ( name = 'OMCLeadEmail' ) ) ) )
                        ALTER TABLE [OMCLeadEmail] ADD [LeadEmailLeadStates] NVARCHAR(MAX) NULL
                </sql>
                <sql conditional="SELECT NOW()">
                    ALTER TABLE [OMCLeadEmail] ADD [LeadEmailLeadStates] NVARCHAR(MAX) NULL
                </sql>
            </OMCLeadEmail>
        </database>
    </package>

    <package version="867" releasedate="03-03-2014" internalversion="8.4.1.0">
        <database file="Ecom.mdb">
            <EcomFilterDefinition>
                <sql conditional="">
                    IF NOT EXISTS(SELECT * FROM sys.tables WHERE ( name = 'EcomFilterDefinitionTranslation' ) )
                        CREATE TABLE [EcomFilterDefinitionTranslation]
                        (
	                        [EcomFilterDefinitionTranslationId] INT NOT NULL IDENTITY(1,1),
	                        [EcomFilterDefinitionTranslationFilterDefinitionId] INT NOT NULL, 
                            [EcomFilterDefinitionTranslationFilterDefinitionLanguageId] NVARCHAR(50) NOT NULL, 
                            [EcomFilterDefinitionTranslationFilterDefinitionName] NVARCHAR(255) NULL,     
	                        CONSTRAINT [DW_PK_EcomFilterDefinitionTranslation] PRIMARY KEY NONCLUSTERED ([EcomFilterDefinitionTranslationFilterDefinitionId] ASC, [EcomFilterDefinitionTranslationFilterDefinitionLanguageId] ASC)
                        )
                </sql>
                <sql conditional="SELECT NOW()">
                    CREATE TABLE [EcomFilterDefinitionTranslation]
                        (
	                        [EcomFilterDefinitionTranslationId] INT NOT NULL IDENTITY(1,1),
	                        [EcomFilterDefinitionTranslationFilterDefinitionId] INT NOT NULL, 
                            [EcomFilterDefinitionTranslationFilterDefinitionLanguageId] NVARCHAR(50) NOT NULL, 
                            [EcomFilterDefinitionTranslationFilterDefinitionName] NVARCHAR(255) NULL,     
	                        PRIMARY KEY ([EcomFilterDefinitionTranslationFilterDefinitionId] ASC, [EcomFilterDefinitionTranslationFilterDefinitionLanguageId] ASC)
                        )
                </sql>
                <sql conditional="">
                    IF NOT EXISTS (SELECT * FROM sys.indexes WHERE ( name = N'DW_IX_EcomFilterDefinitionTranslation_Id' )) AND EXISTS(SELECT * FROM sys.indexes WHERE ( name = N'DW_PK_EcomFilterDefinitionTranslation' ))
                        CREATE UNIQUE CLUSTERED INDEX DW_IX_EcomFilterDefinitionTranslation_Id
	                        ON [EcomFilterDefinitionTranslation]
                    (
	                        [EcomFilterDefinitionTranslationId] ASC
                    )
                </sql>
            </EcomFilterDefinition>
        </database>
    </package>

    <package version="866" releasedate="14-02-2014" internalversion="8.4.1.0">
        <database file="Access.mdb">
            <AccessUser>
                <sql conditional="">
                    IF NOT EXISTS(SELECT * FROM sys.columns WHERE ( name = 'AccessUserLastLoginOn' ) AND ( object_id = ( SELECT object_id FROM sys.tables WHERE ( name = 'AccessUser' ) ) ) )
                        ALTER TABLE AccessUser ADD AccessUserLastLoginOn DATETIME NULL
                </sql>
                <sql conditional="SELECT NOW()">
                    ALTER TABLE AccessUser ADD AccessUserLastLoginOn DATETIME NULL
                </sql>
            </AccessUser>
        </database>
    </package>

    <package version="865" releasedate="07-02-2014" internalversion="8.4.1.0">
        <database file="Statisticsv2.mdb">
            <Page>
                <sql conditional="">
                    IF NOT EXISTS(SELECT * FROM sys.columns WHERE ( name = 'Statv2ObjectPageID' ) AND ( object_id = ( SELECT object_id FROM sys.tables WHERE ( name = 'Statv2Object' ) ) ) )
                        ALTER TABLE [Statv2Object] ADD [Statv2ObjectPageID] INT NULL
                </sql>
                <sql conditional="SELECT NOW()">
                    ALTER TABLE [Statv2Object] ADD [Statv2ObjectPageID] INT NULL
                </sql>
            </Page>
        </database>
    </package>

     <package  version="864" releasedate="31-01-2014" internalversion="8.4.1.0">
        <file name="InformationSaveCart.html" target="Files/Templates/eCom7/CartV2/Step" source="Files/Templates/eCom7/CartV2/Step" overwrite="false"/>
    </package>   

     <package version="863" date="27-01-2014" internalversion="8.4.0.0">
    </package>

    <package version="862" releasedate="24-01-2014" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <Module>
                <sql conditional="">
                    UPDATE [Module] SET [ModuleIsBeta] = 1 WHERE [ModuleSystemName] = 'ItemCreator' AND [ModuleIsBeta] = 0
                </sql>
            </Module>
        </database>
    </package>
    
    <package version="861" releasedate="21-01-2014" internalversion="8.4.0.0">
        <setting key="/Globalsettings/Modules/OMC/EmailMarketing/DefaultRecipientsListCount" value="-1" overwrite="false" />
	</package>

    <package version="860" date="20-01-2014" internalversion="8.4.0.0">
		<database file="Dynamic.mdb">
			<Page>
				<sql conditional="">ALTER TABLE Page ADD PageNavigationIncludeProducts BIT DEFAULT blnFalse</sql>
			</Page>			  
		</database>

        <setting key="/Globalsettings/Ecom/Navigation/MaxNumberOfProducts" value="10" overwrite="False" />
        <setting key="/Globalsettings/Ecom/Navigation/CacheProductsMinutes" value="10" overwrite="False" />
    </package>

    <package version="859" releasedate="20-01-2014" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <Module>
                <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Update' AND [ModuleAccess] = blnFalse">
                    UPDATE [Module] SET [ModuleAccess] = blnTrue WHERE [ModuleSystemName] = 'ItemCreator'
                </sql>
            </Module>
        </database>
    </package>

     <package  version="858" releasedate="20-01-2014" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
			<Module>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Profiling'">
					INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleParagraph], [ModuleIsBeta])
					VALUES ('Profiling', 'Profiling', blnTrue, blnFalse, blnFalse)
				</sql>
			</Module>
		</database>
    </package>

    <package version="857" date="17-01-2014" internalversion="8.4.0.0">
		<database file="Dynamic.mdb">
			<Page>
				<sql conditional="">ALTER TABLE Page ADD PageIsFolder BIT DEFAULT blnFalse</sql>
			</Page>			  
		</database>
    </package>

    <package version="856" releasedate="16-01-2014" internalversion="8.4.0.0">
        <file name="email.js" source="/Files/System/Editor/ckeditor/config/" target="/Files/System/Editor/ckeditor/config/" overwrite="false" />
    </package>

    <package version="855" releasedate="15-01-2014" internalversion="8.4.0.0" >
        <database file="Statisticsv2.mdb">
            <Statv2Object>
                <sql conditional="">
                    ALTER TABLE [Statv2Object] ADD [Statv2ObjectValue] NVARCHAR(255) NULL
                </sql>
            </Statv2Object>
        </database>
    </package>

    <package version="854" date="14-01-2014" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketingTopFolder>
                <sql conditional="">ALTER TABLE [EmailMarketingTopFolder] ADD [TopFolderRecipientSpecificContent] BIT NOT NULL DEFAULT 0</sql>
            </EmailMarketingTopFolder>
        </database>
    </package>

    <package version="853" releasedate="14-01-2014" internalversion="8.4.0.0">
        <file name="Search words - Top 5.xml" target="Files/System/OMC/Reports/Marketing reports/Search Words" source="Files/System/OMC/Reports/Search Words" overwrite="false"/>
        <file name="Search words.xml" target="Files/System/OMC/Reports/Marketing reports/Search Words" source="Files/System/OMC/Reports/Search Words" overwrite="false"/>
    </package>

    <package version="852" releasedate="14-01-2014" internalversion="8.4.0.0">
        <file name="Search words - No results.xml" target="Files/System/OMC/Reports/Marketing reports/Search Words" source="Files/System/OMC/Reports/Search Words" overwrite="false"/>
    </package>

    <package version="851" releasedate="08-01-2014" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] ADD [EmailRecipientSpecificContent] BIT NOT NULL DEFAULT 0
                </sql>
                <sql conditional="">
                    ALTER TABLE [EmailMessage] ADD [MessageRecipientSpecificContent] BIT NOT NULL DEFAULT 0
                </sql>
                <sql conditional="">
                    ALTER TABLE [EmailMessage] ADD [MessageRecipientContentProvider] NVARCHAR(MAX) NULL
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="850" releasedate="02-01-2014" internalversion="8.4.0.0">
        <database file="Statisticsv2.mdb">
            <OMCRenamedLead>
                <sql conditional="">
                    CREATE TABLE [OMCRenamedLead]
                    (
                        [ID] IDENTITY PRIMARY KEY NOT NULL,
                        [IPAddress] NVARCHAR(15) NOT NULL,
                        [Company] NVARCHAR(255) NOT NULL
                    )
                </sql>
            </OMCRenamedLead>
        </database>
    </package>

    <package  version="849" releasedate="26-12-2013" internalversion="8.4.0.0">
        <database file="Access.mdb">
			<Module>
				<sql conditional="">
					INSERT INTO [AccessElementType] ([AccessElementType])
					VALUES ('emailfolder')
				</sql>
			</Module>
		</database>
    </package>

    <package version="848" releasedate="25-12-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <Page>
                <sql conditional="">
                    ALTER TABLE [Statv2Object] ADD [Statv2ObjectPageID] INT NULL
                </sql>
            </Page>
        </database>
    </package>

    <package version="847" releasedate="25-11-2013" internalversion="8.4.0.0">
        <setting key="/Globalsettings/System/AddIns/AllowLoad" value="True" overwrite="False" />
    </package>

    <package  version="846" releasedate="20-12-2013" internalversion="8.4.0.0">
        <file name="LoginWithImpersonation.html" target="Files/Templates/UserManagement/SecondaryUser" source="Files/Templates/UserManagement/SecondaryUser" overwrite="false"/>
        <file name="view_profile_external_accounts.html" target="Files/Templates/UserManagement/ViewProfile" source="Files/Templates/UserManagement/ViewProfile" overwrite="false"/>        
        <file name="LoginWithExternalAccount.html" target="Files/Templates/Extranet" source="Files/Templates/Extranet" overwrite="false"/>                
    </package>
    
    <package version="845" releasedate="17-12-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] ADD [EmailScheduledRepeatInterval] INT NULL
                </sql>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] ADD [EmailScheduledEndTime] DATETIME NULL
                </sql>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] ADD [EmailRequireUniqueRecipients] BIT NOT NULL DEFAULT blnTrue
                </sql>
                <sql conditional="">
                    ALTER TABLE [EmailMessage] ADD [MessageRequireUniqueRecipients] BIT NOT NULL DEFAULT blnTrue
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="844" releasedate="17-12-2013" internalversion="8.4.0.0">
        <file name="Search words.xml" source="Files/System/OMC/Reports/Marketing reports/Conversions/Search Words" target="/Files/System/OMC/Reports/Marketing reports/Conversions/Search Words" overwrite="false" />
        <file name="Search words - Top 5.xml" source="Files/System/OMC/Reports/Marketing reports/Conversions/Search Words" target="/Files/System/OMC/Reports/Marketing reports/Conversions/Search Words" overwrite="false" />
    </package>
    
    <package version="843" releasedate="06-12-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <Page>
                <sql conditional="">
                    ALTER TABLE [Page] ADD [PageCreationRules] NVARCHAR(MAX) NULL
                </sql>
            </Page>
        </database>
    </package>

    <package version="842" releasedate="05-12-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <Campaigns>
                <sql conditional="">
                    DROP TABLE [AutomationFolder]
                </sql>
                <sql conditional="">
                    DROP TABLE [AutomationContext]
                </sql>
                <sql conditional="">
                    DROP TABLE [AutomationActionExecution]
                </sql>
                <sql conditional="">
                    DROP TABLE [AutomationAction]
                </sql>
                <sql conditional="">
                    DROP TABLE [Automation]
                </sql>
                <sql conditional="">
                    DROP TABLE [AutomationPlan]
                </sql>
                <sql conditional="">
                    CREATE TABLE CampaignDefinition
                    (
	                    CampaignDefinitionId IDENTITY NOT NULL,
	                    CampaignDefinitionName NVARCHAR(255) NOT NULL,
                        CampaignDefinitionFolderId INT NULL,
	                    CampaignDefinitionTriggerType NVARCHAR(255) NULL,
	                    CONSTRAINT CampaignDefinition_PrimaryKey PRIMARY KEY(CampaignDefinitionId)
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE CampaignAction
                    (
	                    CampaignActionId IDENTITY NOT NULL,
	                    CampaignActionCampaignDefinitionId INT NOT NULL,
	                    CampaignActionType NVARCHAR(255) NOT NULL,
	                    CampaignActionDelayInSeconds FLOAT NULL,
	                    CampaignActionParameters NVARCHAR(MAX) NULL,
	                    CampaignActionOrder INT NOT NULL,
	                    CONSTRAINT CampaignAction_PrimaryKey PRIMARY KEY(CampaignActionId),
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE Campaign
                    (
	                    CampaignId IDENTITY NOT NULL,
	                    CampaignCampaignDefinitionId INT NOT NULL,
	                    CampaignPreviousActionTime DATETIME NULL,
	                    CampaignNextActionTime DATETIME NULL,
	                    CampaignNextActionIndex INT NOT NULL DEFAULT 0,
	                    CampaignState INT NOT NULL DEFAULT 1,
	                    CONSTRAINT Campaign_PrimaryKey PRIMARY KEY(CampaignId)
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE CampaignActionExecution
                    (
	                    CampaignActionExecutionId IDENTITY NOT NULL,
	                    CampaignActionExecutionActionId INT NOT NULL,
	                    CampaignActionExecutionCampaignId INT NOT NULL,
	                    CampaignActionExecutionTime DATETIME NOT NULL,
	                    CampaignActionExecutionSucceeded BIT NOT NULL,
	                    CampaignActionExecutionErrorMessage NVARCHAR(MAX) NULL,
	                    CampaignActionExecutionErrorStackTrace NVARCHAR(MAX) NULL,
	                    CONSTRAINT CampaignActionExecution_PrimaryKey PRIMARY KEY(CampaignActionExecutionId),
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE CampaignContext
                    (
	                    CampaignContextCampaignId INT NOT NULL,
	                    CampaignContextKey NVARCHAR(255) NOT NULL,
	                    CampaignContextValue NVARCHAR(MAX) NULL,
	                    CONSTRAINT CampaignContext_PrimaryKey PRIMARY KEY (CampaignContextCampaignId, CampaignContextKey)
                    )
                </sql>
                <sql conditional="">
                      CREATE TABLE CampaignFolder
                    (
                        CampaignFolderId IDENTITY NOT NULL,
                        CampaignFolderParentId  INT NULL,
                        CampaignFolderName NVARCHAR(255) NULL,
                        CONSTRAINT CampaignFolder_PrimaryKey PRIMARY KEY([CampaignFolderId])
                    )
                </sql>
            </Campaigns>
        </database>
    </package>

    <package version="841" releasedate="05-12-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <EmailMessaging>
                <sql conditional="">
                    ALTER TABLE [EmailRecipient] ADD [RecipientTags] NVARCHAR(MAX) NULL
                </sql>
            </EmailMessaging>
        </database>
    </package>

    <package  version="840" releasedate="02-12-2013" internalversion="8.4.0.0">        
    </package>

    <package version="839" releasedate="02-12-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [EmailRecipient_RecipientIdMessageId] ON [dbo].[EmailRecipient]
                    (
	                    [RecipientMessageId] ASC,
	                    [RecipientId] ASC
                    )
                    INCLUDE
                    (
                        [RecipientKey],
	                    [RecipientName],
	                    [RecipientEmailAddress],
	                    [RecipientSentTime],
	                    [RecipientErrorMessage],
	                    [RecipientErrorTime]
                    ) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [EmailRecipientTag_RecipientId] ON [dbo].[EmailRecipientTag]
                    (
	                    [RecipientTagRecipientId] ASC
                    )
                    INCLUDE
                    (
                        [RecipientTagId],
	                    [RecipientTagName],
	                    [RecipientTagValue],
	                    [RecipientTagDataType]
                    ) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="838" releasedate="25-11-2013" internalversion="8.4.0.0">
        <database file="Access.mdb">
            <AccessUserExternalLogin>                
                <sql conditional="">
                    CREATE TABLE AccessUserExternalLogin
                    (			
                        ID IDENTITY PRIMARY KEY NOT NULL,
                        ProviderID INT NOT NULL,
                        ProviderKey NVARCHAR(255) NOT NULL,                        
                        UserID INT NOT NULL
                    )                 
                </sql>                
            </AccessUserExternalLogin>
        </database>
    </package>
    
    <package version="837" releasedate="25-11-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <ExternalLoginProvider>
                <sql conditional="">
                    CREATE TABLE ExternalLoginProvider
                    (
                        ProviderID IDENTITY PRIMARY KEY NOT NULL,
                        ProviderName NVARCHAR(255) NULL,
                        ProviderType NVARCHAR(255) NULL,
                        ProviderFullType NVARCHAR(MAX) NULL,
                        ProviderParameters NVARCHAR(MAX) NULL,
                        ProviderCreated DATETIME NULL,
                        ProviderUpdated DATETIME NULL,
                        ProviderActive BIT NOT NULL DEFAULT 0
                    )
                </sql>
            </ExternalLoginProvider>           
        </database>
    </package>

    <package version="836" releasedate="22-11-2013" internalversion="8.4.0.0">
        <setting key="/Globalsettings/ItemTypes/MetadataSource" value="files" overwrite="False" />
    </package>

    <package version="835" releasedate="19-11-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <Page>
	            <sql conditional="">
	                CREATE TABLE [ItemTypeDefinitions](
	                    [ItemTypeDefinitionsSystemName] nvarchar(255) NOT NULL,
	                    [ItemTypeDefinitionsMetadata] nvarchar(max) NOT NULL,
                        [ItemTypeDefinitionsModified] datetime NOT NULL,
                        CONSTRAINT [ItemTypeDefinitions_PrimaryKey] PRIMARY KEY ([ItemTypeDefinitionsSystemName]) 
                    )
	            </sql>
            </Page>
        </database>
    </package>

    <package version="834" releasedate="14-11-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <Page>
	            <sql conditional="">ALTER TABLE [AutomationPlan] ADD [AutomationPlanFolderId] int NULL</sql>
            </Page>
        </database>
        
        <setting key="/Globalsettings/Settings/Page/ContentTypes" value="application/atom+xml,text/css,text/javascript,image/jpeg,application/json,application/pdf,application/rss+xml; charset=ISO-8859-1,text/plain,text/xml" overwrite="False" />
    </package>
    
    <package version="833" releasedate="13-11-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <Page>
	            <sql conditional="">ALTER TABLE [Page] ADD [PageContentType] NVARCHAR(50) NULL</sql>
            </Page>
        </database>
        
        <setting key="/Globalsettings/Settings/Page/ContentTypes" value="text/html,application/atom+xml,text/css,text/javascript,image/jpeg,application/json,application/pdf,application/rss+xml; charset=ISO-8859-1,text/plain,text/xml" overwrite="False" />
    </package>
    
    <package  version="832" releasedate="12-11-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
			<Module>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'ItemCreator'">
					INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleParagraph])
					VALUES ('ItemCreator', 'Item creator', blnFalse, blnTrue)
				</sql>
			</Module>
		</database>

        <file name="Create.html" source="/Files/Templates/ItemCreator/Create" target="/Files/Templates/ItemCreator/Create"  />
        <file name="ItemCreator.css" source="/Files/Templates/ItemCreator" target="/Files/Templates/ItemCreator" />
        <file name="Mail.html" source="/Files/Templates/ItemCreator/Email" target="/Files/Templates/ItemCreator/Email" />
        <file name="Reciept.html" source="/Files/Templates/ItemCreator/Email" target="/Files/Templates/ItemCreator/Email" />
    </package>

<package version="833" releasedate="12-11-2013" internalversion="8.3.1.0">
		<database file="Dynamic.mdb">
            <Module>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Sms'">
				INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleParagraph], [ModuleIsBeta], [ModuleScript])
									   VALUES ('Sms', 'Sms', blnFalse, blnFalse, blnTrue, 'Sms/SmsList.aspx')
				</sql>
			</Module>
		</database>
    </package>

	<package version="832" releasedate="12-11-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <SmsMessage>
                <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Sms'">
                    CREATE TABLE [SmsMessage]
                    (
                        [SmsMessageID] IDENTITY int NOT NULL,
                        [SmsMessageName] nvarchar(max) NULL,
						[SmsMessageText] nvarchar(max) NULL,
						[SmsMessageSendToGroup] nvarchar(max) NULL,
						[SmsMessageCreated] datetime NULL,
						[SmsMessageUpdated] datetime NULL,
						[SmsMessageCreatedBy] int NULL,
						[SmsMessageUpdatedBy] int NULL,
						[SmsMessageRecipientCount] int NULL,
						[SmsMessageFirstMessageSent] datetime NULL,
						[SmsMessageLastMessageSent] datetime NULL,
                        CONSTRAINT SmsMessage_PrimaryKey PRIMARY KEY([SmsMessageID])
                    )
                </sql>
            </SmsMessage>
        </database>
    </package>
    <package version="831" releasedate="12-11-2013" internalversion="8.4.0.0">
      <invoke type="Dynamicweb.Content.Management.UpdateScripts, Dynamicweb" method="FixItemTypeRestrictionNames">
     </invoke>
    </package>

    <package version="830" date="11-11-2013" internalversion="8.4.0.0">
        <database file="Statisticsv2.mdb">
            <OMCExperiment>
                <sql conditional="">ALTER TABLE [OMCExperiment] ADD [OMCExperimentEmailTemplate] NVARCHAR(255) NULL</sql>
            </OMCExperiment>
        </database>
        <file name="EmailExperimentAutoStop.html" target="Files/Templates/OMC/Notifications" source="Files/Templates/OMC/Notifications" overwrite="false"/>
    </package>
	<current version="830" releasedate="11-11-2013" internalversion="8.4.0.0" />

    <package  version="828" releasedate="04-11-2013" internalversion="8.4.0.0">
        <file name="email_subscribe.html" target="Files/Templates/UserManagement/CreateProfile" source="Files/Templates/UserManagement/CreateProfile" overwrite="false"/>
        <file name="email_unsubscribe.html" target="Files/Templates/UserManagement/CreateProfile" source="Files/Templates/UserManagement/CreateProfile" overwrite="false"/>
    </package>

    <package version="827" date="01-11-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <Page>
                <sql conditional="">ALTER TABLE [Page] ADD [PageNoindex] BIT NULL</sql> 
                <sql conditional="">ALTER TABLE [Page] ADD [PageNofollow] BIT NULL</sql>
                <sql conditional="">UPDATE [Page] SET [Page].[PageNoindex] = [Page].[PageNoindexNofollow] WHERE [Page].[PageNoindexNofollow] = blnTrue</sql>
                <sql conditional="">UPDATE [Page] SET [Page].[PageNofollow] = [Page].[PageNoindexNofollow] WHERE [Page].[PageNoindexNofollow] = blnTrue</sql>
            </Page>
        </database>
    </package>
   
    <package  version="826" releasedate="31-10-2013" internalversion="8.4.0.0">
        <file name="edit_profile.html" target="Files/Templates/UserManagement/ViewProfile" source="Files/Templates/UserManagement/ViewProfile" overwrite="false"/>
        <file name="user_edit.html" target="Files/Templates/UserManagement/ViewProfile" source="Files/Templates/UserManagement/ViewProfile" overwrite="false"/>
    </package>

    <package version="825" date="30-10-2013" internalversion="8.4.0.0">
        <database file="Statisticsv2.mdb">
            <OMCExperiment>
                <sql conditional="">ALTER TABLE [OMCExperiment] ADD [OMCExperimentEndingIsNeedToStop] BIT NULL</sql>
            </OMCExperiment>
        </database>
    </package>

     <package version="824" date="29-10-2013" internalversion="8.4.0.0">
        <database file="Statisticsv2.mdb">
            <OMCExperiment>
                <sql conditional="">ALTER TABLE [OMCExperiment]
                                    ADD [OMCExperimentEndingType] INT NULL,
                                        [OMCExperimentEndingValue] INT NULL,
                                        [OMCExperimentEndingDate] DateTime NULL,
                                        [OMCExperimentEndingDateTimeZoneId] NVARCHAR(255) NULL,
                                        [OMCExperimentEndingAction] INT NULL,
                                        [OMCExperimentEndingNotifyEmails] NVARCHAR(MAX) NULL
                </sql>
            </OMCExperiment>
        </database>
    </package>

      <package version="823" releasedate="18-10-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <Automation>
                <sql conditional="">
                      CREATE TABLE AutomationFolder
                    (
                        AutomationFolderId IDENTITY NOT NULL,
                        AutomationFolderParentId  INT NULL,
                        AutomationFolderName NVARCHAR(255) NULL,
                        CONSTRAINT AutomationFolder_PrimaryKey PRIMARY KEY([AutomationFolderId])
                    )
                </sql>
            </Automation>
        </database>
    </package>

    <package version="822" releasedate="18-10-2013" internalversion="8.4.0.0">
        <database file="Statistics.mdb">
            <Statv2Object>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [Statv2Object_SessionIDTypeWithElement] ON [dbo].[Statv2Object] 
                    (
	                    [Statv2ObjectSessionID],
	                    [Statv2ObjectType]
                    ) INCLUDE ([Statv2ObjectElement])
                </sql>
            </Statv2Object>
        </database>
    </package>

    <package version="821" date="15-10-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <SocialMessage>
                <sql conditional="">ALTER TABLE [SocialMessage] ADD [MessageLinkDomain] NVARCHAR(MAX) NULL</sql>
            </SocialMessage>
        </database>
    </package>

    <package version="816" releasedate="10-10-2013" internalversion="8.3.1.0">
        <setting key="/Globalsettings/Modules/UserManagement/UploadedCustomFiles/DefineWhere" value="OnUser" overwrite="False" />
        <setting key="/Globalsettings/Modules/UserManagement/UploadedCustomFiles/FilesFolder" value="" overwrite="False" />
    </package>

    <package version="819" date="09-10-2013" internalversion="8.4.0.0">
        <!--<database file="Dynamic.mdb">
            <EmailMessaging>
                <sql conditional="">ALTER TABLE [EmailMessage] ADD [MessageIsSent] BIT NULL</sql>
            </EmailMessaging>
        </database>-->
    </package>

    <package version="818" releasedate="08-10-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <CustomField>
                <sql conditional="">
                        ALTER TABLE [CustomField] ADD [CustomFieldSort] INT NULL
                </sql>
            </CustomField>
        </database>
    </package>

    <package version="817" releasedate="07-10-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                     ALTER TABLE [EmailMarketingEmail] ADD [EmailOriginalPreHeader] NVARCHAR(MAX) NULL, [EmailVariantPreHeader] NVARCHAR(MAX) NULL
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="815" releasedate="07-10-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">            
            <Page>
	            <sql conditional="">ALTER TABLE [Page] ADD [PageExactUrl] NVARCHAR(255) NULL</sql>
            </Page>
        </database>
    </package>

   <package version="814" releasedate="09-10-2013" internalversion="8.3.1.0">
        <database file="Access.mdb">
            <AccessUser>
                <sql conditional="">ALTER TABLE [AccessUser] DROP [AccessUserIsAccount]</sql>
                <sql conditional="">ALTER TABLE [AccessUser] DROP [AccessUserAccountPermissions]</sql>                    
                <sql conditional="">DROP TABLE AccessUserAccountUserRelation</sql>                                
                <sql conditional="">
                    CREATE TABLE AccessUserSecondaryRelation
                    (							                    
	                    AccessUserSecondaryRelationUserID INT NOT NULL,
	                    AccessUserSecondaryRelationSecondaryUserID INT NOT NULL,	                    
	                    CONSTRAINT AccessUserSecondaryRelation_PrimaryKey PRIMARY KEY (AccessUserSecondaryRelationUserID, AccessUserSecondaryRelationSecondaryUserID)
                    )                 
                </sql>                
            </AccessUser>
        </database>
    </package>


    <package version="813" date="03-10-2013" internalversion="8.4.0.0">
        <database file="Statisticsv2.mdb">
            <OMCLeadEmail>
                <sql conditional="">ALTER TABLE [OMCLeadEmail] DROP [LeadEmailPeriodStartDate]</sql>
            </OMCLeadEmail>
        </database>
    </package>

    <package version="812" date="01-10-2013" internalversion="8.4.0.0">
        <database file="Statisticsv2.mdb">
            <OMCLeadEmail>
                <sql conditional="">ALTER TABLE [OMCLeadEmail] ADD [LeadEmailIsScheduledActive] BIT NULL</sql>
            </OMCLeadEmail>
        </database>
    </package>

    <package version="811" date="01-10-2013" internalversion="8.4.0.0">
		<database file="Statisticsv2.mdb">
			<Statv2Session>
				<sql conditional="">ALTER TABLE [Statv2Session] ADD [Statv2SessionSourceType] NVARCHAR(50) NULL</sql>
			</Statv2Session>
		</database>
	</package>

    <package version="810" releasedate="26-09-2013" internalversion="8.3.1.0">
        <setting key="/Globalsettings/System/Searching/AlertEmailSendParams" value="3" overwrite="false"/>
    </package>

    <package version="809" releasedate="26-09-2013" internalversion="8.3.1.0">        
    </package>

    <package version="808" releasedate="20-09-2013" internalversion="8.3.1.0">
        <database file="Dynamic.mdb">            
            <Page>
                <sql conditional="">
                     ALTER TABLE [Page] DROP [PageChooseAccountTemplate]
                </sql>
            </Page>
        </database>
    </package>

    <package version="807" releasedate="16-09-2013" internalversion="8.3.1.0">        
    </package>

	<package version="806" releasedate="09-09-2013" internalversion="8.3.1.0">
		 <database file="Dynamic.mdb">
            <Module>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'eCom_NAVIntegration_ChangePassword' AND [ModuleAccess] = blnTrue">
				DELETE FROM [Module] WHERE [ModuleSystemName] = 'eCom_NAVIntegration_ChangePassword'
				</sql>
				</Module>
			 </database>
    </package>
   
    <package version="805" releasedate="04-09-2013" internalversion="8.3.1.0">
        <database file="Access.mdb">
            <AccessUser>
	            <sql conditional="">
	                ALTER TABLE AccessUser ADD AccessUserDisableLivePrices BIT NULL
	            </sql>
            </AccessUser>
        </database>
    </package>

    <package  version="804" releasedate="04-09-2013" internalversion="8.3.1.0">        
        <file name="user_create.html" target="Files/Templates/UserManagement/CreateProfile" source="Files/Templates/UserManagement/CreateProfile" overwrite="false"/>
        <file name="user_create_redirect.html" target="Files/Templates/UserManagement/CreateProfile" source="Files/Templates/UserManagement/CreateProfile" overwrite="false"/>
        <file name="user_detail.html" target="Files/Templates/UserManagement/List" source="Files/Templates/UserManagement/List" overwrite="false"/>
        <file name="user_edit.html" target="Files/Templates/UserManagement/List" source="Files/Templates/UserManagement/List" overwrite="false"/>        
        <file name="edit_profile.html" target="Files/Templates/UserManagement/ViewProfile" source="Files/Templates/UserManagement/ViewProfile" overwrite="false"/>
        <file name="user_detail.html" target="Files/Templates/UserManagement/ViewProfile" source="Files/Templates/UserManagement/ViewProfile" overwrite="false"/>
        <file name="user_edit.html" target="Files/Templates/UserManagement/ViewProfile" source="Files/Templates/UserManagement/ViewProfile" overwrite="false"/>
        <file name="view_profile.html" target="Files/Templates/UserManagement/ViewProfile" source="Files/Templates/UserManagement/ViewProfile" overwrite="false"/>
        <file name="view_profile_addresses.html" target="Files/Templates/UserManagement/ViewProfile" source="Files/Templates/UserManagement/ViewProfile" overwrite="false"/>
    </package>

    <package version="803" releasedate="03-09-2012" internalversion="8.3.1.0">
        <database file="Statisticsv2.mdb">
            <OMCLeadEmail>
                <sql conditional="">
                    ALTER TABLE [OMCLeadEmail] ADD [LeadEmailRepeatPeriod] INT NULL, [LeadEmailRepeatUnits] INT NULL
                </sql>
            </OMCLeadEmail>
        </database>
    </package>

	<package version="802" releasedate="22-08-2013" internalversion="8.3.1.0">
		<database file="Dynamic.mdb">
            <Module>
        <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Filearchive'">
		INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleParagraph], [ModuleIsBeta])
                               VALUES ('Filearchive', 'Filarkiv', blnTrue, blnFalse, blnFalse)
		</sql>
				</Module>
			 </database>
    </package>	
	<package version="801" releasedate="22-08-2013" internalversion="8.3.0.0">
		 <database file="Dynamic.mdb">
            <Module>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'ecom_NAVIntegration' AND [ModuleAccess] = blnTrue">
				DELETE FROM [Module] WHERE [ModuleSystemName] = 'ecom_NAVIntegration'
				</sql>
				</Module>
			 </database>
    </package>

    <package version="800" releasedate="22-08-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    CREATE TABLE EmailAction
                    (
	                    ActionId IDENTITY NOT NULL,
	                    ActionSessionId NVARCHAR(50) NOT NULL,
	                    ActionTimestamp DATETIME NOT NULL,
	                    ActionType NVARCHAR(255) NOT NULL,
	                    ActionMessageId INT NULL,
	                    ActionMessageIdString NVARCHAR(50) NULL,
	                    ActionRecipientId INT NULL,
	                    ActionRecipientIdString NVARCHAR(50) NULL,
	                    CONSTRAINT EmailAction_PrimaryKey PRIMARY KEY (ActionId)
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE NonBrowserSession
                    (
	                    SessionId IDENTITY NOT NULL,
	                    SessionSessionId NVARCHAR(50) NOT NULL,
	                    SessionTimestamp DATETIME NOT NULL,
	                    SessionIP NVARCHAR(50) NULL,
	                    SessionIPCountry NVARCHAR(50) NULL,
	                    SessionUserAgentString NVARCHAR(255) NULL,
	                    SessionUserAgentName NVARCHAR(25) NULL,
	                    SessionUserAgentFamily NVARCHAR(25) NULL,
	                    SessionUserAgentOperatingSystem NVARCHAR(25) NULL,
	                    SessionUserAgentPlatform NVARCHAR(25) NULL,
	                    SessionUserAgentIsMobile BIT NULL,
	                    SessionUserAgentIsTablet BIT NULL,
	                    CONSTRAINT NonBrowserSession_PrimaryKey PRIMARY KEY (SessionId)
                    )
                </sql>
            </EmailMarketing>
        </database>
    </package>

	<package version="799" date="19-08-2013" internalversion="8.3.0.0">
		<database file="Dynamic.mdb">
			<Modules>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Templates' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Templates'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Faq' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Faq'
				</sql>c
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Calender' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Calender'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'ContextSubscription' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'ContextSubscription'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Factbox'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Forum' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Forum'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'ForumV2' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'ForumV2'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Employee' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Employee'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'ImageGallery' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'ImageGallery'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Metadata'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'TemplateColumn' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'TemplateColumn'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'MwMediaDatabaseEcom'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'MwFlashPlugin'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'MwMediaDatabase'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'MwMediaDatabaseViewer'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'MwCatalog'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'MwProductSheet'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'NewsletterExtended' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'NewsletterExtended'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'TaskManager' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'TaskManager'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Paygate' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Paygate'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Shop' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Shop'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'ContentLinks'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'SearchExtended'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'CartV2' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'CartV2'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Sitemap' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Sitemap'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Sms' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Sms'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'StatisticsV2'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'StatisticsExtended' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'StatisticsExtended'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Tagwall' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Tagwall'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Weblog' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Weblog'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'eCom_Cart' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'eCom_Cart'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'DealersearchExtranet' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'DealersearchExtranet'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'DealersearchStandard' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'DealersearchStandard'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'IntranoteIntegration'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'SeoAdmin'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'FormV2'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'LanguagePack'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Search'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Statistics'
				</sql>
			</Modules>
		</database>
	</package>
	<package version="798" releasedate="19-08-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">            
            <cleanUp>
                <sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'Accessibility'</sql> 
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'Audit'</sql>  
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'ContentLinks'</sql>
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'DatabaseReplacer'</sql> 	
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'Employee'</sql> 	
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'FilearchiveExtended'</sql>  
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'DM_Publishing_Extended'</sql>  
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'Forum'</sql> 
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'Frontpage'</sql>  
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'Html'</sql> 	
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'Inherit'</sql>  
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'Metadata'</sql> 	
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'Password'</sql> 	
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'PDA'</sql>  
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'Personalize'</sql>  
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'Publish'</sql>
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'RegisterModule'</sql>  
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'Rotation'</sql>
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'SearchFriendlyUrls'</sql>
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'Stylesheet'</sql>  
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'UrlPath'</sql>  
				<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'Statisticsv2'</sql> 
			</cleanUp>
         </database>
		</package>
	 <package version="797" releasedate="19-08-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">            
            <cleanUp>
                <sql conditional="">DROP TABLE ContentGroup</sql> 
				<sql conditional="">DROP TABLE ContentGroupRelation</sql> 
				<sql conditional="">DROP TABLE ContentLink</sql> 
				<sql conditional="">DROP TABLE Factbox</sql> 
				<sql conditional="">DROP TABLE FactboxWord</sql> 
				<sql conditional="">DROP TABLE FAQItemVersion</sql> 
				<sql conditional="">DROP TABLE MyPageGadgets</sql> 
				<sql conditional="">DROP TABLE NewsVersion</sql> 
				<sql conditional="">DROP TABLE ParagraphVersion</sql> 
				<sql conditional="">DROP TABLE SearchBox</sql> 
			</cleanUp>
         </database>
		 <database file="Statistics.mdb">            
            <cleanUp>
				<sql conditional="">DROP TABLE StatDomain</sql> 
				<sql conditional="">DROP TABLE StatExcludeDomain</sql> 
				<sql conditional="">DROP TABLE StatExcludeRange</sql> 
				<sql conditional="">DROP TABLE StatFirstClick</sql> 
				<sql conditional="">DROP TABLE StatFirstPage</sql> 
				<sql conditional="">DROP TABLE StatLastPage</sql> 
				<sql conditional="">DROP TABLE StatPagePrDay</sql> 
				<sql conditional="">DROP TABLE StatPageViewDay</sql> 
				<sql conditional="">DROP TABLE StatPageViewHour</sql> 
				<sql conditional="">DROP TABLE StatPageViewYear</sql> 
				<sql conditional="">DROP TABLE StatReferer</sql> 
				<sql conditional="">DROP TABLE StatRefererDomain</sql> 
				<sql conditional="">DROP TABLE StatSearch</sql> 
				<sql conditional="">DROP TABLE StatSessionDay</sql> 
				<sql conditional="">DROP TABLE StatSessionHour</sql> 
				<sql conditional="">DROP TABLE StatSessionPrVisit</sql> 
				<sql conditional="">DROP TABLE StatSessionYear</sql> 
				<sql conditional="">DROP TABLE StatUserInfo</sql> 
				<sql conditional="">DROP TABLE StatVisit</sql>                  
            </cleanUp>
        </database>
    </package>
    <package version="796" releasedate="19-08-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <SMP>
                <sql conditional="SELECT COUNT([ModuleSystemName]) FROM [Module] WHERE [ModuleSystemName] = 'SocialMediaPublishing'">
				    INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleParagraph], [ModuleIsBeta])
				    VALUES ('SocialMediaPublishing', 'Social Media Publishing', blnFalse, blnFalse, blnFalse)
                </sql>
                <sql conditional="">
                    UPDATE [Module] SET [ModuleAccess] = blnTrue 
                    WHERE [ModuleSystemName] = 'SocialMediaPublishing' AND EXISTS (SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Update' AND ModuleAccess = blnTrue)
                </sql>
            </SMP>
        </database>
    </package>

    <package version="795" releasedate="19-08-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    UPDATE [Module] SET [ModuleIsBeta] = blnFalse WHERE [ModuleSystemName] = 'EmailMarketing'
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="794" releasedate="19-08-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <Automation>
                <sql conditional="SELECT COUNT([ModuleSystemName]) FROM [Module] WHERE [ModuleSystemName] = 'Campaigns'">
				    INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleParagraph], [ModuleIsBeta])
				    VALUES ('Campaigns', 'Campaigns', blnFalse, blnFalse, blnTrue)
                </sql>
            </Automation>
        </database>
    </package>

    <package version="793" releasedate="16-08-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <Automation>
                <sql conditional="">
                    CREATE TABLE AutomationPlan
                    (
	                    AutomationPlanId IDENTITY NOT NULL,
	                    AutomationPlanName NVARCHAR(255) NOT NULL,
	                    AutomationPlanTriggerType NVARCHAR(255) NOT NULL,
	                    AutomationPlanTriggerTime DATETIME NULL,
	                    AutomationPlanTriggerParameters NVARCHAR(MAX) NULL,
	                    CONSTRAINT AutomationPlan_PrimaryKey PRIMARY KEY(AutomationPlanId)
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE AutomationAction
                    (
	                    ActionId IDENTITY NOT NULL,
	                    ActionAutomationPlanId INT NOT NULL,
	                    ActionType NVARCHAR(255) NOT NULL,
	                    ActionDelayInSeconds FLOAT NULL,
	                    ActionParameters NVARCHAR(MAX) NULL,
	                    ActionOrder INT NOT NULL,
	                    CONSTRAINT AutomationAction_PrimaryKey PRIMARY KEY(ActionId),
	                    CONSTRAINT AutomationAction_ForeignKey FOREIGN KEY(ActionAutomationPlanId)
		                    REFERENCES AutomationPlan(AutomationPlanId)
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE Automation
                    (
	                    AutomationId IDENTITY NOT NULL,
	                    AutomationAutomationPlanId INT NOT NULL,
	                    AutomationPreviousActionTime DATETIME NULL,
	                    AutomationNextActionTime DATETIME NULL,
	                    AutomationNextActionIndex INT NOT NULL DEFAULT 0,
	                    AutomationState INT NOT NULL DEFAULT 1,
	                    CONSTRAINT Automation_PrimaryKey PRIMARY KEY(AutomationId)
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE AutomationActionExecution
                    (
	                    ActionExecutionId IDENTITY NOT NULL,
	                    ActionExecutionActionId INT NOT NULL,
	                    ActionExecutionAutomationId INT NOT NULL,
	                    ActionExecutionTime DATETIME NOT NULL,
	                    ActionExecutionSucceeded BIT NOT NULL,
	                    ActionExecutionErrorMessage NVARCHAR(MAX) NULL,
	                    ActionExecutionErrorStackTrace NVARCHAR(MAX) NULL,
	                    CONSTRAINT AutomationActionExecution_PrimaryKey PRIMARY KEY(ActionExecutionId),
	                    CONSTRAINT AutomationActionExecution_FKActionId FOREIGN KEY(ActionExecutionActionId)
		                    REFERENCES AutomationAction(ActionId),
	                    CONSTRAINT AutomationActionExecution_FKAutomationId FOREIGN KEY(ActionExecutionAutomationId)
		                    REFERENCES Automation(AutomationId)
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE AutomationContext
                    (
	                    AutomationContextAutomationId INT NOT NULL,
	                    AutomationContextKey NVARCHAR(255) NOT NULL,
	                    AutomationContextValue NVARCHAR(MAX) NULL,
	                    CONSTRAINT AutomationContext_PrimaryKey PRIMARY KEY (AutomationContextAutomationId, AutomationContextKey)
                    )
                </sql>
            </Automation>
        </database>
    </package>
    
    <package version="792" releasedate="15-08-2013" internalversion="8.3.0.0">
    </package>

    <package version="791" releasedate="07-08-2013" internalversion="8.3.0.0">
    </package>

    <package version="790" releasedate="07-08-2013" internalversion="8.3.0.0">
        <file name="Login_uk_password.html" target="Files/Templates/Extranet" source="Files/Templates/Extranet" />
        <file name="Login_dk_password.html" target="Files/Templates/Extranet" source="Files/Templates/Extranet" />
    </package>

    <package version="789" releasedate="31-07-2013" internalversion="8.3.0.0">
        <database file="Access.mdb">
            <AccessUser>
	            <sql conditional="">
	                ALTER TABLE AccessUser ADD AccessUserVatRegNumber NVARCHAR(20) NULL
	            </sql>
            </AccessUser>
        </database>
    </package>
    
    <package version="788" releasedate="29-07-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <Canonical>
	            <sql conditional="">
	                ALTER TABLE [Area] ADD [AreaIncludeProductsInSitemap] BIT  NOT NULL DEFAULT 0
	            </sql>
            </Canonical>
        </database>
    </package>

    <package version="787" releasedate="29-07-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <Canonical>
	            <sql conditional="">
	                ALTER TABLE [Page] ADD [PageMetaCanonical] NVARCHAR(255) NULL
	            </sql>
            </Canonical>
        </database>
    </package>

    <package version="786" releasedate="25-07-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    ALTER TABLE SocialTask DROP SocialTaskEndDate
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="785" releasedate="23-07-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    UPDATE [Module] SET ModuleName = 'Email Marketing' WHERE ModuleSystemName = 'EmailMarketing' AND ModuleName NOT LIKE 'Email Marketing'
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="784" releasedate="20-07-2013" internalversion="8.3.0.0">
        <setting key="/Globalsettings/Ecom/Price/List/UseCustomColumns" value="False" overwrite="False" />
        <setting key="/Globalsettings/Ecom/Price/List/CustomColumns" value="" overwrite="False" />
        <setting key="/Globalsettings/Ecom/Price/List/UseCustomOrder" value="False" overwrite="False" />
        <setting key="/Globalsettings/Ecom/Price/List/CustomOrder" value="" overwrite="False" />
    </package>
    
    <package version="783" releasedate="20-07-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
	        <Ecom>
	            <sql conditional="">
	                ALTER TABLE [EcomPrices] 
                    ADD [PriceCountry] NVARCHAR(5),
                        [PriceShopId] NVARCHAR(255),
                        [PriceValidFrom] DateTime NULL,
                        [PriceValidTo] DateTime NULL,
                        [PriceUserId] NVARCHAR(255),
                        [PriceUserGroupId] NVARCHAR(255)
	            </sql>
	        </Ecom>
        </database>
    </package>

    <package version="782" releasedate="19-07-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [IDX_RecipientIdRecipientSentTime]
                    ON [EmailRecipient] ([RecipientMessageId], [RecipientSentTime])
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [_dta_index_EmailRecipient_14_1369928102__K5_K1_K3_2_4] ON [dbo].[EmailRecipient]
                    (
	                    [RecipientMessageId] ASC,
	                    [RecipientId] ASC,
	                    [RecipientName] ASC
                    )
                    INCLUDE ([RecipientKey],
	                    [RecipientEmailAddress])
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [_dta_index_OMCLink_14_1465928444__K4_1_3] ON [dbo].[OMCLink]
                    (
	                    [LinkReferenceKey] ASC
                    )
                    INCLUDE ( 	[LinkId],
	                    [LinkReferenceType])
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [_dta_index_OMCLinkClick_14_1497928558__K2_K1_K5_3] ON [dbo].[OMCLinkClick]
                    (
	                    [LinkClickLinkId] ASC,
	                    [LinkClickId] ASC,
	                    [LinkClickSessionId] ASC
                    )
                    INCLUDE ( 	[LinkClickClickerKey])
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [_dta_index_OMCLink_14_1465928444__K4_K1_2] ON [dbo].[OMCLink]
                    (
	                    [LinkReferenceKey] ASC,
	                    [LinkId] ASC
                    )
                    INCLUDE ( 	[LinkUrl])
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [_dta_index_OMCLinkClick_14_1497928558__K5_K2] ON [dbo].[OMCLinkClick]
                    (
	                    [LinkClickSessionId] ASC,
	                    [LinkClickLinkId] ASC
                    )
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [_dta_index_OMCLinkClick_14_1497928558__K3_K2] ON [dbo].[OMCLinkClick]
                    (
	                    [LinkClickClickerKey] ASC,
	                    [LinkClickLinkId] ASC
                    )
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [_dta_index_OMCLinkClick_14_1497928558__K3_K2_5] ON [dbo].[OMCLinkClick]
                    (
	                    [LinkClickClickerKey] ASC,
	                    [LinkClickLinkId] ASC
                    )
                    INCLUDE ([LinkClickSessionId])
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="781" releasedate="11-07-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">            
            <SocialMessage>                                
                <sql conditional="">ALTER TABLE [SocialMessage] ADD [MessageDisableParseLinks] BIT NULL</sql>                    
            </SocialMessage>
        </database>
    </package>
    <package version="780" releasedate="10-07-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">            
            <SocialPost>                                
                <sql conditional="">ALTER TABLE [SocialPost] ADD [PostParsedText] NVARCHAR(MAX) NULL</sql>                    
            </SocialPost>
        </database>
    </package>

    <package version="779" releasedate="03-07-2013" internalversion="8.3.0.0">
        <database file="Access.mdb">
             <AccessUser>
                <sql conditional="">
                    CREATE INDEX [IX_AccessUserType] ON [AccessUser] 
                    (
                        [AccessUserType] ASC
                    )
                </sql>
                <sql conditional="">
                    CREATE INDEX [IX_AccessUserGroups] ON [AccessUser] 
                    (
                        [AccessUserGroups] ASC
                    )
                </sql>
            </AccessUser>
        </database>
        <database file="Dynamic.mdb">
             <EmailMarketingEngagementIndex>
                <sql conditional="">
                    CREATE INDEX [IX_EngagementIndexClickLinkIndex] ON [EmailMarketingEngagementIndex] 
                    (
                        [EngagementIndexClickLinkIndex] ASC
                    )
                </sql>
                <sql conditional="">
                    CREATE INDEX [IX_EngagementIndexClickLinkActive] ON [EmailMarketingEngagementIndex] 
                    (
                        [EngagementIndexClickLinkActive] ASC
                    )
                </sql>
            </EmailMarketingEngagementIndex>
        </database>
        <database file="Statisticsv2.mdb">
            <OMCLinkClick>
                <sql conditional="">
                    CREATE INDEX [IX_LinkClickSessionId] ON [OMCLinkClick] 
                    (
                        [LinkClickSessionId] ASC
                    )
                </sql>
                <sql conditional="">
                    CREATE INDEX [IX_LinkClickClickerKey] ON [OMCLinkClick] 
                    (
                        [LinkClickClickerKey] ASC
                    )
                </sql>
                <sql conditional="">
                    CREATE INDEX [IX_LinkClickLinkId] ON [OMCLinkClick] 
                    (
                        [LinkClickLinkId] ASC
                    )
                </sql>
            </OMCLinkClick>
            <OMCLink>
                <sql conditional="">
                    CREATE INDEX [IX_LinkReferenceKey] ON [OMCLink] 
                    (
                        [LinkReferenceKey] ASC
                    )
                </sql>
            </OMCLink>
        </database>
    </package>

    <package version="778" releasedate="26-06-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMessageTag>
                <sql conditional="">
                    CREATE TABLE [EmailMessageTag]
                    (
                        [MessageTagId] IDENTITY NOT NULL PRIMARY KEY,
                        [MessageTagMessageId] int NOT NULL,
                        [MessageTagName] nvarchar(255) NOT NULL,
                        [MessageTagValue] nvarchar (MAX) NULL,
                        [MessageTagDataType] nvarchar(255) NOT NULL   
                    )
                </sql>
            </EmailMessageTag>
        </database>
    </package>

	<package version="777" releasedate="24-06-2013" internalversion="8.3.0.0">
        <file name="basic.js" source="/Files/System/Editor/ckeditor/config/" target="/Files/System/Editor/ckeditor/config/" overwrite="false" />
        <file name="default.js" source="/Files/System/Editor/ckeditor/config/" target="/Files/System/Editor/ckeditor/config/" overwrite="false" />
        <file name="advanced.js" source="/Files/System/Editor/ckeditor/config/" target="/Files/System/Editor/ckeditor/config/" overwrite="false" />
    </package>

    <package version="776" releasedate="21-06-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
			<Module>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'EmailMarketing'">
					UPDATE [Module] SET [ModuleName] = 'eMail Marketing' WHERE [ModuleSystemName] = 'EmailMarketing'
				</sql>
			</Module>
		</database>
    </package>

	<package version="775" date="21-06-2013" internalversion="8.3.0.0">
		<database file="Dynamic.mdb">
		  <Paragraph>
			<sql conditional="">ALTER TABLE [Paragraph] ADD [ParagraphHideForPhones] BIT NULL</sql>
			<sql conditional="">ALTER TABLE [Paragraph] ADD [ParagraphHideForTablets] BIT NULL</sql>
			<sql conditional="">ALTER TABLE [Paragraph] ADD [ParagraphHideForDesktops] BIT NULL</sql>
		  </Paragraph>
		</database>
	</package>    

    <package version="774" releasedate="18-06-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
	        <Area>
	            <sql conditional="">
                    ALTER TABLE [Area] ADD
                    [AreaItemTypePageProperty] NVARCHAR(255) NULL
                </sql>
	        </Area>
            <Page>
	            <sql conditional="">
                    ALTER TABLE [Page] ADD
                    [PagePropertyItemId] NVARCHAR(255) NULL
                </sql>
            </Page>
        </database>
    </package>

    <package version="773" releasedate="17-06-2013" internalversion="8.3.0.0">
        <setting key="/Globalsettings/Ecom/Users/IncludeShopIdInExtranetLogIn" value="false" overwrite="false" />
    </package>

    <package version="772" releasedate="13-06-2013" internalversion="8.3.0.0">
        <setting key="/Globalsettings/Ecom/Navigation/EnableNavigationGroupSorting" value="false" overwrite="false" />
    </package>

    <package version="771" date="10-06-2013" internalversion="8.3.0.0">
		<database file="Dynamic.mdb">
			 <EmailTask>
				<sql conditional="">
                   CREATE TABLE [SocialTask]
                    (
                        [SocialTaskID] IDENTITY NOT NULL PRIMARY KEY,
                        [SocialTaskMessageID] int NOT NULL,
                        [SocialTaskType] tinyint NOT NULL,
                        [SocialTaskActive] bit NOT NULL,
                        [SocialTaskUrl] nvarchar(1024) NOT NULL,
                        [SocialTaskStartDate] datetime NOT NULL,
                        [SocialTaskEndDate] datetime NULL
                    )
				</sql>
                <sql conditional="">
                    CREATE INDEX [IX_SocialTaskActive] ON [SocialTask] 
                    (
	                    [SocialTaskActive] ASC
                    )
                </sql>
                <sql conditional="">
                    CREATE UNIQUE INDEX [IX_SocialTaskEmailIDType] ON [SocialTask] 
                    (
	                    [SocialTaskID] ASC,
	                    [SocialTaskType] ASC
                    )
                </sql>

			</EmailTask>
		</database>
	</package>


    <package version="770" releasedate="10-06-2013" internalversion="8.3.0.0">
        <database file="Access.mdb">
		    <Module>
                <sql conditional="select count(*) from [EditorConfiguration] where ([EditorConfigurationType]='SystemDefault' or [EditorConfigurationType]='SystemDefaultSelected') or ([EditorConfigurationType]='User' and [EditorConfigurationIsDefault]=blnTrue)">                    
                    insert into [EditorConfiguration] ([EditorConfigurationName], [EditorConfigurationXML], [EditorConfigurationType], [EditorConfigurationAddinProviderName], [EditorConfigurationIsDefault]) 
                    values ('Default', '<![CDATA[<?xml version="1.0" encoding="utf-8"?><Parameters><Parameter addin="Dynamicweb.TextEditorAddIns.CKEditor" name="Apply stylesheet in editor if editor.css does not exist" value="True" /><Parameter addin="Dynamicweb.TextEditorAddIns.CKEditor" name="Configuration Source" value="file" /><Parameter addin="Dynamicweb.TextEditorAddIns.CKEditor" name="Configuration File" value="System/Editor/ckeditor/config/default.js" /><Parameter addin="Dynamicweb.TextEditorAddIns.CKEditor" name="Document" value="" /><Parameter addin="Dynamicweb.TextEditorAddIns.CKEditor" name="Clipboard" value="" /><Parameter addin="Dynamicweb.TextEditorAddIns.CKEditor" name="Editing" value="" /><Parameter addin="Dynamicweb.TextEditorAddIns.CKEditor" name="Basic Styles" value="" /><Parameter addin="Dynamicweb.TextEditorAddIns.CKEditor" name="Paragraph" value="" /><Parameter addin="Dynamicweb.TextEditorAddIns.CKEditor" name="Links" value="" /><Parameter addin="Dynamicweb.TextEditorAddIns.CKEditor" name="Insert" value="" /><Parameter addin="Dynamicweb.TextEditorAddIns.CKEditor" name="Styles" value="" /><Parameter addin="Dynamicweb.TextEditorAddIns.CKEditor" name="Tools" value="" /><Parameter addin="Dynamicweb.TextEditorAddIns.CKEditor" name="Format list" value="address,div,h1,h2,h3,h4,h5,h6,p,pre" /></Parameters>]]>', 
                    'User', 'Dynamicweb.TextEditorAddIns.CKEditor', blnTrue)
                </sql>                
		    </Module>
        </database>
    </package>

    <package version="769" releasedate="10-06-2013" internalversion="8.3.0.0">
        <database file="Access.mdb">
		    <Module>
                <sql conditional="">
                    ALTER TABLE [EditorConfiguration] ADD [EditorConfigurationIsDefault] BIT NULL
                </sql>                
		    </Module>
        </database>
    </package>

    <package version="768" releasedate="10-06-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                        update Module
                        set ModuleAccess = 1
                        where ModuleSystemName = 'EmailMarketing' and (select count(ModuleID) from Module where ModuleSystemName = 'NewsletterV3' and ModuleAccess = 1) > 0
                </sql>               
            </EmailMarketing>
        </database>
    </package>

    <package version="767" releasedate="10-06-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] ADD [EmailUnsubscribeText] NVARCHAR(255) NULL 
                </sql>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] ADD [EmailVariationUnsubscribeText] NVARCHAR(255) NULL
                </sql>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingTopFolder] ADD [TopFolderUnsubscribeText] NVARCHAR(255) NULL
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="766" date="07-06-2013" internalversion="8.3.0.0">
		<database file="Dynamic.mdb">
			 <EmailTask>
				<sql conditional="">
                   ALTER TABLE [EmailMarketingEmail]
                        ADD [EmailScheduledActive] bit NOT NULL DEFAULT 0,
                            [EmailScheduledSendTime] datetime NULL
				</sql>

                 <sql conditional="">
                    CREATE INDEX [EmailMarketingEmailTaskActive] ON [EmailMarketingEmail] 
                    (
	                    [EmailScheduledActive] ASC
                    )
                </sql>

                <sql conditional="">
                   ALTER TABLE [EmailMarketingSplitTest]
                        ADD [SplitTestScheduledSendActive] bit NOT NULL DEFAULT 0,
                            [SplitTestScheduledSendTime] datetime NULL,
                            [SplitTestScheduledPickWinnerActive] bit NOT NULL DEFAULT 0,
                            [SplitTestScheduledPickWinnerTime] datetime NULL
				</sql>

                 <sql conditional="">
                    CREATE INDEX [EmailMarketingSplitTestSendTaskActive] ON [EmailMarketingSplitTest] 
                    (
	                    [SplitTestScheduledSendActive] ASC
                    )
                </sql>

                 <sql conditional="">
                    CREATE INDEX [EmailMarketingSplitTestWinnerTaskActive] ON [EmailMarketingSplitTest] 
                    (
	                    [SplitTestScheduledPickWinnerActive] ASC
                    )
                </sql>
			</EmailTask>
		</database>
	</package>

    <package version="765" date="21-05-2013" internalversion="8.3.0.0">
		<database file="Statisticsv2.mdb">
			 <Statv2Object>
				<sql conditional="">
                    ALTER TABLE [Statv2Object] ADD [StatV2ObjectVisitorID] NVARCHAR(24) NULL
				</sql>

                <sql conditional="SELECT COUNT(*) FROM [sysindexes] WHERE [name] = 'DW_IX_StatV2Object_StatV2ObjectVisitorID'">
                    CREATE NONCLUSTERED INDEX [DW_IX_StatV2Object_StatV2ObjectVisitorID] ON [dbo].[Statv2Object] 
                    (
	                    [StatV2ObjectVisitorID] ASC
                    ) WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
                </sql>
			</Statv2Object>
		</database>
	</package>

	<package version="765" releasedate="17-05-2013" internalversion="8.3.0.0">
        <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'ecom_NAVIntegration' AND [ModuleAccess] = blnTrue">
		DELETE FROM [Module] WHERE [ModuleSystemName] = 'ecom_NAVIntegration'
		</sql>
    </package>	

    <package version="764" releasedate="17-05-2013" internalversion="8.3.0.0">
        <setting key="/Globalsettings/System/Filesystem/FilesFolderName" value="Files" overwrite="false" />
    </package>

    <package version="763" releasedate="16-05-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] DROP [EmailUnsubscribePageText]
                </sql>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] DROP [EmailVariationUnsubscribePageText]
                </sql>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingTopFolder] DROP [TopFolderUnsubscribePageText]
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="762" releasedate="15-05-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingTopFolder] ADD [TopFolderDeliveryProviderId] INT NULL
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="761" releasedate="13-05-2013" internalversion="8.3.0.0">
        <file name="ExportUsers.xml" source="/Files/System/Integration/Jobs/ModuleSpecificJobs/UserManagementModuleJobs/ExportJobs" target="/Files/System/Integration/Jobs/ModuleSpecificJobs/UserManagementModuleJobs/ExportJobs" overwrite="false" />
    </package>
    <package version="760" releasedate="08-05-2013" internalversion="8.3.0.0">
        <file name="ImportUsers.xml" source="/Files/System/Integration/Jobs/ModuleSpecificJobs/UserManagementModuleJobs/ImportJobs" target="/Files/System/Integration/Jobs/ModuleSpecificJobs/UserManagementModuleJobs/ImportJobs" overwrite="false" />
    </package>

    <package version="759" releasedate="07-05-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] ADD [EmailIsTemplate] BIT NULL
                </sql>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] ADD [EmailTemplateName] NVARCHAR(255) NULL
                </sql>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] ADD [EmailTemplateDescription] NVARCHAR(MAX) NULL
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="758" releasedate="03-05-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <SocialPost>
                <sql conditional="">
                     ALTER TABLE [SocialPost] DROP [PostResultException]
                </sql>
            </SocialPost>
        </database>
    </package>

    <package version="757" releasedate="29-04-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                     ALTER TABLE [EmailMarketingSplitTest] ADD [SplitTestStartDateTimeZoneId] NVARCHAR(256) NULL
                </sql>
                <sql conditional="">
                     ALTER TABLE [EmailMarketingSplitTest] ADD [SplitTestEndDateTimeZoneId] NVARCHAR(256) NULL
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="756" releasedate="24-04-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                     ALTER TABLE [EmailMarketingEmail] DROP [EmailName]
                </sql>
                <sql conditional="">
                     ALTER TABLE [EmailMarketingEmail] DROP [EmailDescription]
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="755" releasedate="22-04-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                     ALTER TABLE [EmailMarketingEmail] DROP [EmailSubscribePageId]
                </sql>
                <sql conditional="">
                     ALTER TABLE [EmailMarketingEmail] DROP [EmailSubscribePageText]
                </sql>
            </EmailMarketing>
            <EmailMarketingTopFolder>
                <sql conditional="">
                     ALTER TABLE [EmailMarketingTopFolder] DROP [TopFolderSubscribePageId]
                </sql>
                <sql conditional="">
                     ALTER TABLE [EmailMarketingTopFolder] DROP [TopFolderSubscribePageText]
                </sql>
            </EmailMarketingTopFolder>
        </database>
    </package>

	<package version="754" releasedate="18-04-2013" internalversion="8.3.0.0">
        <setting key="/Globalsettings/Ecom/Cart/SavedForLaterValidTime" value="1" overwrite="false" />
    </package>

    <package version="753" releasedate="18-04-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
		    <Triggers>
                <sql conditional=""> DROP TRIGGER  dbo.[T_AccessCompetence_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_AccessCustomFieldDepartm_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_AccessCustomFieldDepartm_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_AccessEmployeeCompetence_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_AccessEmployeeCompetence_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_AccessEmployeeDepartment_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_AccessEmployeeDepartment_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_AccessUser_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_AccessUser_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ContentGroupRelation_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ContentGroupRelation_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ContentLink_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ContentLink_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ForumV2Category_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ForumV2Category_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ForumV2Moderator_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ForumV2Moderator_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ForumV2Post_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ForumV2Post_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ForumV2Thread_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ForumV2Thread_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ForumV2Thread_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ForumV2Vote_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ForumV2Vote_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ForumV2VoteVariant_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ForumV2VoteVariant_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_FPV2Download_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_FPV2Download_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_FPV2File_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_FPV2File_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_FPV2Permission_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_FPV2Permission_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_FPV2Resource_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_FPV2Resource_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_FPV2Subscription_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_FPV2Subscription_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_FPV2Upload_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_FPV2Upload_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_HRAccessUser_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_HRAccessUser_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_IntranoteBrokenLink_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_IntranoteBrokenLink_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_IntranoteHtml_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_IntranoteHtml_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_IntranotePost_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_IntranotePost_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_IntranotePostType_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_IntranotePostType_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_NewsletterExtendedUserFi_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_NewsletterExtendedUserFi_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_NewsletterExtendedUserFi_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ShopGroup_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ShopGroup_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ShopOrder_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ShopOrder_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ShopOrderLine_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ShopOrderLine_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ShopProduct_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ShopProduct_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ShopProductField_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ShopProductField_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ShopProductFieldType_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ShopProductFieldType_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_WeblogArticle_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_WeblogArticle_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_WeblogArticle_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_WeblogBlog_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_WeblogBlog_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_WeblogCategory_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_WeblogCategory_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_WeblogComment_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_WeblogComment_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_WeblogSubscribe_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_WeblogSubscribe_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_WeblogTeam_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_WeblogTeam_UTrig] </sql>
            </Triggers>
        </database>
    </package>

    <package  version="752" releasedate="16-04-2013" internalversion="8.3.0.0">
        <file name="Average time per visit.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false"/>
        <file name="Most Visited Pages.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false"/>
        <file name="Search words.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false"/>
        <file name="Visitors per device.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false"/>
        <file name="Visitors per hour.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false"/>
        <file name="Visits per weekday.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false"/>
    </package>

    <package version="751" date="15-04-2013" internalversion="8.3.0.0">
       <database file="Dynamic.mdb">
           <Module>
               <sql conditional="">
                   UPDATE [Module] SET ModuleAccess = blnTrue WHERE modulesystemname = 'ItemPublisher'
               </sql>
           </Module>
       </database>
    </package>
    
    <package version="750" date="11-04-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <Module>
                <sql conditional="">
                    UPDATE [EmailMarketingEmail] SET EmailOriginalMessageId = EmailMessageId WHERE EmailOriginalMessageId IS NULL OR EmailOriginalMessageId = 0
                </sql>
            </Module>
        </database>
    </package>

    <package version="749" releasedate="11-04-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] DROP CONSTRAINT [EmailMarketingEmail_PageIdForeignKey]
                </sql>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] DROP CONSTRAINT [EmailMarketingEmail_SubscriptionPageIdForeignKey]
                </sql>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] DROP CONSTRAINT [EmailMarketingEmail_UnsubscriptionPageIdForeignKey]
                </sql>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] DROP CONSTRAINT [EmailMarketingEmail_VariationPageIdForeignKey]
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="748" releasedate="10-04-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] ADD [EmailOriginalMessageId] INT NULL
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package  version="747" releasedate="04-09-2013" internalversion="8.3.0.0">
        <file name="ChangeExpiredPassword.html" source="/Files/Templates/Extranet" target="/Files/Templates/Extranet" overwrite="false"/>
    </package>

    <package version="746" releasedate="29-03-2013" internalversion="8.3.0.0">
        <database file="Access.mdb">
		    <AccessUser>
                <sql conditional="">
                    ALTER TABLE AccessUser ADD AccessUserState NVARCHAR(255) NULL
                </sql>
		    </AccessUser>
	    </database>
    </package>

	<package version="745" date="27-03-2013" internalversion="8.3.0.0">
		<database file="Statisticsv2.mdb">
			 <Statv2Object>
				<sql conditional="">
                    ALTER TABLE Statv2Object ADD Statv2ObjectOvnerID NVARCHAR(50) NULL
				</sql>
			</Statv2Object>
		</database>
	</package>

    <package  version="744" releasedate="20-03-2013" internalversion="8.3.0.0">
        <file name="Maps-current-location-custom.html" source="/Files/Templates/Maps/templates" target="/Files/Templates/Maps/templates" overwrite="false"/>
        <file name="Maps-filter-by-group-name.html" source="/Files/Templates/Maps/templates" target="/Files/Templates/Maps/templates" overwrite="false"/>
        <file name="Maps-filter.html" source="/Files/Templates/Maps/templates" target="/Files/Templates/Maps/templates" overwrite="false"/>
        <file name="Maps-find-nearest.html" source="/Files/Templates/Maps/templates" target="/Files/Templates/Maps/templates" overwrite="false"/>
        <file name="Maps-search-content-custom.html" source="/Files/Templates/Maps/templates" target="/Files/Templates/Maps/templates" overwrite="false"/>
        <file name="Maps-search-content.html" source="/Files/Templates/Maps/templates" target="/Files/Templates/Maps/templates" overwrite="false"/>
        <file name="Maps-search-custom.html" source="/Files/Templates/Maps/templates" target="/Files/Templates/Maps/templates" overwrite="false"/>
        <file name="Maps-search.html" source="/Files/Templates/Maps/templates" target="/Files/Templates/Maps/templates" overwrite="false"/>
        <file name="Maps-sorting-custom.html" source="/Files/Templates/Maps/templates" target="/Files/Templates/Maps/templates" overwrite="false"/>
        <file name="Maps-sorting.html" source="/Files/Templates/Maps/templates" target="/Files/Templates/Maps/templates" overwrite="false"/>
        <file name="Maps-with-groups.html" source="/Files/Templates/Maps/templates" target="/Files/Templates/Maps/templates" overwrite="false"/>
    </package>

    <package version="743" releasedate="17-03-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMessaging>
                <sql conditional="">
                    ALTER TABLE [EmailMessage] ADD [MessageDeliveryProviderId] INT NULL
                </sql>
            </EmailMessaging>
        </database>
    </package>

    <package version="742" releasedate="17-03-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    ALTER TABLE [EmailMarketingEmail] ADD [EmailDeliveryProviderId] INT NULL
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="741" releasedate="15-03-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketingFolders>
                <sql conditional="SELECT COUNT(*) FROM [EmailMarketingFolder] WHERE [FolderName] = 'Drafts' AND [FolderParentId] = 0">
                    INSERT INTO EmailMarketingFolder ([FolderParentId], [FolderName])
                    VALUES (0, 'Drafts')
                </sql>
                <sql conditional="SELECT COUNT(*) FROM [EmailMarketingFolder] WHERE [FolderName] = 'Scheduled' AND [FolderParentId] = 0">
                    INSERT INTO EmailMarketingFolder ([FolderParentId], [FolderName])
                    VALUES (0, 'Scheduled')
                </sql>
                <sql conditional="SELECT COUNT(*) FROM [EmailMarketingFolder] WHERE [FolderName] = 'Split Tests' AND [FolderParentId] = 0">
                    INSERT INTO EmailMarketingFolder ([FolderParentId], [FolderName])
                    VALUES (0, 'Split Tests')
                </sql>
                <sql conditional="SELECT COUNT(*) FROM [EmailMarketingFolder] WHERE [FolderName] = 'Sent' AND [FolderParentId] = 0">
                    INSERT INTO EmailMarketingFolder ([FolderParentId], [FolderName])
                    VALUES (0, 'Sent')
                </sql>
            </EmailMarketingFolders>
        </database>
    </package>

    <package version="740" releasedate="15-03-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <!-- This is an EmailMarketing clean-up package -->
                <sql conditional="">
                    CREATE TABLE [EmailMarketingTopFolder]
                    (
                        TopFolderId IDENTITY NOT NULL,
                        TopFolderName NVARCHAR(255) NULL,
                        TopFolderSenderName NVARCHAR(255) NULL,
                        TopFolderSenderEmail NVARCHAR(255) NULL,
                        TopFolderSubject NVARCHAR(255) NULL,
                        TopFolderDomainName NVARCHAR(255) NULL,
                        TopFolderTrackingProviderConfiguration NVARCHAR(MAX) NULL,
                        TopFolderSubscribePageId INT NULL,
                        TopFolderSubscribePageText NVARCHAR(255) NULL,
                        TopFolderUnsubscribePageId INT NULL,
                        TopFolderUnsubscribePageText NVARCHAR(255) NULL,
                        CONSTRAINT EmailMarketingTopFolder_PrimaryKey PRIMARY KEY([TopFolderId])
                    )
                </sql>
                <sql conditional="">
                    SET IDENTITY_INSERT [EmailMarketingTopFolder] ON
                </sql>
                <sql conditional="">
                    INSERT INTO [EmailMarketingTopFolder]
                    (
                        TopFolderId,
                        TopFolderName,
                        TopFolderSenderName,
                        TopFolderSenderEmail,
                        TopFolderSubject,
                        TopFolderDomainName,
                        TopFolderTrackingProviderConfiguration,
                        TopFolderSubscribePageId,
                        TopFolderSubscribePageText,
                        TopFolderUnsubscribePageId,
                        TopFolderUnsubscribePageText
                    )
                    SELECT
                        TopFolderId,
                        TopFolderName,
                        TopFolderSenderName,
                        TopFolderSenderEmail,
                        TopFolderSubject,
                        TopFolderDomainName,
                        TopFolderTrackingProviderConfiguration,
                        TopFolderSubscribePageId,
                        TopFolderSubscribePageText,
                        TopFolderUnsubscribePageId,
                        TopFolderUnsubscribePageText
                    FROM
	                    [EmailMarketingTopFolders]
                </sql>
                <sql conditional="">
                    SET IDENTITY_INSERT [EmailMarketingTopFolder] OFF
                </sql>
                <sql conditional="">
                    CREATE TABLE EmailMarketingFolder
                    (
                        FolderId IDENTITY NOT NULL,
                        FolderParentId  INT NULL,
                        FolderName NVARCHAR(255) NULL,
                        FolderTopFolderId INT NULL,
                        CONSTRAINT EmailMarketingFolder_PrimaryKey PRIMARY KEY([FolderId])
                    )
                </sql>
                <sql conditional="">
                    SET IDENTITY_INSERT [EmailMarketingFolder] ON
                </sql>
                <sql conditional="">
                    INSERT INTO [EmailMarketingFolder]
                    (
                        FolderId,
                        FolderParentId,
                        FolderName,
                        FolderTopFolderId
                    )
                    SELECT
                        FolderId,
                        FolderParentId,
                        FolderName,
                        TopFolderId
                    FROM
	                    [EmailMarketingFolders]
                </sql>
                <sql conditional="">
                    SET IDENTITY_INSERT [EmailMarketingFolder] OFF
                </sql>
                <sql conditional="">
                    DROP TABLE [EmailMarketingFolders]
                </sql>
                <sql conditional="">
                    DROP TABLE [EmailMarketingTopFolders]
                </sql>
                <sql conditional="">
                    DROP TABLE [CampaignManagerNewsletterHistory]
                </sql>
				<sql conditional="">
					CREATE TABLE [EmailMarketingEmail] (
						[EmailId] IDENTITY NOT NULL,
						[EmailName] NVARCHAR(255) NULL,
						[EmailDescription] NVARCHAR(MAX) NULL,
						[EmailPageId] INT NULL,
						[EmailRecipientProviderConfiguration] NVARCHAR(MAX) NULL,
						[EmailTemplate] NVARCHAR(255) NULL,
						[EmailSenderName] NVARCHAR(255) NOT NULL,
						[EmailSenderEmail] NVARCHAR(255) NOT NULL,
						[EmailSubject] NVARCHAR(255) NOT NULL,
						[EmailFileAttachmentPath] NVARCHAR(255) NULL,
						[EmailEncoding] NVARCHAR(50) NOT NULL,
						[EmailTrackingProviderConfiguration] NVARCHAR(MAX) NULL,
						[EmailSubscribePageId] INT NULL,
						[EmailSubscribePageText] NVARCHAR(255) NULL,
						[EmailUnsubscribePageId] INT NULL,
						[EmailUnsubscribePageText] NVARCHAR(255) NULL,
						[EmailMessageId] NVARCHAR(255) NULL,
						[EmailDomainName] NVARCHAR(255) NULL,
						[EmailVariationName] NVARCHAR(255) NULL,
						[EmailVariationEmail] NVARCHAR(255) NULL,
						[EmailVariationSubject] NVARCHAR(255) NULL,
						[EmailVariationPageId] INT NULL,
						[EmailVariationUnsubscribePageText] NVARCHAR(255) NULL,
						[EmailVariationMessageId] NVARCHAR(255) NULL,
						[EmailSplitTestIsSent] BIT NOT NULL,
                        [EmailFolderId] INT NULL,
                        [EmailCreatedDate] DATETIME NULL,
                        [EmailTopFolderId] INT NULL,
						CONSTRAINT EmailMarketingEmail_PrimaryKey PRIMARY KEY([EmailId])
					)
				</sql>
                <sql conditional="">
                    SET IDENTITY_INSERT [EmailMarketingEmail] ON
                </sql>
                <sql conditional="">
                    INSERT INTO [EmailMarketingEmail]
                    (
	                    [EmailId],
	                    [EmailName],
	                    [EmailDescription],
	                    [EmailPageId],
	                    [EmailRecipientProviderConfiguration],
	                    [EmailTemplate],
	                    [EmailSenderName],
	                    [EmailSenderEmail],
	                    [EmailSubject],
	                    [EmailFileAttachmentPath],
	                    [EmailEncoding],
	                    [EmailTrackingProviderConfiguration],
	                    [EmailSubscribePageId],
	                    [EmailSubscribePageText],
	                    [EmailUnsubscribePageId],
	                    [EmailUnsubscribePageText],
	                    [EmailMessageId],
	                    [EmailDomainName],
	                    [EmailVariationName],
	                    [EmailVariationEmail],
	                    [EmailVariationSubject],
	                    [EmailVariationPageId],
	                    [EmailVariationUnsubscribePageText],
	                    [EmailVariationMessageId],
	                    [EmailSplitTestIsSent],
	                    [EmailFolderId],
	                    [EmailCreatedDate],
	                    [EmailTopFolderId]
                    )
                    SELECT
	                    [NewsletterId],
	                    [NewsletterName],
	                    [NewsletterDescription],
	                    [NewsletterPageId],
	                    [NewsletterRecipientProviderConfiguration],
	                    [NewsletterTemplate],
	                    [NewsletterSenderName],
	                    [NewsletterSenderEmail],
	                    [NewsletterSubject],
	                    [NewsletterFileAttachmentPath],
	                    [NewsletterEncoding],
	                    [NewsletterTrackingProviderConfiguration],
	                    [NewsletterSubscribePageId],
	                    [NewsletterSubscribePageText],
	                    [NewsletterUnsubscribePageId],
	                    [NewsletterUnsubscribePageText],
	                    [NewsletterMessageId],
	                    [NewsletterDomainName],
	                    [NewsletterVariationName],
	                    [NewsletterVariationEmail],
	                    [NewsletterVariationSubject],
	                    [NewsletterVariationPageId],
	                    [NewsletterVariationUnsubscribePageText],
	                    [NewsletterVariationMessageId],
	                    [NewsletterSplitTestIsSent],
	                    [NewsletterEmailMarketingFolderId],
	                    [NewsletterCreateDate],
	                    [NewsletterEmailMarketingTopFolderId]
                    FROM
	                    [CampaignManagerNewsletter]
                </sql>
                <sql conditional="">
                    SET IDENTITY_INSERT [EmailMarketingEmail] OFF
                </sql>
				<sql conditional="">
					CREATE TABLE [EmailMarketingSplitTest] (
						[SplitTestId] IDENTITY NOT NULL,
						[SplitTestEmailId] INT NULL,
						[SplitTestName] NVARCHAR(255) NULL,
						[SplitTestIncludes] INT NULL,
						[SplitTestIncludesUnits] INT NOT NULL,
						[SplitTestGoalType] NVARCHAR(50) NOT NULL,
						[SplitTestActive] BIT NULL,
						[SplitTestStartDate] DATETIME NULL,
						[SplitTestEndDate] DATETIME NULL,
						[SplitTestEndType] INT NOT NULL,
						[SplitTestOpenedEmails] INT NULL,
						[SplitTestOpenedEmailsUnits] INT NOT NULL,
						[SplitTestHoursTillEnd] INT NULL,
						[SplitTestAfterEndSendBest] BIT NULL,
						[SplitTestAfterEndNotify] BIT NULL,
						[SplitTestAfterEndActionEmail] NVARCHAR(255) NULL,
						CONSTRAINT EmailMarketingSplitTest_PrimaryKey PRIMARY KEY([SplitTestId]),
						CONSTRAINT EmailMarketingSplitTest_EmailIdForeignKey FOREIGN KEY([SplitTestEmailId])
							REFERENCES EmailMarketingEmail([EmailId])
					)
				</sql>
                <sql conditional="">
                    SET IDENTITY_INSERT [EmailMarketingSplitTest] ON
                </sql>
                <sql conditional="">
                    INSERT INTO [EmailMarketingSplitTest]
                    (
						[SplitTestId],
						[SplitTestEmailId],
						[SplitTestName],
						[SplitTestIncludes],
						[SplitTestIncludesUnits],
						[SplitTestGoalType],
						[SplitTestActive],
						[SplitTestStartDate],
						[SplitTestEndDate],
						[SplitTestEndType],
						[SplitTestOpenedEmails],
						[SplitTestOpenedEmailsUnits],
						[SplitTestHoursTillEnd],
						[SplitTestAfterEndSendBest],
						[SplitTestAfterEndNotify],
						[SplitTestAfterEndActionEmail]
                    )
                    SELECT
						[SplitTestID],
						[SplitTestNewsletterID],
						[SplitTestName],
						[SplitTestIncludes],
						[SplitTestIncludesUnits],
						[SplitTestGoalType],
						[SplitTestActive],
						[SplitTestStartDate],
						[SplitTestEndDate],
						[SplitTestEndType],
						[SplitTestOpenedNewsletters],
						[SplitTestOpenedNewslettersUnits],
						[SplitTestHoursTillEnd],
						[SplitTestAfterEndSendBest],
						[SplitTestAfterEndNotify],
						[SplitTestAfterEndActionEmail]
                    FROM
	                    [CampaignManagerSplitTest]
                </sql>
                <sql conditional="">
                    SET IDENTITY_INSERT [EmailMarketingSplitTest] OFF
                </sql>
				<sql conditional="">
					CREATE TABLE [EmailMarketingEngagementIndex] (
						[EngagementIndexId] IDENTITY NOT NULL,
						[EngagementIndexEmailId] INT NULL,
						[EngagementIndexOpenMailIndex] INT NULL,
						[EngagementIndexOpenMailActive] BIT NULL,
						[EngagementIndexClickLinkIndex] INT NULL,
						[EngagementIndexClickLinkActive] BIT NULL,
						[EngagementIndexAddingProductsIndex] INT NULL,
						[EngagementIndexAddingProductsActive] BIT NULL,
						[EngagementIndexPlacingOrderIndex] INT NULL,
						[EngagementIndexPlacingOrderActive] BIT NULL,
						[EngagementIndexSigningEmailIndex] INT NULL,
						[EngagementIndexSigningEmailActive] BIT NULL,
						[EngagementIndexUnsubscribesEmailIndex] INT NULL,
						[EngagementIndexUnsubscribesEmailActive] BIT NULL,
						[EngagementIndexOriginalLinks] NVARCHAR(MAX) NULL,
						[EngagementIndexVariantLinks] NVARCHAR(MAX) NULL,
                        [EngagementIndexTopFolderId] INT NULL,
						CONSTRAINT EmailMarketingEngagementIndex_PrimaryKey PRIMARY KEY(EngagementIndexId),
						CONSTRAINT EmailMarketingEngagementIndex_EmailIdForeignKey FOREIGN KEY([EngagementIndexEmailId])
							REFERENCES EmailMarketingEmail([EmailId])
					)
				</sql>
                <sql conditional="">
                    SET IDENTITY_INSERT [EmailMarketingEngagementIndex] ON
                </sql>
                <sql conditional="">
                    INSERT INTO [EmailMarketingEngagementIndex]
                    (
						[EngagementIndexId],
						[EngagementIndexEmailId],
						[EngagementIndexOpenMailIndex],
						[EngagementIndexOpenMailActive],
						[EngagementIndexClickLinkIndex],
						[EngagementIndexClickLinkActive],
						[EngagementIndexAddingProductsIndex],
						[EngagementIndexAddingProductsActive],
						[EngagementIndexPlacingOrderIndex],
						[EngagementIndexPlacingOrderActive],
						[EngagementIndexSigningEmailIndex],
						[EngagementIndexSigningEmailActive],
						[EngagementIndexUnsubscribesEmailIndex],
						[EngagementIndexUnsubscribesEmailActive],
						[EngagementIndexOriginalLinks],
						[EngagementIndexVariantLinks],
                        [EngagementIndexTopFolderId]
                    )
                    SELECT
						[EngagementIndexID],
						[EngagementIndexNewsletterID],
						[EngagementIndexOpenMailIndex],
						[EngagementIndexOpenMailActive],
						[EngagementIndexClickLinkIndex],
						[EngagementIndexClickLinkActive],
						[EngagementIndexAddingProductsIndex],
						[EngagementIndexAddingProductsActive],
						[EngagementIndexPlacingOrderIndex],
						[EngagementIndexPlacingOrderActive],
						[EngagementIndexSigningNewsletterIndex],
						[EngagementIndexSigningNewsletterActive],
						[EngagementIndexUnsubscribesNewsletterIndex],
						[EngagementIndexUnsubscribesNewsletterActive],
						[EngagementIndexOriginalLinks],
						[EngagementIndexVariantLinks],
                        [EngagementIndexTopFolderId]
                    FROM
	                    [CampaignManagerEngagementIndex]
                </sql>
                <sql conditional="">
                    SET IDENTITY_INSERT [EmailMarketingEngagementIndex] OFF
                </sql>
                <sql conditional="">
                    DROP TABLE [CampaignManagerEngagementIndex]
                </sql>
                <sql conditional="">
                    DROP TABLE [CampaignManagerSplitTest]
                </sql>
                <sql conditional="">
                    DROP TABLE [CampaignManagerNewsletter]
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="739" releasedate="15-03-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <EmailMarketing>
                <sql conditional="">
                    CREATE TABLE EmailDeliveryProvider
                    (
	                    DeliveryProviderId IDENTITY NOT NULL,
	                    DeliveryProviderName NVARCHAR(255) NOT NULL,
	                    DeliveryProviderConfiguration NVARCHAR(MAX) NOT NULL,
	                    CONSTRAINT EmailDeliveryProvider_PrimaryKey PRIMARY KEY(DeliveryProviderId)
                    )
                </sql>
            </EmailMarketing>
        </database>
    </package>

    <package version="738" releasedate="14-03-2013" internalversion="8.3.0.0">
        <!--<database file="Dynamic.mdb">
            <EmailMarketingTopFolders>
                <sql conditional="">
                    CREATE TABLE [EmailMarketingTopFolders]
                    (
                        TopFolderId IDENTITY NOT NULL,
                        TopFolderName VARCHAR(255) NULL,
                        TopFolderSenderName VARCHAR(255) NULL,
                        TopFolderSenderEmail VARCHAR(255) NULL,
                        TopFolderSubject VARCHAR(255) NULL,
                        TopFolderDomainName VARCHAR(255) NULL,
                        TopFolderTrackingProviderConfiguration VARCHAR(MAX) NULL,
                        TopFolderSubscribePageId INT NULL,
                        TopFolderSubscribePageText VARCHAR(255) NULL,
                        TopFolderUnsubscribePageId INT NULL,
                        TopFolderUnsubscribePageText VARCHAR(255) NULL,
                        CONSTRAINT CMTopFolder_PrimaryKey PRIMARY KEY([TopFolderId])
                    )
                </sql>
            </EmailMarketingTopFolders>
            <CampaignManagerNewsletter>
                <sql conditional="">
                    ALTER TABLE CampaignManagerNewsletter ADD NewsletterEmailMarketingTopFolderId INT NULL
               </sql>
            </CampaignManagerNewsletter>
            <EmailMarketingFolders>
                <sql conditional="">
                    ALTER TABLE EmailMarketingFolders ADD TopFolderId INT NULL
               </sql>
            </EmailMarketingFolders>
            <CampaignManagerEngagementIndex>
                <sql conditional="">
                    ALTER TABLE [CampaignManagerEngagementIndex] ADD [EngagementIndexTopFolderId] INT NULL
               </sql>
            </CampaignManagerEngagementIndex>
        </database>-->
    </package>

    <package version="737" releasedate="11-03-2013" internalversion="8.3.0.0">
        <file name="edit.js" source="/Files/Templates/ItemPublisher/Edit" target="/Files/Templates/ItemPublisher/Edit" />
    </package>

	<package version="736" releasedate="06-03-2013" internalversion="8.3.0.0">
        <file name="Coloumn_LightboxList.html" target="Files/Templates/MediaDB" source="Files/Templates/MediaDB" />
    </package>

    <package version="735" releasedate="25-02-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <AddInManager>
                <sql conditional="">
                    CREATE TABLE AddInManagerAddIn
                    (
	                    AddInManagerAddInName NVARCHAR(255) NOT NULL,
	                    AddInManagerAddInDisabled BIT NOT NULL DEFAULT 0,
	                    CONSTRAINT AddInManagerAddIn_PrimaryKey PRIMARY KEY(AddInManagerAddInName)
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE AddInManagerExecution
                    (
	                    AddInManagerExecutionId IDENTITY NOT NULL,
	                    AddInManagerExecutionAddInName NVARCHAR(255) NOT NULL,
	                    AddInManagerExecutionTime FLOAT NOT NULL,
	                    CONSTRAINT AddInManagerExecution_PrimaryKey PRIMARY KEY(AddInManagerExecutionId),
	                    CONSTRAINT AddInManagerExecution_AddInManagerAddInForeignKey FOREIGN KEY(AddInManagerExecutionAddInName)
		                    REFERENCES AddInManagerAddIn(AddInManagerAddInName)
                    )
                </sql>
            </AddInManager>
        </database>
    </package>

    <package version="734" releasedate="22-02-2013" internalversion="8.3.0.0">
        <database file="Access.mdb">
		    <AccessUser>
                <sql conditional="">
                    ALTER TABLE AccessUser ADD AccessUserEmailPermissionUpdatedOn DATETIME NULL
                </sql>
		    </AccessUser>
	    </database>
    </package>

	<package version="733" releasedate="19-02-2013" internalversion="8.3.0.0">
        <file name="ShowCartSavedForLater.html" source="Files/Templates/eCom7/CartV2/Step" target="Files/Templates/eCom7/CartV2/Step" overwrite="false" />
    </package>

    <package version="732" releasedate="14-02-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
		    <Module>
			    <sql conditional="">
                    ALTER TABLE Comment ADD CommentActive bit null DEFAULT 1
			    </sql>
		    </Module>
	    </database>
    </package>

	<package version="731" date="19-02-2013" internalversion="8.3.0.0">
		<database file="Statisticsv2.mdb">
			 <OMCExperimentView>
				<sql conditional="">
                    ALTER TABLE OMCExperimentView ADD OMCExperimentViewGoalValue NVARCHAR(50) NULL
				</sql>
			</OMCExperimentView>
		</database>
	</package>

    <package version="730" releasedate="19-02-2013" internalversion="8.3.0.0">
        <file name="SavedForLater.html" source="Files/Templates/eCom/Product" target="Files/Templates/eCom/Product" overwrite="false" />
    </package>

    <package version="729" releasedate="18-02-2013" internalversion="8.3.0.0">
        <!--<database file="Dynamic.mdb">
            <EmailMarketingFolders>
                <sql conditional="">
                    CREATE TABLE EmailMarketingFolders
                    (
                        FolderId IDENTITY PRIMARY KEY NOT NULL,
                        FolderParentId  INT NULL,
                        FolderName VARCHAR(255) NULL
                    )
                </sql>
            </EmailMarketingFolders>
            <CampaignManagerNewsletter>
                <sql conditional="">
                    ALTER TABLE CampaignManagerNewsletter ADD NewsletterEmailMarketingFolderId INT NULL
               </sql>
                <sql conditional="">
                    ALTER TABLE CampaignManagerNewsletter ADD NewsletterCreateDate DATETIME NULL
               </sql>
            </CampaignManagerNewsletter>
            <EmailMarketingFolders>
                <sql conditional="SELECT COUNT(*) FROM [EmailMarketingFolders] WHERE [FolderName] = 'Drafts' AND [FolderParentId] = 0">
                    INSERT INTO EmailMarketingFolders ([FolderParentId], [FolderName])
                    VALUES (0, 'Drafts')
                </sql>
                <sql conditional="SELECT COUNT(*) FROM [EmailMarketingFolders] WHERE [FolderName] = 'Scheduled' AND [FolderParentId] = 0">
                    INSERT INTO EmailMarketingFolders ([FolderParentId], [FolderName])
                    VALUES (0, 'Scheduled')
                </sql>
                <sql conditional="SELECT COUNT(*) FROM [EmailMarketingFolders] WHERE [FolderName] = 'Split Tests' AND [FolderParentId] = 0">
                    INSERT INTO EmailMarketingFolders ([FolderParentId], [FolderName])
                    VALUES (0, 'Split Tests')
                </sql>
                <sql conditional="SELECT COUNT(*) FROM [EmailMarketingFolders] WHERE [FolderName] = 'Sent' AND [FolderParentId] = 0">
                    INSERT INTO EmailMarketingFolders ([FolderParentId], [FolderName])
                    VALUES (0, 'Sent')
                </sql>
            </EmailMarketingFolders>
        </database>-->
    </package>

    <package version="728" releasedate="14-02-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
		    <Module>
			    <sql conditional="">
                    ALTER TABLE Comment ADD CommentActive bit NULL
			    </sql>
		    </Module>
	    </database>
    </package>

    <package version="727" releasedate="02-12-2013" internalversion="8.3.0.0">
        <file name="LiveIntegrationAddInNotificationTemplate.html" source="/Files/Templates/DataIntegration/Notifications" target="/Files/Templates/DataIntegration/Notifications" overwrite="false" />
    </package>

    <package version="726" releasedate="08-02-2013" internalversion="8.3.0.0">
        <database file="Access.mdb">
		    <AccessUser>
                <sql conditional="">
                    ALTER TABLE AccessUser ADD AccessUserCreatedOn DATETIME NULL,
                                               AccessUserUpdatedOn DATETIME NULL,
                                               AccessUserCreatedBy INT NULL,
                                               AccessUserUpdatedBy INT NULL,
                                               AccessUserEmailPermissionGivenOn DATETIME NULL
                </sql>
		    </AccessUser>
	    </database>
    </package>

	<package version="725" releasedate="07-02-2013" internalversion="8.3.0.0">
        <setting key="/Globalsettings/Modules/OMC/EmailEngagement/OpenMail" value="5" overwrite="false" />
        <setting key="/Globalsettings/Modules/OMC/EmailEngagement/ClickLink" value="10" overwrite="false" />
        <setting key="/Globalsettings/Modules/OMC/EmailEngagement/AddingProductsToCart" value="20" overwrite="false" />
        <setting key="/Globalsettings/Modules/OMC/EmailEngagement/SigningNewsletter" value="15" overwrite="false" />
        <setting key="/Globalsettings/Modules/OMC/EmailEngagement/UnsubscribesNewsletter" value="-20" overwrite="false" />
	</package>

    <package version="724" releasedate="27-01-2013" internalversion="8.3.0.0">
        <file name="Notify.html" source="/Files/Templates/Comments" target="/Files/Templates/Comments" overwrite="false" />
	</package>

    <package version="723" releasedate="27-01-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
		    <Module>
			    <sql conditional="">
                    ALTER TABLE Comment ADD CommentLikes INT NULL, CommentNolikes INT NULL, CommentParentID INT NULL
			    </sql>
		    </Module>
	    </database>
    </package>

    <package version="722" releasedate="05-02-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
		    <Constraints>
				<sql conditional="">
					ALTER TABLE [dbo].[AccessCompetence] CHECK CONSTRAINT [AccessCompetence_FK00];
					ALTER TABLE [dbo].[CalenderEvent] CHECK CONSTRAINT [CalenderEvent_FK00];
					ALTER TABLE [dbo].[DBPubAssociate] CHECK CONSTRAINT [DBPubAssociate_FK00];
					ALTER TABLE [dbo].[DBPubAssociate] CHECK CONSTRAINT [DBPubAssociate_FK01];
					ALTER TABLE [dbo].[DBPubField] CHECK CONSTRAINT [DBPubField_FK00];
					ALTER TABLE [dbo].[FormField] CHECK CONSTRAINT [FormField_FK00];
					ALTER TABLE [dbo].[FormOptions] CHECK CONSTRAINT [FormOptions_FK00];
					ALTER TABLE [dbo].[ForumMessage] CHECK CONSTRAINT [ForumMessage_FK00];
					ALTER TABLE [dbo].[Map] CHECK CONSTRAINT [Map_FK00];
					ALTER TABLE [dbo].[MediaDBField] CHECK CONSTRAINT [MediaDBField_FK00];
					ALTER TABLE [dbo].[MediaDBMedia] CHECK CONSTRAINT [MediaDBMedia_FK00];
					ALTER TABLE [dbo].[Metadata] CHECK CONSTRAINT [Metadata_FK00];
					ALTER TABLE [dbo].[MetadataCategory] CHECK CONSTRAINT [MetadataCategory_FK00];
					ALTER TABLE [dbo].[MetadataField] CHECK CONSTRAINT [MetadataField_FK00];
					ALTER TABLE [dbo].[MetadataOption] CHECK CONSTRAINT [MetadataOption_FK00];
					ALTER TABLE [dbo].[Page] CHECK CONSTRAINT [Page_FK00];
					ALTER TABLE [dbo].[Paragraph] CHECK CONSTRAINT [Paragraph_FK00];
					ALTER TABLE [dbo].[PollAnswer] CHECK CONSTRAINT [PollAnswer_FK00];
					ALTER TABLE [dbo].[PollItem] CHECK CONSTRAINT [PollItem_FK00];
					ALTER TABLE [dbo].[Relation] CHECK CONSTRAINT [Relation_FK00];
					ALTER TABLE [dbo].[StatsV2TriggerStep] CHECK CONSTRAINT [StatsV2TriggerStep_FK00];
					ALTER TABLE [dbo].[Statv2Page] CHECK CONSTRAINT [Statv2Page_FK00];
					ALTER TABLE [dbo].[Statv2Page] CHECK CONSTRAINT [Statv2Page_FK01];
					ALTER TABLE [dbo].[Statv2Report] CHECK CONSTRAINT [Statv2Report_FK00];
					ALTER TABLE [dbo].[Statv2s] CHECK CONSTRAINT [Statv2s_FK00];
					ALTER TABLE [dbo].[Statv2s] CHECK CONSTRAINT [Statv2s_FK01];
					ALTER TABLE [dbo].[StylesheetClass] CHECK CONSTRAINT [StylesheetClass_FK00];
					ALTER TABLE [dbo].[StylesheetNodeclass] CHECK CONSTRAINT [StylesheetNodeclass_FK00];
					ALTER TABLE [dbo].[StylesheetNodeclass] CHECK CONSTRAINT [StylesheetNodeclass_FK01];
					ALTER TABLE [dbo].[SurveyQuestion] CHECK CONSTRAINT [SurveyQuestion_FK00];
					ALTER TABLE [dbo].[SurveyQuestion] CHECK CONSTRAINT [SurveyQuestion_FK01];
					ALTER TABLE [dbo].[SurveyAnswerOption] CHECK CONSTRAINT [SurveyAnswerOption_FK00];
					ALTER TABLE [dbo].[SurveyResult] CHECK CONSTRAINT [SurveyResult_FK00];
					ALTER TABLE [dbo].[SurveyResult] CHECK CONSTRAINT [SurveyResult_FK01];
					ALTER TABLE [dbo].[SurveyResult] CHECK CONSTRAINT [SurveyResult_FK02];
					ALTER TABLE [dbo].[SurveyResult] CHECK CONSTRAINT [SurveyResult_FK03];
					ALTER TABLE [dbo].[Template] CHECK CONSTRAINT [Template_FK00];
					ALTER TABLE [dbo].[TemplateMenu] CHECK CONSTRAINT [TemplateMenu_FK00];
					ALTER TABLE [dbo].[TemplateMenu] CHECK CONSTRAINT [TemplateMenu_FK01];
				</sql>
		    </Constraints>
		    <Triggers>
                <sql conditional=""> DROP TRIGGER  dbo.[T_AccessCompetence_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_AccessCompetence_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_AccessCompetenceCategory_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_AccessCompetenceCategory_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Area_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Area_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_CalenderCategory_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_CalenderCategory_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_CalenderEvent_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_CalenderEvent_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_DBPubAssociate_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_DBPubAssociate_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_DBPubField_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_DBPubField_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_DBPubField_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_DBPubView_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_DBPubView_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Form_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Form_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_FormField_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_FormField_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_FormField_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_FormOptions_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_FormOptions_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ForumCategory_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ForumCategory_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ForumMessage_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ForumMessage_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Job_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Job_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Map_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Map_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MediaDBField_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MediaDBField_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MediaDBFieldType_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MediaDBFieldType_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MediaDBGroup_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MediaDBGroup_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MediaDBMedia_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MediaDBMedia_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Metadata_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Metadata_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MetadataCategory_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MetadataCategory_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MetadataCategory_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MetadataField_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MetadataField_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MetadataField_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MetadataOption_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MetadataOption_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MetadataType_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_MetadataType_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Page_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Page_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Page_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Paragraph_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Paragraph_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_PollAnswer_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_PollAnswer_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_PollCategory_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_PollCategory_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_PollItem_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_PollItem_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_PollItem_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Relation_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Relation_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ScheduledTaskType_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_ScheduledTaskType_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_StatsV2Trigger_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_StatsV2Trigger_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_StatsV2TriggerStep_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_StatsV2TriggerStep_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Statv2Object_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Statv2Object_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Statv2Page_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Statv2Page_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Statv2Report_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Statv2Report_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Statv2Report_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Statv2s_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Statv2s_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Statv2Summary_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Statv2Summary_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Statv2Type_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Statv2Type_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_StylesheetClass_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_StylesheetClass_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_StylesheetClass_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_StylesheetClasstype_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_StylesheetClasstype_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_StylesheetNodeclass_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_StylesheetNodeclass_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_StylesheetStylesheet_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_StylesheetStylesheet_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Survey_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Survey_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_SurveyAnswerOption_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_SurveyAnswerOption_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_SurveyAnswerOption_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_SurveyParticipant_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_SurveyParticipant_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_SurveyQuestion_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_SurveyQuestion_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_SurveyQuestion_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_SurveyQuestionType_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_SurveyQuestionType_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_SurveyResultStatus_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_SurveyResultStatus_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_TargetTable_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_TargetTable_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_TargetTable_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Template_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Template_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_Template_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_TemplateCategory_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_TemplateCategory_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_TemplateMenu_ITrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_TemplateMenu_UTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_TemplateMenuType_DTrig] </sql>
                <sql conditional=""> DROP TRIGGER  dbo.[T_TemplateMenuType_UTrig] </sql>
		    </Triggers>
	    </database>
    </package>

    <package version="721" releasedate="30-01-2013" internalversion="8.3.0.0">
        <file name="CookieWarning_SEOSafe.html" source="/Files/Templates/CookieWarning" target="/Files/Templates/CookieWarning" overwrite="false" />
    </package>
    <package version="720" releasedate="25-01-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
		    <Module>
			    <sql conditional="">
                    alter table SocialPost add PostName varchar(255) NULL
			    </sql>
		    </Module>
	    </database>
    </package>
    <package version="719" releasedate="24-01-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
		    <Module>
			    <sql conditional="">
                    alter table SocialPost add
                        PostResultException nvarchar(max) NULL,
                        PostPublished datetime NULL
			    </sql>
		    </Module>
	    </database>
    </package>

    <package version="718" releasedate="24-01-2013" internalversion="8.3.0.0">
    </package>

    <package version="717" releasedate="24-01-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
		    <Module>
			    <sql conditional="">
                    alter table SocialPost add
                        PostResultSuccess bit NULL,
                        PostResultStatusText nvarchar(max) NULL,
                        PostResultChannelPostLink nvarchar(max) NULL,
                        PostResultChannelPostIdentifier nvarchar(max) NULL
			    </sql>
		    </Module>
	    </database>
    </package>

    <package version="716" releasedate="23-01-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
		    <Module>
			    <sql conditional="">
                    UPDATE [Module] SET ModuleScript = '../Area/List.aspx' WHERE ModuleSystemName = 'Area'
			    </sql>
		    </Module>
	    </database>
    </package>

    <package version="715" releasedate="21-01-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
		    <Module>
			    <sql conditional="">
                    alter table SocialMessage add MessagePublished DATETIME NULL
			    </sql>
		    </Module>
	    </database>
    </package>

	<package version="714" date="22-01-2013" internalversion="8.3.0.0">
		<database file="Dynamic.mdb">
			<Module>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'OMC' AND [ModuleAccess] = 0">
                    UPDATE [Module] SET ModuleAccess = 1 WHERE ModuleSystemName = 'Leads'
				</sql>
			</Module>
		</database>
	</package>

    <package version="713" releasedate="21-01-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
		    <Module>
                <sql conditional="">
                    alter table SocialChannel add ChannelType nvarchar(max)
                </sql>
                <sql conditional="">
                    alter table SocialChannel add ChannelActive bit NOT NULL DEFAULT 1
			    </sql>
		    </Module>
        </database>
    </package>
    <package version="712" releasedate="21-01-2013" internalversion="8.3.0.0">
        <database file="Access.mdb">
		    <Module>
                <sql conditional="">
                    alter table editorConfiguration add EditorConfigurationType nvarchar(50)
                </sql>
                <sql conditional="">
                    alter table editorConfiguration add EditorConfigurationAddInProviderName nvarchar(max)
                </sql>
		    </Module>
        </database>
    </package>
    <package version="711" releasedate="21-01-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <SocialChannel>
                <sql conditional="">
                    CREATE TABLE SocialChannel
                    (
                        ChannelID IDENTITY PRIMARY KEY NOT NULL,
                        ChannelName NVARCHAR(255) NULL,
                        ChannelType NVARCHAR(MAX) NULL,
                        ChannelParameters NVARCHAR(MAX) NULL,
                        ChannelCreated DATETIME NULL,
                        ChannelUpdated DATETIME NULL,
                        ChannelActive BIT NOT NULL DEFAULT 1
                    )
                </sql>
            </SocialChannel>
            <SocialMessage>
                <sql conditional="">
                    CREATE TABLE SocialMessage
                    (
                        MessageID IDENTITY PRIMARY KEY NOT NULL,
                        MessageName NVARCHAR(255) NULL,
                        MessageText NVARCHAR(MAX) NULL,
                        MessageImage NVARCHAR(255) NULL,
                        MessageLink NVARCHAR(255) NULL,
                        MessageLinkID INT NULL,
                        MessageCreated DATETIME NULL,
                        MessageUpdated DATETIME NULL,
                        MessagePublished DATETIME NULL
                    )
                </sql>
            </SocialMessage>
            <SocialPost>
                <sql conditional="">
                    CREATE TABLE SocialPost
                    (
                        PostID IDENTITY PRIMARY KEY NOT NULL,
                        PostMessageID INT NULL,
                        PostChannelID INT NULL,
                        PostName NVARCHAR(255) NULL,
                        PostText NVARCHAR(MAX) NULL,
                        PostImage NVARCHAR(255) NULL,
                        PostLink NVARCHAR(255) NULL,
                        PostCreated DATETIME NULL,
                        PostUpdated DATETIME NULL,
                        PostPublished DATETIME NULL,
                        PostResultSuccess bit NULL,
                        PostResultStatusText nvarchar(max) NULL,
                        PostResultChannelPostLink nvarchar(max) NULL,
                        PostResultChannelPostIdentifier nvarchar(max) NULL,
                        PostResultException nvarchar(max) NULL
                    )
                </sql>
            </SocialPost>
        </database>
    </package>

    <package version="710" releasedate="10-01-2013" internalversion="8.3.0.0">
        <database file="Statisticsv2.mdb">
            <OMCLeadAuthorToken>
                <sql conditional="">
                    DROP TABLE OMCLeadAuthorToken
                    CREATE TABLE OMCLeadAuthorToken
                    (
                        LeadAuthorTokenId IDENTITY PRIMARY KEY NOT NULL,
                        LeadAuthorTokenVisitorId VARCHAR(255) NULL,
                        LeadAuthorTokenToken VARCHAR(255) NULL,
                        LeadAuthorTokenSentDate DATETIME NULL
                    )
                </sql>
            </OMCLeadAuthorToken>
        </database>
    </package>

    <package version="709" releasedate="15-01-2013" internalversion="8.3.0.0">
        <database file="Statisticsv2.mdb">
            <OMCLeadAuthorToken>
                <sql conditional="select 1 from sys.triggers where name = 'T_Page_DTrig'">
                     CREATE TRIGGER [T_Page_DTrig] ON [Page] FOR DELETE AS
                        SET NOCOUNT ON
                        /* * CASCADE DELETES TO 'Paragraph' */
                        DELETE Paragraph FROM deleted, Paragraph WHERE deleted.PageID = Paragraph.ParagraphPageID
                </sql>
                <sql conditional="">
                    DELETE FROM Paragraph WHERE ParagraphPageId NOT IN (SELECT PageID FROM Page)
                </sql>
            </OMCLeadAuthorToken>
        </database>
    </package>

    <package version="708" releasedate="14-01-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
		    <Module>
			    <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = '50Pages'">
				INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleParagraph], [ModuleIsBeta])
				VALUES ('50Pages', '50 Pages', blnFalse, blnFalse, blnFalse)
			    </sql>
		    </Module>
	    </database>
    </package>

    <package version="707" releasedate="10-01-2013" internalversion="8.3.0.0">
        <database file="Statisticsv2.mdb">
            <OMCLeadAuthorToken>
	            <sql conditional="">
                    CREATE TABLE OMCLeadAuthorToken
                    (
                        LeadAuthorTokenId IDENTITY PRIMARY KEY NOT NULL,
                        LeadAuthorTokenVisitorId VARCHAR(255) NULL,
                        LeadAuthorTokenToken VARCHAR(255) NULL,
                        LeadAuthorTokenSentDate DATETIME NULL
                    )
                </sql>
            </OMCLeadAuthorToken>
        </database>
    </package>

    <package version="706" releasedate="04-01-2013" internalversion="8.3.0.0">
        <file name="EmailLeadsPotentialLeads.html" source="/Files/Templates/OMC/Notifications" target="/Files/Templates/OMC/Notifications" overwrite="false" />
    </package>

    <package version="705" releasedate="27-12-2012" internalversion="8.3.0.0">
        <database file="Statisticsv2.mdb">
            <OMCLeadEmail>
                <sql conditional="">
                    ALTER TABLE [OMCLeadEmail] ADD
                    [LeadEmailAdditionalMessage] MAXCHAR NULL,
                    [LeadEmailSendParameter] INT NULL,
                    [LeadEmailLeadsLimit] INT NULL,
                    [LeadEmailTemplate] VARCHAR(255) NULL,
                    [LeadEmailWebsite] VARCHAR(255) NULL,
                    [LeadEmailIsActionAllowed] BIT NULL,
                    [LeadEmailScheduledDate] DATETIME NULL
                </sql>
            </OMCLeadEmail>
        </database>
    </package>

    <package version="704" date="19-12-2012" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
	        <Paragraph>
	            <sql conditional="">
                    ALTER TABLE [Area] ADD
                    [AreaCookieWarningTemplate] NVARCHAR(255) NULL,
                    [AreaCookieCustomNotifications] BIT NOT NULL DEFAULT 0
                </sql>
	        </Paragraph>
        </database>
    </package>

    <package version="703" releasedate="19-12-2012" internalversion="8.3.0.0">
        <file name="EmailLeadsStatistic.html" source="/Files/Templates/OMC/Notifications" target="/Files/Templates/OMC/Notifications" overwrite="false" />
    </package>

    <package version="702" releasedate="19-12-2012" internalversion="8.3.0.0">
        <file name="ModalDialogWarning.html" source="/Files/Templates/CookieWarning" target="/Files/Templates/CookieWarning" overwrite="false" />
        <file name="TopPageWarning.html" source="/Files/Templates/CookieWarning" target="/Files/Templates/CookieWarning" overwrite="false" />
    </package>

    <package version="701" date="19-12-2012" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
	        <Paragraph>
                <sql conditional="">
                    ALTER TABLE [Paragraph] ADD
                    [ParagraphItemType] NVARCHAR(255) NULL,
                    [ParagraphItemId] NVARCHAR(255) NULL
                </sql>
	        </Paragraph>
        </database>
    </package>

    <package veresion="700" releasedate="18-12-2012" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <UpsizingFix>
                <sql conditional="SELECT data_type FROM	information_schema.columns WHERE table_name = 'Page' AND column_name = 'PageNavigationGroupSelector' AND data_type = 'nvarchar'">
                    ALTER TABLE [Page] ALTER COLUMN [PageNavigationGroupSelector] NVARCHAR(MAX)
                </sql>
                <sql conditional="SELECT data_type FROM	information_schema.columns WHERE table_name = 'Page' AND column_name = 'PageNavigationProductPage' AND data_type = 'nvarchar'">
                    ALTER TABLE [Page] ALTER COLUMN [PageNavigationProductPage] NVARCHAR(MAX)
                </sql>
                <sql conditional="SELECT data_type FROM	information_schema.columns WHERE table_name = 'Page' AND column_name = 'PageNavigationShopSelector' AND data_type = 'nvarchar'">
                    ALTER TABLE [Page] ALTER COLUMN [PageNavigationShopSelector] NVARCHAR(MAX)
                </sql>
                <sql conditional="SELECT data_type FROM	information_schema.columns WHERE table_name = 'Page' AND column_name = 'PageUserManagementPermissions' AND data_type = 'nvarchar'">
                    ALTER TABLE [Page] ALTER COLUMN [PageUserManagementPermissions] NVARCHAR(MAX)
                </sql>
            </UpsizingFix>
        </database>
    </package>

    <package version="699" releasedate="14-12-2012" internalversion="8.3.0.0">
        <database file="Statisticsv2.mdb">
            <OMCLeadEmail>
                <sql conditional="">
                    CREATE TABLE OMCLeadEmail
                    (
                        LeadEmailId IDENTITY PRIMARY KEY NOT NULL,
                        LeadEmailVisitorId VARCHAR(255) NULL,
                        LeadEmailSenderName VARCHAR(255) NULL,
                        LeadEmailSenderEmail  VARCHAR(255) NULL,
                        LeadEmailSubject VARCHAR(255) NULL,
                        LeadEmailRecipientEmails MAXCHAR NULL,
                        LeadEmailSentDate DATETIME NULL
                    )
                </sql>
            </OMCLeadEmail>
        </database>
    </package>

   <package version="698" releasedate="14-12-2012" internalversion="8.2.0.1">
        <file name="ErpDataImport.xml" source="/Files/System/Integration/Jobs" target="/Files/System/Integration/Jobs" overwrite="false" />
        <file name="ErpUserExport.xml" source="/Files/System/Integration/Jobs" target="/Files/System/Integration/Jobs" overwrite="false" />
        <file name="ErpOrderExport.xml" source="/Files/System/Integration/Jobs" target="/Files/System/Integration/Jobs" overwrite="false" />
        <file name="ErpUserImport.xml" source="/Files/System/Integration/Jobs" target="/Files/System/Integration/Jobs" overwrite="false" />
    </package>

   <package version="697" releasedate="14-12-2012" internalversion="8.2.0.1">
        <file name="AddInNotificationTemplate.html" source="/Files/Templates/DataIntegration/Notifications" target="/Files/Templates/DataIntegration/Notifications" overwrite="false" />
    </package>
     <package version="696" releasedate="14-12-2012" internalversion="8.2.0.0">
        <file name="ActivityNotificationTemplate.html" source="/Files/Templates/DataIntegration/Notifications" target="/Files/Templates/DataIntegration/Notifications" overwrite="false" />
    </package>

    <package version="695" releasedate="05-11-2012" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
	        <Area>
	            <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Leads'">
                    INSERT INTO [Module](
                        [ModuleSystemName]
                        ,[ModuleName]
                        ,[ModuleAccess]
                        )
                    VALUES ('Leads','Leads',0)
                </sql>
	        </Area>
        </database>
    </package>


    <package version="694" releasedate="5-12-2012" internalversion="8.3.0.0">
        <file name="ActivityNotificationTamplate.html" source="/Files/Templates/DataIntegration/Notifications" target="/Files/Templates/DataIntegration/Notifications" overwrite="false" />
    </package>

    <package version="693" releasedate="05-11-2012" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
	        <Area>
	            <sql conditional="">
                    ALTER TABLE [Area] ADD
                    [AreaItemType] NVARCHAR(255) NULL,
                    [AreaItemId] NVARCHAR(255) NULL
                </sql>
	        </Area>
        </database>
    </package>

    <package version="692" date="27-11-2012" internalversion="8.2.0.0">
        <database file="Dynamic.mdb">
            <Area>
                <sql conditional="">ALTER TABLE [Area] ADD [AreaUrlIgnoreForChildren] Bit NULL</sql>
            </Area>
        </database>
    </package>
    <package version="691" releasedate="26-11-2012" internalversion="8.2.0.0">

        <database file="Dynamic.mdb">
	        <Ecom>
	            <sql conditional="SELECT name FROM sysindexes WHERE name = 'Id_Referer_Timestamp_Index_on_Statv2NotFound'">
                    CREATE NONCLUSTERED INDEX [Id_Referer_Timestamp_Index_on_Statv2NotFound] ON [dbo].[Statv2NotFound]
                    (
                        [Statv2NotFoundPath] ASC
                    )
                    INCLUDE ( [Statv2NotFoundID],
                    [Statv2NotFoundReferer],
                    [Statv2NotFoundTimestamp])WITH (SORT_IN_TEMPDB= OFF,IGNORE_DUP_KEY = OFF, DROP_EXISTING= OFF,ONLINE = OFF) ON [PRIMARY]

                    </sql>
                    <sql conditional="SELECT name FROM sysindexes WHERE name = 'id_name_images_index_on_EcomVariantsOptions'">

                    CREATE NONCLUSTERED INDEX [id_name_images_index_on_EcomVariantsOptions] ON [dbo].[EcomVariantsOptions]
                    (
                       [VariantOptionGroupID] ASC,
                       [VariantOptionLanguageID] ASC,
                       [VariantOptionSortOrder] ASC
                    )
                    INCLUDE ( [VariantOptionID],
                              [VariantOptionName],
                              [VariantOptionImgSmall],
                              [VariantOptionImgMedium],
                              [VariantOptionImgLarge])
                    WITH (SORT_IN_TEMPDB= OFF,IGNORE_DUP_KEY = OFF, DROP_EXISTING= OFF,ONLINE = OFF) ON [PRIMARY]
                    </sql>
                    <sql conditional="SELECT name FROM sysindexes WHERE name = 'EverythingIndex_on_EcomProducts'">


                    CREATE NONCLUSTERED INDEX [EverythingIndex_on_EcomProducts] ON [dbo].[EcomProducts]
                    (
                        [ProductLanguageID] ASC,
                        [ProductID] ASC,
                        [ProductVariantID] ASC
                    )
                    INCLUDE ( [ProductDefaultShopID],[ProductNumber],[ProductName],[ProductShortDescription],[ProductLongDescription],[ProductImageSmall],[ProductImageMedium],[ProductImageLarge],[ProductLink1],[ProductLink2],[ProductPrice],[ProductStock],[ProductStockGroupID],[ProductWeight],[ProductVolume],[ProductVatGrpID],[ProductManufacturerID],[ProductActive],[ProductPeriodID],[ProductCreated],[ProductUpdated],[ProductCustomFieldsXml],[ProductType],[ProductPriceType],[ProductPriceCounter],[ProductVariantCounter],[ProductVariantProdCounter],[ProductVariantGroupCounter],[ProductRelatedCounter],[ProductUnitCounter],[ProductDefaultUnitID],[ProductDefaultVariantComboID],[ProductPriceMatrixUnit],[ProductPriceMatrixVariant],[ProductPriceMatrixPeriod],[ProductPriceMatrixMultiplePrices],[ProductPriceMatrixQuantitySpecification],[producent],[ProductMetaTitle],[ProductMetaKeywords],[ProductMetaDescription],[ProductMetaUrl],[ProductOptimizedFor],[ProductCommentcount],[ProductRating])
                    WITH (SORT_IN_TEMPDB= OFF,IGNORE_DUP_KEY = OFF, DROP_EXISTING= OFF,ONLINE = OFF) ON [PRIMARY]

                   </sql>
                    <sql conditional="SELECT name FROM sysindexes WHERE name = 'OrderId_ProductVariantId_Index_on_EcomOrderLines'">

                    CREATENONCLUSTERED INDEX [OrderId_ProductVariantId_Index_on_EcomOrderLines] ON [dbo].[EcomOrderLines]
                    (
                        [OrderLineProductID] ASC
                    )
                    INCLUDE ( [OrderLineOrderID],[OrderLineProductVariantID])
                    WITH (SORT_IN_TEMPDB= OFF,IGNORE_DUP_KEY = OFF, DROP_EXISTING= OFF,ONLINE = OFF) ON [PRIMARY]


	            </sql>
	        </Ecom>
        </database>
    </package>
    <package version="690" releasedate="26-11-2012" internalversion="8.2.0.0">
        <database file="Dynamic.mdb">
	        <Page>
	            <sql conditional="">UPDATE [Page] SET [PageHidden] = 0 WHERE [PageHidden] IS NULL</sql>
	        </Page>
        </database>
    </package>

    <package version="689" releasedate="15-11-2012" internalversion="8.2.0.0">
        <file name="AddInNotificationTamplate.html" source="/Files/Templates/DataIntegration/Notifications" target="/Files/Templates/DataIntegration/Notifications" overwrite="false" />
    </package>

      <package version="688" releasedate="20-11-2012" internalversion="8.2.0.0">
        <database file="Dynamic.mdb">
			<Module>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'EmailMarketing'">
					INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleParagraph], [ModuleIsBeta])
					VALUES ('EmailMarketing', 'Email Marketing', blnFalse, blnFalse, blnTrue)
				</sql>
			</Module>
		</database>
      </package>

	  <package version="687" date="15-11-2012" internalversion="8.2.0.0">
        <database file="Dynamic.mdb">
            <Area>
                <sql conditional="">
                    CREATENONCLUSTERED INDEX [Hostnordic_SBJ_Index_1] ON [dbo].[Statv2NotFound]
                    (
                        [Statv2NotFoundPath] ASC
                    )
                    INCLUDE ( [Statv2NotFoundID],
                    [Statv2NotFoundReferer],
                    [Statv2NotFoundTimestamp])WITH (SORT_IN_TEMPDB= OFF,IGNORE_DUP_KEY = OFF, DROP_EXISTING= OFF,ONLINE = OFF) ON [PRIMARY]
                </sql>
            </Area>
        </database>
    </package>
    <package version="686" releasedate="05-11-2012" internalversion="8.2.0.0">
        <database file="Dynamic.mdb">
	        <Page>
	            <sql conditional="">
                    ALTER TABLE [TrashBin] ADD
                    [TrashBinItemType] NVARCHAR(255) NULL,
                    [TrashBinItemId] NVARCHAR(255) NULL
                </sql>
	        </Page>
        </database>
    </package>

    <package version="685" releasedate="05-11-2012" internalversion="8.2.0.0">
        <database file="Dynamic.mdb">
	        <Page>
	            <sql conditional="">ALTER TABLE [Page] ADD [PageItemId] NVARCHAR(255) NULL</sql>
	        </Page>
        </database>
    </package>

    <package version="684" releasedate="05-11-2012" internalversion="8.2.0.0">
        <database file="Dynamic.mdb">
            <ItemTypeId>
                <sql conditional="">
                    CREATE TABLE [ItemTypeId]
                    (
                        [ItemType] NVARCHAR(255) NULL,
                        [Current] INT NOT NULL,
                        [Seed] INT NULL
                    )
                </sql>
            </ItemTypeId>
        </database>

    </package>

    <package version="683" releasedate="04-11-2012" internalversion="8.2.0.0">
        <setting key="/Globalsettings/System/Filesystem/FilesFolderName" value="Filer" overwrite="false" />
    </package>
		
	<!--<package version="683" releasedate="05-11-2012" internalversion="8.2.0.0">
        <database file="Dynamic.mdb">
			<CampaignManagerNewsletter>
				<sql conditional="">
					CREATE TABLE [CampaignManagerNewsletter] (
						[NewsletterId] IDENTITY NOT NULL,
						[NewsletterName] NVARCHAR(255) NULL,
						[NewsletterDescription] NVARCHAR(MAX) NULL,
						[NewsletterPageId] INT NULL,
						[NewsletterRecipientProviderConfiguration] NVARCHAR(MAX) NULL,
						[NewsletterTemplate] NVARCHAR(255) NULL,
						[NewsletterSenderName] NVARCHAR(255) NOT NULL,
						[NewsletterSenderEmail] NVARCHAR(255) NOT NULL,
						[NewsletterSubject] NVARCHAR(255) NOT NULL,
						[NewsletterFileAttachmentPath] NVARCHAR(255) NULL,
						[NewsletterEncoding] NVARCHAR(50) NOT NULL,
						[NewsletterTrackingProviderConfiguration] NVARCHAR(MAX) NULL,
						[NewsletterSubscribePageId] INT NULL,
						[NewsletterSubscribePageText] NVARCHAR(255) NULL,
						[NewsletterUnsubscribePageId] INT NULL,
						[NewsletterUnsubscribePageText] NVARCHAR(255) NULL,
						[NewsletterMessageId] NVARCHAR(255) NULL,
						[NewsletterDomainName] NVARCHAR(255) NULL,
						[NewsletterVariationName] NVARCHAR(255) NULL,
						[NewsletterVariationEmail] NVARCHAR(255) NULL,
						[NewsletterVariationSubject] NVARCHAR(255) NULL,
						[NewsletterVariationPageId] INT NULL,
						[NewsletterVariationUnsubscribePageText] NVARCHAR(255) NULL,
						[NewsletterVariationMessageId] NVARCHAR(255) NULL,
						[NewsletterSplitTestIsSent] BIT NOT NULL,
						CONSTRAINT CMNewsletters_PrimaryKey PRIMARY KEY([NewsletterId]),
						CONSTRAINT CMNewsletters_PageIdForeignKey FOREIGN KEY([NewsletterPageId])
							REFERENCES Page([PageID]),
						CONSTRAINT CMNewsletters_VariationPageIdForeignKey FOREIGN KEY([NewsletterVariationPageId])
							REFERENCES Page([PageID]),
						CONSTRAINT CMNewsletters_SubscriptionPageIdForeignKey FOREIGN KEY([NewsletterSubscribePageId])
							REFERENCES Page([PageID]),
						CONSTRAINT CMNewsletters_UnsubscriptionPageIdForeignKey FOREIGN KEY([NewsletterUnsubscribePageId])
							REFERENCES Page([PageID])
					)
				</sql>
				<sql conditional="">
					CREATE TABLE [CampaignManagerNewsletterHistory] (
						[NewsletterHistoryId] IDENTITY NOT NULL,
						[NewsletterHistoryNewsletterId] INT NOT NULL,
						[NewsletterHistoryStartTime] DATETIME NULL,
						[NewsletterHistoryEndTime] DATETIME NULL,
						[NewsletterHistoryStatus] INT,
						[NewsletterHistoryErrorMessage] NVARCHAR(MAX) NULL,
						[NewsletterHistoryExceptionStackTrace] NVARCHAR(MAX) NULL,
						CONSTRAINT CMNewsletterHistory_PrimaryKey PRIMARY KEY([NewsletterHistoryId]),
						CONSTRAINT CMNewsletterHistory_PageIdForeignKey FOREIGN KEY([NewsletterHistoryId])
							REFERENCES CampaignManagerNewsletter([NewsletterId])
					)
				</sql>
				<sql conditional="">
					CREATE TABLE [CampaignManagerSplitTest] (
						[SplitTestID] IDENTITY NOT NULL,
						[SplitTestNewsletterID] INT NULL,
						[SplitTestName] NVARCHAR(255) NULL,
						[SplitTestIncludes] INT NULL,
						[SplitTestIncludesUnits] INT NOT NULL,
						[SplitTestGoalType] NVARCHAR(50) NOT NULL,
						[SplitTestActive] BIT NULL,
						[SplitTestStartDate] DATETIME NULL,
						[SplitTestEndDate] DATETIME NULL,
						[SplitTestEndType] INT NOT NULL,
						[SplitTestOpenedNewsletters] INT NULL,
						[SplitTestOpenedNewslettersUnits]  INT NOT NULL,
						[SplitTestHoursTillEnd] INT NULL,
						[SplitTestAfterEndSendBest]  BIT NULL,
						[SplitTestAfterEndNotify]  BIT NULL,
						[SplitTestAfterEndActionEmail] NVARCHAR(255) NULL,

						CONSTRAINT CMSplitTest_PrimaryKey PRIMARY KEY([SplitTestID]),
						CONSTRAINT CMplitTest_NewsletterIDForeignKey FOREIGN KEY([SplitTestNewsletterID])
							REFERENCES CampaignManagerNewsletter([NewsletterId])
					)
				</sql>
				<sql conditional="">
					CREATE TABLE [CampaignManagerEngagementIndex] (
						[EngagementIndexID] IDENTITY NOT NULL,
						[EngagementIndexNewsletterID] INT NULL,
						[EngagementIndexOpenMailIndex] INT NULL,
						[EngagementIndexOpenMailActive] BIT NULL,
						[EngagementIndexClickLinkIndex] INT NULL,
						[EngagementIndexClickLinkActive] BIT NULL,
						[EngagementIndexAddingProductsIndex] INT NULL,
						[EngagementIndexAddingProductsActive] BIT NULL,
						[EngagementIndexPlacingOrderIndex] INT NULL,
						[EngagementIndexPlacingOrderActive] BIT NULL,
						[EngagementIndexSigningNewsletterIndex] INT NULL,
						[EngagementIndexSigningNewsletterActive] BIT NULL,
						[EngagementIndexUnsubscribesNewsletterIndex] INT NULL,
						[EngagementIndexUnsubscribesNewsletterActive] BIT NULL,
						[EngagementIndexOriginalLinks] NVARCHAR(MAX) NULL,
						[EngagementIndexVariantLinks] NVARCHAR(MAX) NULL,

						CONSTRAINT CMEngagementIndex_PrimaryKey PRIMARY KEY(EngagementIndexID),
						CONSTRAINT CMEngagementIndex_NewsletterIDForeignKey FOREIGN KEY([EngagementIndexNewsletterID])
							REFERENCES CampaignManagerNewsletter([NewsletterId])
					)
				</sql>
			</CampaignManagerNewsletter>
		</database>
	</package>-->

	<package version="682" releasedate="31-10-2012" internalversion="8.2.0.0">
		<database file="Access.mdb">
			<AccessUser>
				<sql conditional="">
					ALTER TABLE [AccessUser] ADD [AccessUserNewsletterAllowed] BIT NOT NULL DEFAULT blnFalse
				</sql>
			</AccessUser>
		</database>
	</package>

    <package version="681" releasedate="31-10-2012" internalversion="8.2.0.0">
        <database file="Dynamic.mdb">
			<Module>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'ItemPublisher'">
					INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleParagraph])
					VALUES ('ItemPublisher', 'Item publisher', blnFalse, blnTrue)
				</sql>
			</Module>
		</database>

        <file name="Edit.html" source="/Files/Templates/ItemPublisher/Edit" target="/Files/Templates/ItemPublisher/Edit" />
        <file name="Details.html" source="/Files/Templates/ItemPublisher/Details" target="/Files/Templates/ItemPublisher/Details" />
        <file name="List.html" source="/Files/Templates/ItemPublisher/List" target="/Files/Templates/ItemPublisher/List" />
        <file name="List_Table.html" source="/Files/Templates/ItemPublisher/List" target="/Files/Templates/ItemPublisher/List" />
        <file name="ItemPublisher.css" source="/Files/Templates/ItemPublisher" target="/Files/Templates/ItemPublisher" />
    </package>

	<package version="680" releasedate="31-10-2012" internalversion="8.2.0.0">
		<database file="Statisticsv2.mdb">
			<OMCLinkClick>
				<sql conditional="">
					ALTER TABLE [OMCLinkClick] ADD [LinkClickSessionId] NVARCHAR(255) NULL
				</sql>
			</OMCLinkClick>
		</database>
	</package>

	<package version="679" releasedate="26-10-2012" internalversion="8.2.0.0">
		<database file="Dynamic.mdb">
			<ScheduledTaskType>
				<sql conditional="SELECT * FROM ScheduledTaskType WHERE TypeName='Add-in'">INSERT INTO [ScheduledTaskType](TypeName) VALUES('Add-in')</sql>
				<sql conditional="">ALTER TABLE [ScheduledTask] ADD [TaskAddInSettings] NText NULL</sql>
			</ScheduledTaskType>
		</database>
	</package>

	<package version="677" releasedate="17-10-2012" internalversion="8.2.0.0">
		<database file="Statisticsv2.mdb">
			<OMCLink>
				<sql conditional="">
					CREATE TABLE [OMCLink]
					(
						[LinkId] IDENTITY NOT NULL,
						[LinkUrl] NVARCHAR(MAX) NOT NULL,
						[LinkReferenceType] NVARCHAR(255) NOT NULL,
						[LinkReferenceKey] NVARCHAR(255) NOT NULL,
						CONSTRAINT OMCLink_PrimaryKey PRIMARY KEY([LinkId])
					)
				</sql>
				<sql conditional="">
					CREATE TABLE [OMCLinkClick]
					(
						[LinkClickId] IDENTITY NOT NULL,
						[LinkClickLinkId] INT NOT NULL,
						[LinkClickClickerKey] NVARCHAR(255) NOT NULL,
						[LinkClickClickTime] DATETIME NOT NULL,
						CONSTRAINT OMCLinkClick_PrimaryKey PRIMARY KEY([LinkClickId]),
						CONSTRAINT OMCLinkClick_LinksForeignKey FOREIGN KEY([LinkClickLinkId])
							REFERENCES [OMCLink]([LinkId])
					)
				</sql>
			</OMCLink>
		</database>
	</package>

    <package version="676" date="17-10-2012" internalversion="8.2.0.0">
        <database file="Dynamic.mdb">
	        <Page>
	            <sql conditional="">ALTER TABLE [Page] ADD [PageItemType] NVARCHAR(255) NULL</sql>
	        </Page>
        </database>
    </package>

    <package version="675"  date="17-10-2012" internalversion="8.2.0.0">
        <file name="Manage_addresses.html" source="/Files/Templates/UserManagement/Addresses" target="/Files/Templates/UserManagement/Addresses"/>
        <file name="View_addresses.html" source="/Files/Templates/UserManagement/Addresses" target="/Files/Templates/UserManagement/Addresses"/>
        <file name="view_profile_addresses.html" source="/Files/Templates/UserManagement/ViewProfile" target="/Files/Templates/UserManagement/ViewProfile"/>
    </package>

    <package version="674" date="17-10-2012" internalversion="8.2.0.0">
		<database file="Dynamic.mdb">
			<AccessUser>
				<sql conditional="">
                    alter table versionData add VersionDataTypeIdString nvarchar(255) default ''
				</sql>
			</AccessUser>
		</database>
	</package>

    <package version="673" date="17-10-2012" internalversion="8.2.0.0">
    <database file="Dynamic.mdb">
	    <Area>
	        <sql conditional="">ALTER TABLE [Area] ALTER COLUMN [AreaRobotsTxt] MEMO NULL</sql>
	    </Area>
    </database>
    </package>

	<package version="672" date="12-10-2012" internalversion="8.2.0.0">
		<database file="Dynamic.mdb">
			<EmailMessaging>
				<sql conditional="">
					CREATE TABLE [EmailMessage]
					(
						[MessageId] IDENTITY NOT NULL,
						[MessageSubject] NVARCHAR(255) NULL,
						[MessageSenderName] NVARCHAR(255) NULL,
						[MessageSenderEmail] NVARCHAR(255) NOT NULL,
						[MessageDomainUrl] NVARCHAR(255) NOT NULL,
						[MessageRecipientsSource] NVARCHAR(255) NOT NULL,
						[MessageHtmlBody] NVARCHAR(MAX) NULL,
						[MessagePreprocessedHtmlBody] NVARCHAR(MAX) NULL,
						[MessageFileAttachmentPaths] NVARCHAR(MAX) NULL,
						CONSTRAINT Message_PrimaryKey PRIMARY KEY([MessageId])
					)
				</sql>
				<sql conditional="">
					CREATE TABLE [EmailRecipient]
					(
						[RecipientId] IDENTITY NOT NULL,
						[RecipientKey] NVARCHAR(255) NOT NULL,
						[RecipientName] NVARCHAR(255) NULL,
						[RecipientEmailAddress] NVARCHAR(255) NULL,
						[RecipientMessageId] INT NOT NULL,
						[RecipientSentTime] DATETIME NULL,
						[RecipientErrorMessage] NVARCHAR(MAX) NULL,
						[RecipientErrorTime] DATETIME NULL,
						CONSTRAINT EmailRecipient_PrimaryKey PRIMARY KEY([RecipientId]),
						CONSTRAINT EmailRecipient_MessageForeignKey FOREIGN KEY([RecipientMessageId])
							REFERENCES [EmailMessage]([MessageId])
					)
				</sql>
				<sql conditional="">
					CREATE TABLE [EmailRecipientTag]
					(
						[RecipientTagId] IDENTITY NOT NULL,
						[RecipientTagRecipientId] INT NOT NULL,
						[RecipientTagName] NVARCHAR(255) NOT NULL,
						[RecipientTagValue] NVARCHAR(MAX) NULL,
						[RecipientTagDataType] NVARCHAR(255) NOT NULL,
						CONSTRAINT EmailRecipientTag_PrimaryKey PRIMARY KEY([RecipientTagId]),
						CONSTRAINT EmailRecipientTag_RecipientForeignKey FOREIGN KEY([RecipientTagRecipientId])
							REFERENCES [EmailRecipient]([RecipientId])
					)
				</sql>
			</EmailMessaging>
		</database>
	</package>

    <package version="671" date="12-10-2012" internalversion="8.2.0.0">
        <database file="Dynamic.mdb">
            <Page>
                <sql conditional="">ALTER TABLE [Page] ADD [PageUrlIgnoreForChildren] Bit NULL</sql>
                <sql conditional="">ALTER TABLE [Page] ADD [PageUrlUseAsWritten] Bit NULL</sql>
            </Page>
        </database>
    </package>
    <package version="670" date="11-10-2012" internalversion="8.2.0.0">
        <database file="Dynamic.mdb">
            <Area>
                <sql conditional="">
                    ALTER TABLE [Area] ADD [AreaEcomShopID] NVARCHAR(255) NULL
                </sql>
            </Area>
        </database>
    </package>

  <package version="669" date="01-10-2012" internalversion="8.2.0.0">
    <database file="Access.mdb">
      <FolderPermission>
        <sql conditional="">
          INSERT INTO [AccessElementPermission]([AccessElementPermissionTypeID], [AccessElementPermissionUserID], [AccessElementPermissionElementID], [AccessElementPermissionElementTextID], [AccessElementPermissionTypePermission])
          SELECT DISTINCT perm.[AccessElementPermissionTypeID], '0', perm.[AccessElementPermissionElementID], perm.[AccessElementPermissionElementTextID], 'Deny'
          FROM [AccessElementPermission] perm
          WHERE perm.[AccessElementPermissionTypePermission] IS NULL
            AND [AccessElementPermissionTypeID] = (SELECT [AccessElementTypeID] FROM [AccessElementType] WHERE [AccessElementType]='folder');
        </sql>
        <sql conditional="">
          UPDATE [AccessElementPermission]
          SET [AccessElementPermissionTypePermission] = 'Allow'
          WHERE [AccessElementPermissionTypePermission] IS NULL
            AND [AccessElementPermissionTypeID] = (SELECT [AccessElementTypeID] FROM [AccessElementType] WHERE [AccessElementType]='folder');
        </sql>
      </FolderPermission>
    </database>
  </package>

  <package version="668" date="28-09-2012" internalversion="8.2.0.0">
    <database file="Dynamic.mdb">
      <Sitemap>
        <sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'Sitemap_cpl.aspx' WHERE ModuleSystemName = 'SitemapV2'</sql>
      </Sitemap>
		</database>
	</package>

    <package version="667" date="24-09-2012" internalversion="8.1.1.6">
	<database file="Access.mdb">
	    <AccessUser>
            <sql conditional="">ALTER TABLE AccessUserAddress ALTER COLUMN AccessUserAddressCallName nvarchar(255) NULL</sql>
            <sql conditional="">ALTER TABLE AccessUserAddress ALTER COLUMN AccessUserAddressName nvarchar(255) NULL</sql>
            <sql conditional="">ALTER TABLE AccessUserAddress ALTER COLUMN AccessUserAddressState nvarchar(255) NULL</sql>
        </AccessUser>
	</database>
</package>

    <package version="666">
        <file name="view_profile_addresses.html" source="/Files/Templates/UserManagement/ViewProfile" target="/Files/Templates/UserManagement/ViewProfile" overwrite="false"/>
        <file name="list_addresses.html" source="/Files/Templates/UserManagement/Addresses" target="/Files/Templates/UserManagement/Addresses" overwrite="false"/>
        <file name="add_address.html" source="/Files/Templates/UserManagement/Addresses" target="/Files/Templates/UserManagement/Addresses" overwrite="false"/>
	</package>

    <package version="665" date="19-09-2012" internalversion="8.2.0.0">
		<database file="Access.mdb">
			<AccessUser>
				<sql conditional="">
                    alter table versionData add VersionDataTypeIdString nvarchar(255) default ''
				</sql>
			</AccessUser>
		</database>
	</package>
  <package version="664">
	</package>

  <package version="663">
	</package>
    <package version="662" date="04-09-2012" internalversion="8.2.0.0">
        <database file="Access.mdb">
          <AccessUser>
            <sql conditional="">ALTER TABLE AccessUserAddress ALTER COLUMN AccessUserAddressCallName nvarchar(100) NULL</sql>
            <sql conditional="">ALTER TABLE AccessUserAddress ALTER COLUMN AccessUserAddressCompany nvarchar(255) NULL</sql>
            <sql conditional="">ALTER TABLE AccessUserAddress ALTER COLUMN AccessUserAddressAddress nvarchar(255) NULL</sql>
            <sql conditional="">ALTER TABLE AccessUserAddress ALTER COLUMN AccessUserAddressAddress2 nvarchar(255) NULL</sql>
            <sql conditional="">ALTER TABLE AccessUserAddress ALTER COLUMN AccessUserAddressZip nvarchar(255) NULL</sql>
            <sql conditional="">ALTER TABLE AccessUserAddress ALTER COLUMN AccessUserAddressCity nvarchar(255) NULL</sql>
            <sql conditional="">ALTER TABLE AccessUserAddress ALTER COLUMN AccessUserAddressCountry nvarchar(255) NULL</sql>
            <sql conditional="">ALTER TABLE AccessUserAddress ALTER COLUMN AccessUserAddressPhone nvarchar(255) NULL</sql>
            <sql conditional="">ALTER TABLE AccessUserAddress ALTER COLUMN AccessUserAddressFax nvarchar(255) NULL</sql>
            <sql conditional="">ALTER TABLE AccessUserAddress ALTER COLUMN AccessUserAddressEmail nvarchar(255) NULL</sql>
          </AccessUser>
        </database>
    </package>

    <package version="661" date="11-09-2012" internalversion="8.2.0.0">
        <database file="Dynamic.mdb">
          <SystemField>
            <sql conditional="">
              CREATE TABLE SystemField
              (
              SystemFieldSystemName VARCHAR(50) NOT NULL,
              SystemFieldTableName VARCHAR(255) NOT NULL,
              SystemFieldType VARCHAR(50) NOT NULL,
              SystemFieldName VARCHAR(255) NOT NULL,
              SystemFieldOptions MAXCHAR NULL,
              SystemFieldIsFrontendEditable BIT NOT NULL,
              PRIMARY KEY (SystemFieldSystemName, SystemFieldTableName)
              )
            </sql>
            <sql conditional="">
              CREATE TABLE SystemFieldValue
              (
              SystemFieldValueSystemName VARCHAR(50) NOT NULL,
              SystemFieldValueTableName VARCHAR(255) NOT NULL,
              SystemFieldValueItemId INT NOT NULL,
              SystemFieldValueValue MAXCHAR NULL,
              PRIMARY KEY (SystemFieldValueSystemName, SystemFieldValueTableName, SystemFieldValueItemId)
              )
            </sql>
          </SystemField>
        </database>
    </package>

    <package version="660" date="04-09-2012" internalversion="8.2.0.0">
        <database file="Access.mdb">
          <AccessUser>
            <sql conditional="">ALTER TABLE [AccessUserAddress] ADD [AccessUserAddressState] NVARCHAR(100) NULL</sql>
            <sql conditional="">ALTER TABLE [AccessUserAddress] ADD [AccessUserAddressIsDefault] Bit NULL</sql>
          </AccessUser>
        </database>
    </package>

    <package version="659" date="21-08-2012" internalversion="8.2.0.0">
	</package>

	 <package version="658" date="27-08-2012" internalversion="8.2.0.0">
    <database file="Access.mdb">
      <AccessUser>
        <sql conditional="">ALTER TABLE [AccessUser] ADD [AccessUserAccountPermissions] NVARCHAR(MAX) NULL</sql>
      </AccessUser>
    </database>
  </package>

    <package version="657" date="21-08-2012" internalversion="8.2.0.0">
		<database file="Access.mdb">
			<AccessUser>
				<sql conditional="">
					ALTER TABLE [AccessUser] ADD [AccessUserIsAccount] Bit NULL
				</sql>
			</AccessUser>
		</database>
	</package>

    <package version="656">		
	</package>

    <package version="655">		
	</package>

	<package version="654" date="13-08-2012" internalversion="8.2.0.0">
		<database file="Access.mdb">
			<AccessUser>
				<sql conditional="">
					ALTER TABLE [AccessUser] ADD [AccessUserGeoLocationImage] NVARCHAR(255) NULL
				</sql>
			</AccessUser>
		</database>
	</package>

	<package version="653">
		<database file="Dynamic.mdb">
			<AccessUser>
				<sql conditional="">
					drop function dbo.getGroupIDsForProductAsCSV;
					drop function dbo.getGroupNamesForProductAsCSV;
					drop function dbo.getGroupSortOrderForProductAsCSV;
					drop function dbo.getParentGroupsForGroupAsCSV;
					drop function dbo.getShopsForGroupAsCSV;
					drop function dbo.getShopSortingForGroupAsCSV;
					drop function dbo.getVariantGroupIDsForProductAsCSV;
					drop function dbo.getVariantGroupNamesForProductAsCSV;
					drop function dbo.getVariantOptionIDsForProductAsCSV;
					drop function dbo.getRelatedProductNamesForProductAsCSV;
					drop function dbo.getRelatedProductIDsForProductAsCSV;
					drop function dbo.getGroupRelationsSortingForGroupAsCSV;
				</sql>
			</AccessUser>
		</database>

	</package>

	<package version="652">		
	</package>

	<package version="651">
		<database file="Dynamic.mdb">
			<AccessUser>
				<sql conditional="">
					ALTER TABLE [Page] ADD [PageChooseAccountTemplate] VARCHAR(255) NULL
				</sql>
			</AccessUser>
		</database>		
	</package>

	<package version="650" date="09-08-2012" internalversion="8.2.0.0">
		<database file="Dynamic.mdb">
			<Module>
				<sql conditional="SELECT count(*) FROM [Module] WHERE [ModuleSystemName] = 'Maps'">
					INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleParagraph], [ModuleParagraphEditPath], [ModuleControlPanel])
					VALUES ('Maps', 'Maps', blnFalse, blnTrue, '/Admin/Module/Maps/', 'Maps_cpl.aspx')
				</sql>
			</Module>
		</database>
		<database file="Access.mdb">
			<AccessUser>
				<sql conditional="">
		  ALTER TABLE [AccessUser] ADD
					[AccessUserGeoLocationLat] Float NULL,
					[AccessUserGeoLocationLng] Float NULL,
					[AccessUserGeoLocationIsCustom] Bit NULL,
					[AccessUserGeoLocationHash] VARCHAR(32) NULL
				</sql>
			</AccessUser>
		</database>

		<file name="Maps.html" source="/Files/Templates/Maps/templates" target="/Files/Templates/Maps/templates" overwrite="false"/>
		<file name="Maps.css" source="/Files/Templates/Maps/stylesheets" target="/Files/Templates/Maps/stylesheets" overwrite="false"/>
		<file name="Maps.js" source="/Files/Templates/Maps/javascripts" target="/Files/Templates/Maps/javascripts" overwrite="false"/>
		<file name="config.rb" source="/Files/Templates/Maps" target="/Files/Templates/Maps" overwrite="false"/>
		<file name="Maps.scss" source="/Files/Templates/Maps/sass" target="/Files/Templates/Maps/sass" overwrite="false"/>
	</package>

	<package version="649">
		<setting key="/Globalsettings/System/Searching/EntryIndexingDelay" value="0" overwrite="false" />
	</package>

	<package version="648" date="31-07-2012" internalversion="8.2.0.0">
		<database file="Access.mdb">
			<AccessUserAccountUserRelation>
				<sql conditional="">
				CREATE TABLE [AccessUserAccountUserRelation]
				(
					[AccessUserAccountUserRelationID] IDENTITY PRIMARY KEY NOT NULL,
					[AccessUserAccountUserRelationUserID] INT NOT NULL,
					[AccessUserAccountUserRelationAccountID] INT NOT NULL,
					[AccessUserAccountUserRelationType] VARCHAR(50) NULL
				)
				</sql>
			</AccessUserAccountUserRelation>
		</database>
	</package>

	<package version="647" date="30-07-2012" internalversion="8.2.0.0">
		<file name="Visits by profile.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
	</package>

	<package version="646" date="18-07-2012" internalversion="8.2.0.0">
	  <file name="ProductList.html" source="/Files/Templates/eCom/ProductList" target="/Files/Templates/eCom/ProductList" overwrite="false" />
	</package>

	<package version="645" date="13-07-2012" internalversion="8.2.0.0">
	  <file name="StockPresenceFilter.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
	</package>

	<package version="644" date="20-06-2012" internalversion="8.1.1.0">
		<setting key="/Globalsettings/Modules/OMC/Notifications/SplitTestsSendImprovementLimit" value="20" overwrite="false" />
	</package>

	<package version="643" date="19-06-2012" internalversion="8.1.1.0">
		<setting key="/Globalsettings/Modules/OMC/LeadsListKeepTemporarilyApproved" value="True" overwrite="false" />
	</package>

	<package version="642" date="15-06-2012" internalversion="8.1.1.0">
		<database file="Statisticsv2.mdb">
			<Statv2Session>
				<sql conditional="">ALTER TABLE [Statv2Session] ALTER COLUMN [Statv2SessionIsLead] INT NULL</sql>
			</Statv2Session>
		</database>
	</package>

	<package version="641" date="13-06-2012" internalversion="8.1.1.0">
	</package>

	<package version="640" date="12-06-2012" internalversion="8.1.1.0">
		<database file="Statisticsv2.mdb">
			<OMCExperiment>
				<sql conditional="">
					ALTER TABLE [OMCExperiment] ADD [OMCExperimentIsCustomProvider] Bit NULL
				</sql>
				<sql conditional="">
					ALTER TABLE [OMCExperiment] ALTER COLUMN [OMCExperimentGoalValue] NVARCHAR (3500) NULL
				</sql>
			</OMCExperiment>
		</database>
	</package>

   <package version="639" date="11-06-2012" internalversion="8.1.1.0">
   </package>

	<package version="638" date="08-06-2012" internalversion="8.1.1.0">
		<setting key="/Globalsettings/Modules/OMC/Notifications/SplitTestsSendInterval" value="7" />
		<setting key="/Globalsettings/Modules/OMC/Notifications/SplitTestsSendFrom" value="3" />
		<setting key="/Globalsettings/Modules/OMC/Notifications/SplitTestsSendTo" value="5" />
		<setting key="/Globalsettings/Modules/OMC/Notifications/SplitTestsSendCRThreshold" value="5" />

		<file name="EmailSplitTests.html" source="/Files/Templates/OMC/Notifications" target="/Files/Templates/OMC/Notifications" overwrite="false" />

		<database file="Statisticsv2.mdb">
			<OMCEmailProfile>
				<sql conditional="SELECT TOP 1 [OMCEmailProfileID] FROM [OMCEmailProfile] WHERE [OMCEmailProfileSenderEmail] = 'noreply@dynamicweb.dk' AND [OMCEmailProfileSubject] = 'Marketing - Split tests'">
					INSERT INTO [OMCEmailProfile] ([OMCEmailProfileSenderEmail], [OMCEmailProfileSubject], [OMCEmailProfileTemplate], [OMCEmailProfileEncoding])
						VALUES ('noreply@dynamicweb.dk', 'Marketing - Split tests', '/Files/Templates/OMC/Notifications/EmailSplitTests.html', 'UTF-8')
				</sql>
			</OMCEmailProfile>
		</database>
	</package>

   <package version="637" date="05-06-2012" internalversion="8.1.1.0">
   </package>

	<package version="636" date="01-06-2012" internalversion="8.1.1.0">
	</package>

	<package version="635" date="01-06-2012" internalversion="8.1.1.0">
		<database file="Statisticsv2.mdb">
			<Statv2Session>
				<sql conditional="">
					ALTER TABLE [Statv2Session] ADD
					[Statv2SessionFirstGroup] NVARCHAR(50) NULL,
					[Statv2SessionLastGroup] NVARCHAR(50) NULL,
					[Statv2SessionGroupPath] NVARCHAR(MAX) NULL,
					[Statv2SessionIsLandingGroup] BIT NULL,
					[Statv2SessionIsExitGroup] BIT NULL
				</sql>
			</Statv2Session>
		</database>
	</package>

   <package version="634" date="31-05-2012" internalversion="8.1.0.0">
   </package>


<package version="633" date="29-05-2012" internalversion="8.1.1.0">
	</package>

	 <package version="632" date="29-05-2012" internalversion="8.1.1.0">
  </package>

	<package version="630" date="21-05-2012" internalversion="8.1.1.0">
		<database file="Statisticsv2.mdb">
			<OMContentRestriction>
				<sql conditional="">
					ALTER TABLE [OMCContentRestriction]
					ADD [OMCContentRestrictionApplyMode] INT NULL,
					[OMCContentRestrictionProfileApplyMode] INT NULL
				</sql>
			</OMContentRestriction>

			<OMContentRestrictionPreset>
				<sql conditional="">
					ALTER TABLE [OMCContentRestrictionPreset]
					ADD [OMCContentRestrictionPresetApplyMode] INT NULL
				</sql>
			</OMContentRestrictionPreset>

			<OMCContentRestrictionPresetData>
				<sql conditional="">
					ALTER TABLE [OMCContentRestrictionPresetData]
					ADD [OMCContentRestrictionPresetDataApplyMode] INT NULL
				</sql>
			</OMCContentRestrictionPresetData>
		</database>
	</package>

	<package version="629" date="20-05-2012" internalversion="8.1.0.0">
		<database file="Dynamic.mdb">
			<Area>
				<sql conditional="">
					ALTER TABLE [Area] ADD [AreaEcomCountryCode] NVARCHAR(2) NULL
				</sql>
			</Area>
		</database>
	</package>

	<package version="628" date="18-05-2012" internalversion="8.1.0.0">
	</package>

	<package version="627" date="17-05-2012" internalversion="8.1.0.0">
	<database file="Ecom.mdb">
	  <EcomProductCategories>
		<sql conditional="if OBJECT_ID(N'dbo.getGroupRelationsSortingForGroupAsCSV', N'FN') is not null begin select 1 end">
		  create function [dbo].getGroupRelationsSortingForGroupAsCSV
		  (@groupid as nvarchar(255), @languageid as nvarchar(255))
		  returns NVARCHAR(1000)
		  AS
		  begin
		  declare @csv NVARCHAR(1000)
		  select @csv = (coalesce(@csv+'","','') + GroupRelationsParentID+'.'+convert(nvarchar(15), GroupRelationsSorting))
		  from ecomgroups join ecomgrouprelations on groupID=grouprelationsgroupID
		  where groupid=@groupid and GroupLanguageID=@languageID
		  return '"'+@csv+'"'
		  end
		</sql>
	  </EcomProductCategories>
	</database>
  </package>

   <package version="626" date="11-05-2012" internalversion="8.1.0.0">
   </package>

   <package version="625" date="10-05-2012" internalversion="8.1.0.0">
	 <database file="Dynamic.mdb">
	   <pagetemplates>
		 <sql conditional="">UPDATE Page SET PageActive=blnFalse, PageHidden=blnTrue WHERE PageIsTemplate=blnTrue</sql>
	   </pagetemplates>
	 </database>
  </package>

	<package version="624" date="07-05-2012" internalversion="8.1.0.0">
	</package>

	<package version="623" date="03-05-2012" internalversion="8.1.0.0">
		<database file="Dynamic.mdb">
			<Area>
				<sql conditional="">
					ALTER TABLE [Area] ADD [AreaLockPagesToDomain] BIT NULL
				</sql>
			</Area>
		</database>
	</package>

	<package version="622" date="26-04-2012" internalversion="8.1.0.0">
		<file name="Booking.js" source="/Files/Templates/Booking/js" target="/Files/Templates/Booking/js" overwrite="true" />
	</package>

	 <package version="621" date="22-04-2012" internalversion="8.1.0.0">
		<file name="File downloads.xml" source="/Files/System/OMC/Reports/Marketing reports/Conversions" target="/Files/System/OMC/Reports/Marketing reports/Conversions" overwrite="false" />
		<file name="Form submissions.xml" source="/Files/System/OMC/Reports/Marketing reports/Conversions" target="/Files/System/OMC/Reports/Marketing reports/Conversions" overwrite="false" />
		<file name="Newsletter subscriptions.xml" source="/Files/System/OMC/Reports/Marketing reports/Conversions" target="/Files/System/OMC/Reports/Marketing reports/Conversions" overwrite="false" />
		<file name="Placed orders.xml" source="/Files/System/OMC/Reports/Marketing reports/Conversions" target="/Files/System/OMC/Reports/Marketing reports/Conversions" overwrite="false" />

		<database file="Statisticsv2.mdb">
			<Statv2Object>
				<sql conditional="">
					ALTER TABLE [Statv2Object] ALTER COLUMN [Statv2ObjectType] NVARCHAR (50) NULL
				</sql>
			</Statv2Object>
		</database>
	 </package>

	<package version="620" date="19-04-2012" internalversion="8.1.0.0">
		<setting key="/Globalsettings/Modules/OMC/Notifications/ReportsSendInterval" value="7" />
		<setting key="/Globalsettings/Modules/OMC/Notifications/ReportsSendFrom" value="3" />
		<setting key="/Globalsettings/Modules/OMC/Notifications/ReportsSendTo" value="5" />

		<file name="EmailReports.html" source="/Files/Templates/OMC/Notifications" target="/Files/Templates/OMC/Notifications" overwrite="false" />

		<database file="Statisticsv2.mdb">
			<OMCEmailProfile>
				<sql conditional="SELECT TOP 1 [OMCEmailProfileID] FROM [OMCEmailProfile] WHERE [OMCEmailProfileSenderEmail] = 'noreply@dynamicweb.dk' AND [OMCEmailProfileSubject] = 'Marketing - Reports'">
					INSERT INTO [OMCEmailProfile] ([OMCEmailProfileSenderEmail], [OMCEmailProfileSubject], [OMCEmailProfileTemplate], [OMCEmailProfileEncoding])
						VALUES ('noreply@dynamicweb.dk', 'Marketing - Reports', '/Files/Templates/OMC/Notifications/EmailReports.html', 'UTF-8')
				</sql>
			</OMCEmailProfile>
		</database>
	</package>

   <package version="619" date="17-04-2012" internalversion="8.1.0.0">
		<file name="preview.js" source="/Files/Templates/eCom/CatalogPublishing" target="/Files/Templates/eCom/CatalogPublishing" overwrite="false" />
		<file name="Common.css" source="/Files/Templates/eCom/CatalogPublishing/css" target="/Files/Templates/eCom/CatalogPublishing/css" overwrite="false" />
		<file name="FirstStyle.css" source="/Files/Templates/eCom/CatalogPublishing/css" target="/Files/Templates/eCom/CatalogPublishing/css" overwrite="false" />
		<file name="LastStyle.css" source="/Files/Templates/eCom/CatalogPublishing/css" target="/Files/Templates/eCom/CatalogPublishing/css" overwrite="false" />
		<file name="HeaderStyle.css" source="/Files/Templates/eCom/CatalogPublishing/css" target="/Files/Templates/eCom/CatalogPublishing/css" overwrite="false" />
		<file name="FooterStyle.css" source="/Files/Templates/eCom/CatalogPublishing/css" target="/Files/Templates/eCom/CatalogPublishing/css" overwrite="false" />
		<file name="RegularPageStyle.css" source="/Files/Templates/eCom/CatalogPublishing/css" target="/Files/Templates/eCom/CatalogPublishing/css" overwrite="false" />
		<file name="Logo.jpg" source="/Files/System" target="/Files/System" overwrite="false" />
	</package>

	<package version="618" date="11-04-2012" internalversion="8.1.0.0">
		<database file="Ecom.mdb">
			<EcomProductCategories>
				<sql conditional="if OBJECT_ID(N'dbo.getRelatedProductNamesForProductAsCSV', N'FN') is not null begin select 1 end">
					create function getRelatedProductNamesForProductAsCSV
					(@id as nvarchar(255), @languageID as nvarchar(255))
					returns nvarchar(1000)
					as
					begin
					declare @csv nvarchar(1000)
					select @csv = coalesce(@csv+'","','') + convert(nvarchar,ProductName)
					from EcomProducts join EcomProductsRelated on ProductID = ProductRelatedProductRelID
					join EcomProductsRelatedGroups on ProductRelatedGroupID = RelatedGroupID and RelatedGroupLanguageID = @languageID
					where ProductRelatedProductID=@id and ProductLanguageID = @languageID
					return '"'+@csv+'"'
					end
				</sql>
				<sql conditional="if OBJECT_ID(N'dbo.getRelatedProductIDsForProductAsCSV', N'FN') is not null begin select 1 end">
					create function getRelatedProductIDsForProductAsCSV
					(@id as nvarchar(255), @languageID as nvarchar(255))
					returns nvarchar(1000)
					as
					begin
					declare @csv nvarchar(1000)
					select @csv = coalesce(@csv+'","','') + convert(nvarchar,ProductRelatedProductRelID)
					from EcomProductsRelated join EcomProductsRelatedGroups on ProductRelatedGroupID = RelatedGroupID and RelatedGroupLanguageID = @languageID
					where ProductRelatedProductID = @id
					return '"'+@csv+'"'
					end
				</sql>
			</EcomProductCategories>
		</database>
	</package>

	<package version="617" date="04-04-2012" internalversion="8.1.0.0">
		<file name="Day.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="true" />
		<file name="Month.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="true" />
		<file name="MonthOverview.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="true" />
		<file name="Week.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="true" />
		<file name="Booking.js" source="/Files/Templates/Booking/js" target="/Files/Templates/Booking/js" overwrite="true" />
	</package>

	<package version="616" date="14-03-2012" internalversion="8.0.0.0">
		<database file="Dynamic.mdb">
		<Page>
			<sql conditional="">
			ALTER TABLE [Page] ADD
				[PageSSLMode] INT NULL
			</sql>
		</Page>
		</database>
	</package>
	<package version="615" date="07-03-2012" internalversion="8.1.0.0">
	<database file="Ecom.mdb">
	  <EcomProductCategories>
		<sql conditional="if OBJECT_ID(N'dbo.getShopSortingForGroupAsCSV', N'FN') is not null begin select 1 end">
		  create function [dbo].getShopSortingForGroupAsCSV
		  (@id as nvarchar(255), @languageid as nvarchar(255))
		  returns NVARCHAR(1000)
		  AS
		  begin
		  declare @csv NVARCHAR(1000)
		  select @csv = coalesce(@csv+'","','') + ShopGroupRelationsSorting
		  from ecomgroups join ecomshopgrouprelation on groupID=shopgroupgroupid join ecomshops on shopgroupshopid=shopid
		  where groupid=@id and GroupLanguageID=@languageID
		  return '"'+@csv+'"'
		  end

		</sql>
	  </EcomProductCategories>
	</database>
  </package>
   <package version="614" date="02-03-2012" internalversion="8.1.0.0">
	<database file="Ecom.mdb">
	  <EcomProductCategories>
		<sql conditional="if OBJECT_ID(N'dbo.getParentGroupsForGroupAsCSV', N'FN') is not null begin select 1 end">
		 create function [dbo].[getParentGroupsForGroupAsCSV]
		  (@id as nvarchar(255))
		  returns varchar(1000)
		  AS
		  begin
		  declare @csv varchar(1000)
		  SELECT @csv = coalesce(@csv+'","','') + GroupRelationsParentID
		  FROM EcomGroupRelations
			WHERE GroupRelationsGroupID= @id
		  return '"'+@csv+'"'
		  end
		</sql>
	  </EcomProductCategories>
	</database>
  </package>

	<package version="613" date="01-03-2012" internalversion="8.1.0.0">
		<file name="CatalogPublishingRegularPage.html" source="/Files/Templates/eCom/CatalogPublishing" target="/Files/Templates/eCom/CatalogPublishing" overwrite="false" />
		<file name="ecom.css" source="/Files/Templates/eCom" target="/Files/Templates/eCom" overwrite="false" />
		<file name="Dialog.js" source="/Files/Templates/eCom" target="/Files/Templates/eCom" overwrite="false" />
		<file name="functions.js" source="/Files/Templates/eCom" target="/Files/Templates/eCom" overwrite="false" />
	</package>

	<package version="612" date="29-02-2012" internalversion="8.1.0.0">
	<database file="Ecom.mdb">
	  <EcomProductCategories>
		<sql conditional="if OBJECT_ID(N'dbo.getVariantOptionIDsForProductAsCSV', N'FN') is not null begin select 1 end">
		  create function getVariantOptionIDsForProductAsCSV
		  (@id as nvarchar(255))
		  returns NVARCHAR(1000)
		  AS
		  begin
		  declare @csv NVARCHAR(1000)
		  SELECT @csv = coalesce(@csv+'","','') + convert(nvarchar,VariantOptionsProductRelationVariantID)
		  FROM EcomVariantOptionsProductRelation WHERE VariantOptionsProductRelationProductID=@id
		  return '"'+@csv+'"'
		  end
		  </sql>
	  </EcomProductCategories>
	</database>
  </package>
   <package version="611" date="29-02-2012" internalversion="8.1.0.0">
		<file name="CatalogPublishingRegularPage.html" source="/Files/Templates/eCom/CatalogPublishing" target="/Files/Templates/eCom/CatalogPublishing" overwrite="false" />
		<file name="CatalogPublishingPageHeader.html" source="/Files/Templates/eCom/CatalogPublishing" target="/Files/Templates/eCom/CatalogPublishing" overwrite="false" />
		<file name="Product.html" source="/Files/Templates/eCom/Product" target="/Files/Templates/eCom/Product" overwrite="false" />
		<file name="ProductAdvanced.html" source="/Files/Templates/eCom/Product" target="/Files/Templates/eCom/Product" overwrite="false" />
	</package>

	<package version="610" date="24-02-2012" internalversion="8.1.0.0">
		<file name="CatalogPublishingFirstPage.html" source="/Files/Templates/eCom/CatalogPublishing" target="/Files/Templates/eCom/CatalogPublishing" overwrite="false" />
		<file name="CatalogPublishingLastPage.html" source="/Files/Templates/eCom/CatalogPublishing" target="/Files/Templates/eCom/CatalogPublishing" overwrite="false" />
		<file name="CatalogPublishingRegularPage.html" source="/Files/Templates/eCom/CatalogPublishing" target="/Files/Templates/eCom/CatalogPublishing" overwrite="false" />
		<file name="CatalogPublishingPageFooter.html" source="/Files/Templates/eCom/CatalogPublishing" target="/Files/Templates/eCom/CatalogPublishing" overwrite="false" />
		<file name="CatalogPublishingPageHeader.html" source="/Files/Templates/eCom/CatalogPublishing" target="/Files/Templates/eCom/CatalogPublishing" overwrite="false" />
		<file name="ProductList.html" source="/Files/Templates/eCom/ProductList" target="/Files/Templates/eCom/ProductList" overwrite="false" />
	</package>

	<package version="609" date="14-02-2012" internalversion="8.1.0.0">
	  <file name="RatingFilter.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
	</package>

	<package version="608" date="08-02-2012" internalversion="8.1.0.0">
	  <database file="Statisticsv2.mdb">
		<Statv2Session>
		  <sql conditional="">ALTER TABLE [Statv2Session] ALTER COLUMN [Statv2SessionAdminUserID] INT NULL</sql>
		  <!--<sql conditional="">ALTER TABLE [Statv2Session] ALTER COLUMN [Statv2SessionExtranetUserID] INT NULL</sql> REMOVED BECAUSE OF INDEX COLLISION AND UPDATE SCRIPT ERROR-->
		</Statv2Session>
	  </database>
	</package>

	<package version="607" date="08-02-2012" internalversion="8.0.1.0">
		<setting key="Globalsettings/Settings/TextEditor/NewEditor/GoogleTranslate" value="False" overwrite="true" />
	</package>

	<package version="606" date="30-01-2012" internalversion="8.0.1.0">
		<file name="ListThread.html" source="/Files/Templates/BasicForum/ListThread" target="/Files/Templates/BasicForum/ListThread" overwrite="false" />
		<file name="ListForum.html" source="/Files/Templates/BasicForum/ListForum" target="/Files/Templates/BasicForum/ListForum" overwrite="false" />
		<file name="functions.js" source="/Files/Templates/BasicForum" target="/Files/Templates/BasicForum" overwrite="false" />
		<file name="Styles.css" source="/Files/Templates/BasicForum" target="/Files/Templates/BasicForum" overwrite="false" />
	</package>

	<package version="605" date="30-01-2012" internalversion="8.0.1.0">
		<database file="Statisticsv2.mdb">
			<Statv2Session>
				<sql conditional="">
					ALTER TABLE [Statv2SessionBot] ADD
					[Statv2SessionUserAgentIsMobile] BIT NULL,
					[Statv2SessionUserAgentOriginalString] NVARCHAR(255) NULL,
					[Statv2SessionUserAgentName] NVARCHAR(25) NULL,
					[Statv2SessionUserAgentFamily] NVARCHAR(25) NULL,
					[Statv2SessionUserAgentOperatingSystem] NVARCHAR(25) NULL,
					[Statv2SessionUserAgentPlatform] NVARCHAR(25) NULL
				</sql>
			</Statv2Session>
		</database>
	</package>

	<package version="604" date="27-01-2012" internalversion="8.0.0.0">
		<database file="Statisticsv2.mdb">
			<Statv2Session>
				<sql conditional="">
					 ALTER TABLE [Statv2Session] ADD
					 [Statv2SessionProfileDynamics] NVARCHAR(MAX) NULL
				</sql>
			</Statv2Session>
		</database>
	</package>

	<package version="603" date="24-01-2012" internalversion="8.0.0.0">
		<file name="Update.html" source="/Files/Templates/BasicForum/Subscription" target="/Files/Templates/BasicForum/Subscription" overwrite="false" />
		<file name="ShowThread.html" source="/Files/Templates/BasicForum/ShowThread" target="/Files/Templates/BasicForum/ShowThread" overwrite="false" />
		 <database file="Forum.mdb">
		   <Forum>
			 <sql conditional="">
			   ALTER TABLE [ForumMessage] ADD
					[ForumMessageAnswerVotes] INT NULL
			 </sql>
			  <sql conditional="">
			   CREATE TABLE [ForumAnswerVotes]
			   (
				   [ForumMessageID] INT NOT NULL,
				   [ForumUserID] INT NOT NULL
			   )
			 </sql>
		   </Forum>
		 </database>
	</package>

	<package version="602" date="17-01-2012" internalversion="8.0.0.0">
		<database file="Dynamic.mdb">
			<Page>
				<sql conditional="">ALTER TABLE Page ADD PageHasExperiment BIT DEFAULT blnFalse</sql>
			  </Page>
			  <Paragraph>
				<sql conditional="">ALTER TABLE Paragraph ADD ParagraphVariation INT NULL</sql>
			  </Paragraph>
		</database>
		<database file="Statisticsv2.mdb">
			<OMCExperiment>
				<sql conditional="">
					CREATE TABLE [OMCExperiment]
					(
						[OMCExperimentID] IDENTITY PRIMARY KEY NOT NULL,
						[OMCExperimentPageID] INT NULL,
						[OMCExperimentName] NVARCHAR(255) NULL,
						[OMCExperimentCreatedDate] DATETIME NULL,
						[OMCExperimentEditedDate] DATETIME NULL,
						[OMCExperimentUserCreate] INT NULL,
						[OMCExperimentUserEdit] INT NULL,
						[OMCExperimentType] INT NULL,
						[OMCExperimentActive] BIT DEFAULT blnTrue,
						[OMCExperimentAlternatePage] NVARCHAR(100) NULL,
						[OMCExperimentGoalType] NVARCHAR(50) NULL,
						[OMCExperimentGoalValue] NVARCHAR(255) NULL,
						[OMCExperimentCombinations] INT NULL,
						[OMCExperimentIncludes] INT NULL,
						[OMCExperimentPattern] INT NULL,
						[OMCExperimentConversionMetric] INT NULL,
						[OMCExperimentShowToBots] INT NULL
					)
				</sql>
			</OMCExperiment>
			 <OMCExperimentView>
				<sql conditional="">
					CREATE TABLE [OMCExperimentView]
					(
						[OMCExperimentViewID] IDENTITY PRIMARY KEY NOT NULL,
						[OMCExperimentViewExperimentID] INT NULL,
						[OMCExperimentViewTime] DATETIME NULL,
						[OMCExperimentViewVisitorID] NVARCHAR(255) NULL,
						[OMCExperimentViewCombinationID] INT NULL,
						[OMCExperimentViewGoalTime] DATETIME NULL,
						[OMCExperimentViewGoalType] NVARCHAR(50) NULL
					)
				</sql>
			</OMCExperimentView>
		</database>
	</package>
	<package version="601" date="02-01-2012" internalversion="8.0.0.0">
		<database file="Dynamic.mdb">
			<Modules>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Calender' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Calender'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'ContextSubscription' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'ContextSubscription'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Factbox'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Forum' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Forum'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'ForumV2' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'ForumV2'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Employee' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Employee'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'ImageGallery' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'ImageGallery'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Metadata'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'TemplateColumn' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'TemplateColumn'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'MwMediaDatabaseEcom'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'MwFlashPlugin'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'MwMediaDatabase'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'MwMediaDatabaseViewer'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'MwCatalog'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'MwProductSheet'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'NewsletterExtended' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'NewsletterExtended'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'TaskManager' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'TaskManager'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Paygate' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Paygate'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Shop' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Shop'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'ContentLinks'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'SearchExtended'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'CartV2' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'CartV2'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Sitemap' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Sitemap'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Sms' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Sms'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'StatisticsV2'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'StatisticsExtended' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'StatisticsExtended'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Tagwall' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Tagwall'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'Weblog' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Weblog'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'eCom_Cart' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'eCom_Cart'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'DealersearchExtranet' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'DealersearchExtranet'
				</sql>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'DealersearchStandard' AND [ModuleAccess] = blnTrue">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'DealersearchStandard'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'IntranoteIntegration'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'SeoAdmin'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'FormV2'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'LanguagePack'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Search'
				</sql>
				<sql conditional="">
					DELETE FROM [Module] WHERE [ModuleSystemName] = 'Statistics'
				</sql>
			</Modules>
		</database>
	</package>

</updates>
