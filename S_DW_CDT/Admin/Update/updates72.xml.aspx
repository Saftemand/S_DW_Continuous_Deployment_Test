<?xml version="1.0" encoding="UTF-8" ?>
<updates>
  <!--
	This file is a legacy update script. It is only used when a solution has been upgraded to 8.0.0.0.
    Add new update packages to the updates.xml.aspx file instead.

    ================================
    DO NOT ADD CONTENT TO THIS FILE!
    ================================
	-->

  <current version="507" releasedate="13-12-2011" internalversion="8.0.0.0" />

   <package version="507" date="13-12-2011" internalversion="8.0.0.0">
        <setting key="/Globalsettings/Modules/OMC/LeadsListPayload" value="0" />
   </package>

  <package version="506" date="12-12-2011" internalversion="8.0.0.0">
        <database file="Statisticsv2.mdb">
            <Statv2Session>
                <sql conditional="">
                    ALTER TABLE [Statv2Session] ADD
                    [Statv2SessionLeadStateChanged] DATETIME NULL
                </sql>
            </Statv2Session>
        </database>
    </package>

  <package version="505" date="12-12-2011" internalversion="8.0.0.0">
  <database file="Dynamic.mdb">
    <MyPageModules>
        <sql conditional="">
            CREATE TABLE [MyPageLink]
            (
                [MyPageLinkID] IDENTITY PRIMARY KEY NOT NULL,
                [MyPageLinkSort] INT NULL,
                [MyPageLinkLink] NVARCHAR(250)
            )
        </sql>
        <sql conditional="SELECT * FROM [MyPageLink] WHERE [MyPageLinkLink] = 'http://developer.dynamicweb-cms.com/'">
            INSERT INTO [MyPageLink] ([MyPageLinkSort], [MyPageLinkLink])
            VALUES (1,'http://developer.dynamicweb-cms.com/')
        </sql>
        <sql conditional="SELECT * FROM [MyPageLink] WHERE [MyPageLinkLink] = 'http://engage.dynamicweb-cms.com/'">
            INSERT INTO [MyPageLink] ([MyPageLinkSort], [MyPageLinkLink])
            VALUES (2,'http://engage.dynamicweb-cms.com/')
        </sql>
        <sql conditional="SELECT * FROM [MyPageLink] WHERE [MyPageLinkLink] = 'http://manual.dynamicweb-cms.com/'">
            INSERT INTO [MyPageLink] ([MyPageLinkSort], [MyPageLinkLink])
            VALUES (3,'http://manual.dynamicweb-cms.com/')
        </sql>
    </MyPageModules>
  </database>
  </package>

  <package version="504" date="12-12-2011" internalversion="8.0.0.0">
  <database file="Dynamic.mdb">
    <MyPageModules>
        <sql conditional="">
            CREATE TABLE [MyPageModule]
            (
                [MyPageModuleID] IDENTITY PRIMARY KEY NOT NULL,
                [MyPageModuleSortNumber] INT NOT NULL,
                [MyPageModuleModuleSystemName] NVARCHAR(50) NOT NULL
            )
        </sql>
        <sql conditional="SELECT * FROM MyPageModule WHERE MyPageModuleModuleSystemName = 'NewsV2'">
            INSERT INTO [MyPageModule] ([MyPageModuleSortNumber], [MyPageModuleModuleSystemName])
            VALUES (1,'NewsV2')
        </sql>
        <sql conditional="SELECT * FROM MyPageModule WHERE MyPageModuleModuleSystemName = 'NewsLetterV3'">
            INSERT INTO [MyPageModule] ([MyPageModuleSortNumber], [MyPageModuleModuleSystemName])
            VALUES (2,'NewsLetterV3')
        </sql>
        <sql conditional="SELECT * FROM MyPageModule WHERE MyPageModuleModuleSystemName = 'DM_Form'">
            INSERT INTO [MyPageModule] ([MyPageModuleSortNumber], [MyPageModuleModuleSystemName])
            VALUES (3,'DM_Form')
        </sql>
        <sql conditional="SELECT * FROM MyPageModule WHERE MyPageModuleModuleSystemName = 'Calendar'">
            INSERT INTO [MyPageModule] ([MyPageModuleSortNumber], [MyPageModuleModuleSystemName])
            VALUES (4,'Calendar')
        </sql>
     </MyPageModules>
   </database>
   </package>

   <package version="503" date="01-12-2011" internalversion="8.0.0.0">
        <setting key="/Globalsettings/Modules/OMC/LeadStates" value="Received a call,Email sent" />
        <database file="Statisticsv2.mdb">
            <Statv2Session>
                <sql conditional="">
                    ALTER TABLE [Statv2Session] ADD
                    [Statv2SessionLeadState] NVARCHAR(255) NULL
                </sql>
            </Statv2Session>
        </database>
    </package>

    <package version="502" date="23-11-2011" internalversion="8.0.0.0">
        <file name="user_edit.html" source="/Files/Templates/UserManagement/ViewProfile" target="/Files/Templates/UserManagement/ViewProfile" overwrite="false" />
        <file name="edit_profile.html" source="/Files/Templates/UserManagement/ViewProfile" target="/Files/Templates/UserManagement/ViewProfile" overwrite="false" />
    </package>

    <package version="501" date="22-11-2011" internalversion="8.0.0.0">
        <file name="user_edit.html" source="/Files/Templates/UserManagement/List" target="/Files/Templates/UserManagement/List" overwrite="false" />
    </package>

    <package version="500" date="22-11-2011" internalversion="8.0.0.0">
      <database file="Statisticsv2.mdb">
        <Statv2Session>
          <sql conditional="">
            CREATE INDEX IX_Statv2Session_Statv2SessionVisitorID ON Statv2Session (Statv2SessionVisitorID)
          </sql>
          <sql conditional="">
            CREATE INDEX IX_Statv2Session_Statv2SessionTimestamp ON Statv2Session (Statv2SessionTimestamp)
          </sql>
        </Statv2Session>
      </database>
    </package>

    <package version="499" date="21-11-2011" internalversion="8.0.0.0">
      <database file="Statisticsv2.mdb">
        <Statv2Session>
          <sql conditional="">
            CREATE UNIQUE INDEX IX_Statv2Session_Statv2SessionID ON Statv2Session (Statv2SessionID)
          </sql>
        </Statv2Session>
      </database>
      <file name="Page performance.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
    </package>

     <package version="498" date="18-11-2011" internalversion="8.0.0.0">
     <database file="Ecom.mdb">
       <Module>
         <sql conditional="">
           UPDATE [EcomTree] SET [TreeHasAccessModuleSystemName] = 'eCom_Catalog' WHERE [id] = 6
         </sql>
       </Module>
     </database> 
   </package>
   
  <package version="497" date="15-11-2011" internalversion="8.0.0.0">
    <database file="Statisticsv2.mdb">
        <OMContentRestriction>
            <sql conditional="">
                ALTER TABLE [OMCContentRestriction]
                ADD [OMCContentRestrictionEvaluationType] INT NULL
            </sql>

            <sql conditional="">
                ALTER TABLE [OMCContentRestrictionPreset]
                ADD [OMCContentRestrictionPresetEvaluationType] INT NULL
            </sql>
        </OMContentRestriction>
    </database>
  </package>

<package version="496" date="10-11-2011" internalversion="8.0.0.0">
    <file name="Errors.html" source="/Files/Templates/Booking" target="/Files/Templates/Booking" overwrite="false" />
</package>    

  <package version="495" date="10-11-2011" internalversion="8.0.0.0">
      <file name="Default.xml" source="/Files/System/OMC/Reports/Themes" target="/Files/System/OMC/Reports/Themes" overwrite="false" />
      <file name="New referrers.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
      <file name="Pageviews by search phrase.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
      <file name="Recent search phrases.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
      <file name="Traffic distribution.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
      <file name="Traffic trend.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
      <file name="Visits by search phrase.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
      <file name="Visits trend.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
      <file name="Visits depth.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
  </package>

    <package version="494" date="09-11-2011" internalversion="8.0.0.0">
        <database file="Statisticsv2.mdb">
            <Statv2Session>
                <sql conditional="">
                    ALTER TABLE [Statv2Session] ADD
                    [Statv2SessionRefererPath] NVARCHAR(MAX) NULL
                </sql>
            </Statv2Session>
        </database>
    </package>

  <package version="493" date="07-11-2011" internalversion="8.0.0.0">
        <database file="Statisticsv2.mdb">
            <OMCProfileDynamics>
                <sql conditional="">
                    CREATE TABLE [OMCProfileDynamics]
                    (
                        [OMCProfileDynamicsID] IDENTITY PRIMARY KEY NOT NULL,
                        [OMCProfileDynamicsItemID] NVARCHAR(255) NOT NULL,
                        [OMCProfileDynamicsItemType] NVARCHAR(100) NOT NULL,
                        [OMCProfileDynamicsPresetID] INT NULL,
                        [OMCProfileDynamicsReference] NVARCHAR(255) NULL,
                        [OMCProfileDynamicsGrowth] INT NULL
                    )
                </sql>
            </OMCProfileDynamics>

            <OMCProfileDynamicsPreset>
                <sql conditional="">
                    CREATE TABLE [OMCProfileDynamicsPreset]
                    (
                        [OMCProfileDynamicsPresetID] IDENTITY PRIMARY KEY NOT NULL,
                        [OMCProfileDynamicsPresetItemType] NVARCHAR(100) NOT NULL,
                        [OMCProfileDynamicsPresetName] NVARCHAR(255) NOT NULL
                    )
                </sql>
            </OMCProfileDynamicsPreset>

            <OMCProfileDynamicsPresetData>
                <sql conditional="">
                    CREATE TABLE [OMCProfileDynamicsPresetData]
                    (
                        [OMCProfileDynamicsPresetDataID] IDENTITY PRIMARY KEY NOT NULL,
                        [OMCProfileDynamicsPresetDataPresetID] INT NOT NULL,
                        [OMCProfileDynamicsPresetDataReference] NVARCHAR(255) NOT NULL,
                        [OMCProfileDynamicsPresetDataGrowth] INT NULL
                    )
                </sql>

                <sql conditional="">
                    ALTER TABLE [OMCProfileDynamicsPresetData] ADD CONSTRAINT [OMCProfileDynamicsPresetData$PresetID] FOREIGN KEY ([OMCProfileDynamicsPresetDataPresetID]) REFERENCES [OMCProfileDynamicsPreset] ([OMCProfileDynamicsPresetID])
                </sql>
            </OMCProfileDynamicsPresetData>
        </database>
    </package>

    <package version="492" date="04-11-2011" internalversion="8.0.0.0">
        <file name="Day.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
        <file name="Week.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
    </package>

    <package version="491" date="03-11-2011" internalversion="8.0.0.0">
        <file name="Day.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
    </package>

   <package version="490" date="01-11-2011" internalversion="8.0.0.0">
     <database file="Dynamic.mdb">
       <Module>
         <sql conditional="">
           UPDATE [Module] SET [ModuleControlPanel] = '' WHERE [ModuleSystemName] = 'OMC'
         </sql>
       </Module>
     </database> 
   </package>

   <package version="489" date="31-10-2011" internalversion="8.0.0.0">
     <database file="Dynamic.mdb">
       <modulebeta>  
         <sql conditional="">
             UPDATE [Module] SET ModuleIsBeta = blnFalse WHERE ModuleSystemName IN ('ImportExport_DW8','BasicForum','OMC')
         </sql>
       </modulebeta>
     </database>
  </package>

   <package version="488" date="26-10-2011" internalversion="8.0.0.0">
	    <file name="Day.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
	    <file name="Month.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
	    <file name="MonthOverview.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
	    <file name="Week.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
	    <file name="Edit.html" source="/Files/Templates/Booking/Calendar/EditReservation" target="/Files/Templates/Booking/Calendar/EditReservation" overwrite="false" />
	    <file name="List.html" source="/Files/Templates/Booking/Calendar/ListItems" target="/Files/Templates/Booking/Calendar/ListItems" overwrite="false" />
        <file name="Show.html" source="/Files/Templates/Booking/Calendar/ShowReservation" target="/Files/Templates/Booking/Calendar/ShowReservation" overwrite="false" />
   </package>

  <package version="487" date="27-10-2011" internalversion="8.0.0.0">
        <database file="Statisticsv2.mdb">
            <OMContentRestriction>
                <sql conditional="">
                    CREATE TABLE [OMCContentRestriction]
                    (
                        [OMCContentRestrictionID] IDENTITY PRIMARY KEY NOT NULL,
                        [OMCContentRestrictionItemID] NVARCHAR(255) NOT NULL,
                        [OMCContentRestrictionItemType] NVARCHAR(100) NOT NULL,
                        [OMCContentRestrictionPresetID] INT NULL,
                        [OMCContentRestrictionReference] NVARCHAR(255) NULL
                    )
                </sql>
            </OMContentRestriction>

            <OMCContentRestrictionPreset>
                <sql conditional="">
                    CREATE TABLE [OMCContentRestrictionPreset]
                    (
                        [OMCContentRestrictionPresetID] IDENTITY PRIMARY KEY NOT NULL,
                        [OMCContentRestrictionPresetItemType] NVARCHAR(100) NOT NULL,
                        [OMCContentRestrictionPresetName] NVARCHAR(255) NOT NULL
                    )
                </sql>
            </OMCContentRestrictionPreset>

            <OMCContentRestrictionPresetData>
                <sql conditional="">
                    CREATE TABLE [OMCContentRestrictionPresetData]
                    (
                        [OMCContentRestrictionPresetDataID] IDENTITY PRIMARY KEY NOT NULL,
                        [OMCContentRestrictionPresetDataPresetID] INT NOT NULL,
                        [OMCContentRestrictionPresetDataReference] NVARCHAR(255) NOT NULL
                    )
                </sql>

                <sql conditional="">
                    ALTER TABLE [OMCContentRestrictionPresetData] ADD CONSTRAINT [OMCContentRestrictionPresetData$PresetID] FOREIGN KEY ([OMCContentRestrictionPresetDataPresetID]) REFERENCES [OMCContentRestrictionPreset] ([OMCContentRestrictionPresetID])
                </sql>
            </OMCContentRestrictionPresetData>
        </database>
    </package>

    <package version="486" date="26-10-2011" internalversion="8.0.0.0">
	    <file name="Day.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
	    <file name="Month.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
	    <file name="MonthOverview.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
	    <file name="Week.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
    </package>

    <package version="485" date="26-10-2011" internalversion="8.0.0.0">
	    <database file="Dynamic.mdb">
	      <rollback>
            <sql conditional="">UPDATE [Module] SET ModuleHiddenMode = blnFalse WHERE ModuleSystemName IN ('LinkSearch','Workflow')</sql>
	      </rollback>
	    </database>
    </package>

    <package version="484" date="24-10-2011" internalversion="8.0.0.0">
        <database file="Statisticsv2.mdb">
            <Statv2Session>
                <sql conditional="">
                    ALTER TABLE [Statv2Session] ADD
                    [Statv2SessionPrimaryProfile] NVARCHAR(255) NULL,
                    [Statv2SessionSecondaryProfile] NVARCHAR(255) NULL,
                    [Statv2SessionProfileEstimate] NVARCHAR(MAX) NULL
                </sql>
            </Statv2Session>
        </database>
    </package>

    <package version="483" date="24-10-2011" internalversion="8.0.0.0">
	    <file name="Day.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
	    <file name="BookingEdit.css" source="/Files/Templates/Booking/css" target="/Files/Templates/Booking/css" overwrite="false" />
	    <file name="Edit.html" source="/Files/Templates/Booking/EditReservation" target="/Files/Templates/Booking/EditReservation" overwrite="false" />
    </package>

    <package version="482" date="21-10-2011" internalversion="8.0.0.0">
        <database file="Statisticsv2.mdb">
            <Statv2Session>
                <sql conditional="">
                    ALTER TABLE [Statv2Session] ADD
                    [Statv2SessionUtmSource] NVARCHAR(255) NULL,
                    [Statv2SessionUtmMedium] NVARCHAR(255) NULL,
                    [Statv2SessionUtmTerm] NVARCHAR(255) NULL,
                    [Statv2SessionUtmCampaign] NVARCHAR(100) NULL
                </sql>
            </Statv2Session>
        </database>
    </package>

    <package version="481" date="19-10-2011" internalversion="8.0.0.0">
	    <file name="Day.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
	    <file name="BookingEdit.css" source="/Files/Templates/Booking/css" target="/Files/Templates/Booking/css" overwrite="false" />
	    <file name="Edit.html" source="/Files/Templates/Booking/EditReservation" target="/Files/Templates/Booking/EditReservation" overwrite="false" />
	    <file name="factory.png" source="/Files/Templates/Booking/Images" target="/Files/Templates/Booking/Images" overwrite="false" />
	    <file name="service_bell.png" source="/Files/Templates/Booking/Images" target="/Files/Templates/Booking/Images" overwrite="false" />
    </package>

  <package version="480" date="17-04-2011" internalversion="8.0.0.0">
        <database file="Dynamic.mdb">
            <Solutions>
                <sql conditional="SELECT TOP 1 [ModuleID] FROM [Module] WHERE [ModuleSystemName] = 'LightFree'">INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleStandard], [ModuleParagraph]) VALUES ('LightFree', 'LightFree', blnFalse, blnFalse, blnFalse)</sql>
                <sql conditional="SELECT TOP 1 [ModuleID] FROM [Module] WHERE [ModuleSystemName] = 'LightExpress'">INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleStandard], [ModuleParagraph]) VALUES ('LightExpress', 'LightExpress', blnFalse, blnFalse, blnFalse)</sql>
            </Solutions>
        </database>
    </package>

  	<package version="479" date="15-10-2011" internalversion="8.0.0.0">
        <file name="user_create_redirect.html" source="/Files/Templates/UserManagement/CreateProfile" target="/Files/Templates/UserManagement/CreateProfile" overwrite="false" />
        <file name="list_users.html" source="/Files/Templates/UserManagement/List" target="/Files/Templates/UserManagement/List" overwrite="false" />
        <file name="list_groups_users_hierarchy.html" source="/Files/Templates/UserManagement/List" target="/Files/Templates/UserManagement/List" overwrite="false" />
        <file name="user_detail.html" source="/Files/Templates/UserManagement/List" target="/Files/Templates/UserManagement/List" overwrite="false" />
        <file name="user_detail.html" source="/Files/Templates/UserManagement/ViewProfile" target="/Files/Templates/UserManagement/ViewProfile" overwrite="false" />
        <file name="view_profile.html" source="/Files/Templates/UserManagement/ViewProfile" target="/Files/Templates/UserManagement/ViewProfile" overwrite="false" />
	</package>

	<package version="478" date="14-10-2011" internalversion="8.0.0.0">
		<file name="Month.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
	</package>

  <package version="477" date="14-10-2011" internalversion="8.0.0.0">
	<database file="Dynamic.mdb">
	  <rollback>
        <sql conditional="">UPDATE [Module] SET ModuleHiddenMode = blnTrue WHERE ModuleSystemName IN ('LinkSearch','Workflow')</sql>
	  </rollback>
	</database>
  </package>
  
  <package version="476" date="13-10-2011" internalversion="8.0.0.0">
	<database file="Dynamic.mdb">
	  <rollback>
		<sql conditional="">ALTER TABLE [Module] DROP [ModuleDeprecated]</sql>
        <sql conditional="">UPDATE [Module] SET ModuleHiddenMode = blnFalse WHERE ModuleSystemName IN ('LinkSearch','Workflow')</sql>
        <sql conditional="">UPDATE [Module] SET ModuleParagraph = blnTrue WHERE ModuleSystemName IN ('Seo','StatisticsExtended')</sql>
	  </rollback>
	</database>
  </package>
  
  <package version="475" date="11-10-2011" internalversion="8.0.0.0">
	<database file="Dynamic.mdb">
	  <Comment>
		<sql conditional="">ALTER TABLE [Comment] ADD [CommentIp] NVARCHAR(16) NULL</sql>
	  </Comment>
	</database>
  </package>

  <package version="474" date="10-10-2011" internalversion="19.2.2.0">
    <database file="Dynamic.mdb">
      <ModuleDeprecated>
        <sql conditional="">UPDATE [Module] SET ModuleDeprecated = blnTrue WHERE ModuleSystemName IN ('NewsletterExtended')</sql>
      </ModuleDeprecated>
    </database>
  </package>

  <package version="473" date="06-10-2011" internalversion="19.2.2.0">
    <database file="Dynamic.mdb">
      <ModuleDeprecated>
        <sql conditional="">UPDATE [Module] SET ModuleDeprecated = blnTrue WHERE ModuleSystemName IN ('eCom_Cart')</sql>
      </ModuleDeprecated>
    </database>
  </package>
  
  <package version="472" date="05-10-2011" internalversion="19.2.2.0">
    <database file="Dynamic.mdb">
      <ModuleDeprecated>
        <sql conditional="">ALTER TABLE [Module] ADD [ModuleDeprecated] BIT DEFAULT blnFalse</sql>
        <sql conditional="">UPDATE [Module] SET ModuleDeprecated = blnFalse</sql>
        <sql conditional="">UPDATE [Module] SET ModuleDeprecated = blnTrue WHERE ModuleSystemName IN ('Weblog','Calender','Forum','ForumV2','DBIntegration','Tagwall','Sms','TaskManager','ContextSubscription')</sql>
        <sql conditional="">UPDATE [Module] SET ModuleDeprecated = blnTrue WHERE ModuleSystemName IN ('Employee','ImageGallery','MwMediaDatabase','Shop','CartV2','Sitemap')</sql>
        <sql conditional="">UPDATE [Module] SET ModuleHiddenMode = blnTrue WHERE ModuleSystemName IN ('LinkSearch','Workflow')</sql>
        <sql conditional="">UPDATE [Module] SET ModuleParagraph = blnFalse WHERE ModuleSystemName IN ('Seo','StatisticsExtended')</sql>
      </ModuleDeprecated>
    </database>
  </package>
  
	<package version="471" date="04-10-2011" internalversion="19.2.2.0">
		<file name="Day.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
		<file name="Month.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
		<file name="MonthOverview.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
		<file name="Week.html" source="/Files/Templates/Booking/Calendar" target="/Files/Templates/Booking/Calendar" overwrite="false" />
		<file name="Booking.css" source="/Files/Templates/Booking/css" target="/Files/Templates/Booking/css" overwrite="false" />
		<file name="Edit.html" source="/Files/Templates/Booking/EditReservation" target="/Files/Templates/Booking/EditReservation" overwrite="false" />
		<file name="Show.html" source="/Files/Templates/Booking/ShowReservation" target="/Files/Templates/Booking/ShowReservation" overwrite="false" />
		<file name="Booking.js" source="/Files/Templates/Booking/js" target="/Files/Templates/Booking/js" overwrite="false" />
        <file name="List.html" source="/Files/Templates/Booking/ListItems" target="/Files/Templates/Booking/ListItems" overwrite="false" />
	</package>
	
	<package version="470" date="30-09-2011" internalversion="19.2.5.2">
	<database file="Dynamic.mdb">
	  <Paragraph>
		<sql conditional="">ALTER TABLE [Page] ADD [PageLayoutPhone] NVARCHAR(255)</sql>
		<sql conditional="">ALTER TABLE [Page] ADD [PageLayoutTablet] NVARCHAR(255)</sql>
		<sql conditional="">ALTER TABLE [Page] ADD [PageHideForPhones] BIT NULL</sql>
		<sql conditional="">ALTER TABLE [Page] ADD [PageHideForTablets] BIT NULL</sql>
		<sql conditional="">ALTER TABLE [Page] ADD [PageHideForDesktops] BIT NULL</sql>
		<sql conditional="">ALTER TABLE [Area] ADD [AreaLayoutPhone] NVARCHAR(255)</sql>
		<sql conditional="">ALTER TABLE [Area] ADD [AreaLayoutTablet] NVARCHAR(255)</sql>
	  </Paragraph>
	</database>
  </package>
  <package version="469" date="30-06-2011" internalversion="19.2.2.0">
    <database file="Ecom.mdb">
      <EcomProductCategories>
        <sql conditional="if OBJECT_ID(N'dbo.getShopsForGroupAsCSV', N'FN') is not null begin select 1 end">
          create function getShopsForGroupAsCSV
          (@id as nvarchar(255), @languageid as nvarchar(255))
          returns varchar(1000)
          AS
          begin
          declare @csv varchar(1000)
          select @csv = coalesce(@csv+'","','') + shopid
          from ecomgroups join ecomshopgrouprelation on groupID=shopgroupgroupid join ecomshops on shopgroupshopid=shopid
          where groupid=@id and GroupLanguageID=@languageID
          return '"'+@csv+'"'
          end
        </sql>
        <sql conditional="if OBJECT_ID(N'dbo.getGroupIDsForProductAsCSV', N'FN') is not null begin select 1 end">
          create function getGroupIDsForProductAsCSV
          (@id as nvarchar(255),@language as nvarchar(255))
          returns varchar(1000)
          AS
          begin
          declare @csv varchar(1000)
          select @csv = coalesce(@csv+'","','') + GroupProductRelationGroupID
          from ecomProducts join EcomGroupProductRelation on productid=groupproductRelationproductID join ecomGroups on groupid=groupproductrelationgroupid
          where ProductID=@id and productlanguageid=@language and grouplanguageid=@language
          return '"'+@csv+'"'
          end
        </sql>
        <sql conditional="if OBJECT_ID(N'dbo.getGroupNamesForProductAsCSV', N'FN') is not null begin select 1 end">
          create function getGroupNamesForProductAsCSV
          (@id as nvarchar(255),@languageID as nvarchar(255))
          returns varchar(1000)
          AS
          begin
          declare @csv varchar(1000)
          select @csv = coalesce(@csv+'","','') + GroupName
          from ecomProducts join EcomGroupProductRelation on productid=groupproductRelationproductID join EcomGroups on GroupProductRelationGroupID=groupid and grouplanguageID = @languageid
          where ProductID=@id and productlanguageid=@languageID and grouplanguageid=@languageID
          return '"'+@csv+'"'
          end
        </sql>
        <sql conditional="if OBJECT_ID(N'dbo.getGroupSortOrderForProductAsCSV', N'FN') is not null begin select 1 end">

          create function getGroupSortOrderForProductAsCSV
          (@id as nvarchar(255),@languageID as nvarchar(255))
          returns varchar(1000)
          AS
          begin
          declare @csv varchar(1000)
          select @csv = coalesce(@csv+'","','') + convert(nvarchar,GroupProductRelationSorting)
          from ecomProducts join EcomGroupProductRelation on productid=groupproductRelationproductID join EcomGroups on GroupProductRelationGroupID=groupid and grouplanguageID = @languageid
          where ProductID=@id and productlanguageid=@languageID and grouplanguageid=@languageID
          return '"'+@csv+'"'
          end
        </sql>
        <sql conditional="if OBJECT_ID(N'dbo.getVariantGroupIDsForProductAsCSV', N'FN') is not null begin select 1 end">
          create function getVariantGroupIDsForProductAsCSV
          (@id as nvarchar(255),@languageID as nvarchar(255))
          returns varchar(1000)
          AS
          begin
          declare @csv varchar(1000)
          select @csv = coalesce(@csv+'","','') + convert(nvarchar,variantGroupID)
          from ecomproducts join ecomvariantgroupproductrelation on productid= variantgroupproductrelationproductid join ecomvariantGroups on  variantgroupid= variantgroupproductrelationvariantgroupid and productlanguageid=variantgrouplanguageid
          where ProductID=@id and productlanguageid=@languageID and variantgrouplanguageid=@languageID
          return '"'+@csv+'"'
          end
        </sql>
        <sql conditional="if OBJECT_ID(N'dbo.getVariantGroupNamesForProductAsCSV', N'FN') is not null begin select 1 end">
          create function getVariantGroupNamesForProductAsCSV
          (@id as nvarchar(255),@languageID as nvarchar(255))
          returns varchar(1000)
          AS
          begin
          declare @csv varchar(1000)
          select @csv = coalesce(@csv+'","','') + convert(nvarchar,variantGroupName)
          from ecomproducts join ecomvariantgroupproductrelation on productid= variantgroupproductrelationproductid join ecomvariantGroups on  variantgroupid= variantgroupproductrelationvariantgroupid and productlanguageid=variantgrouplanguageid
          where ProductID=@id and productlanguageid=@languageID and variantgrouplanguageid=@languageID
          return '"'+@csv+'"'
          end
        </sql>
      </EcomProductCategories>
    </database>
  </package>

  <package version="468" date="29-09-2011" internalversion="19.2.2.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">
          ALTER TABLE [DMFormField] ADD
            [FormFieldOptionSourceType]  INT NULL,
            [FormFieldOptionDataListID]  INT NULL,
            [FormFieldOptionKeyField]  NVARCHAR(255) NULL,
            [FormFieldOptionValueField]  NVARCHAR(255) NULL
        </sql>
      </Module>
    </database>
  </package>


  <package version="467" date="21-09-2011" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <ImportExportDW8>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'ImportExport_DW8'">
          INSERT INTO [Module]
          (
          [ModuleSystemName],
          [ModuleName],
          [ModuleScript],
          [ModuleControlPanel],
          [ModuleHiddenMode],
          [ModuleAccess],
          [ModuleStandard],
          [ModuleParagraph],
          [ModuleIsBeta]
          )
          VALUES
          (
          'ImportExport_DW8',
          'Import Export DW8 edition',
          'IntegrationV2/jobList.aspx',
          '',
          0,
          0,
          1,
          0,
          1
          )
        </sql>
      </ImportExportDW8>
    </database>
  </package>
  <package version="466" date="14-09-2011" internalversion="19.2.2.0">
    <file name="ListThread.html" source="/Files/Templates/BasicForum/ListThread" target="/Files/Templates/BasicForum/ListThread" overwrite="false" />
    <file name="ShowThread.html" source="/Files/Templates/BasicForum/ShowThread" target="/Files/Templates/BasicForum/ShowThread" overwrite="false" />
  </package>

  <package version="465" date="15-09-2011" internalversion="19.2.2.0">
    <file name="functions.js" source="/Files/Templates/BasicForum" target="/Files/Templates/BasicForum" overwrite="false" />
    <file name="CreatePost.html" source="/Files/Templates/BasicForum/CreatePost" target="/Files/Templates/BasicForum/CreatePost" overwrite="false" />
  </package>
  
  <package version="464" date="14-09-2011" internalversion="19.2.2.0">
    <file name="ListThread.html" source="/Files/Templates/BasicForum/ListThread" target="/Files/Templates/BasicForum/ListThread" overwrite="false" />
    <file name="ShowThread.html" source="/Files/Templates/BasicForum/ShowThread" target="/Files/Templates/BasicForum/ShowThread" overwrite="false" />
  </package>

  <package version="463" date="14-09-2011" internalversion="19.2.2.0">
    <file name="CreatePost.html" source="/Files/Templates/BasicForum/CreatePost" target="/Files/Templates/BasicForum/CreatePost" overwrite="false" />
  </package>

  <package version="462" date="13-09-2011" internalversion="19.2.2.0">
    <file name="CreatePost.html" source="/Files/Templates/BasicForum/CreatePost" target="/Files/Templates/BasicForum/CreatePost" overwrite="false" />
  </package>

  <package version="461" date="07-09-2011" internalversion="19.2.2.0">
    <file name="functions.js" source="/Files/Templates/BasicForum" target="/Files/Templates/BasicForum" overwrite="false" />
    <file name="CreatePost.html" source="/Files/Templates/BasicForum/CreatePost" target="/Files/Templates/BasicForum/CreatePost" overwrite="false" />
  </package>

  <package version="460" date="31-08-2011" internalversion="19.2.2.0">
        <database file="Statisticsv2.mdb">
            <Statv2Session>
                <sql conditional="">
                    ALTER TABLE [Statv2Session] ADD
                    [Statv2SessionLastVisitNotified] BIT NULL
                </sql>
            </Statv2Session>
        </database>
    </package>
    
	<package version="459" date="16-08-2011" internalversion="19.2.2.0">
		<file name="Errors.html" source="/Files/Templates/Survey/Layout" target="/Files/Templates/Survey/Layout" overwrite="false" />
		<file name="functions.js" source="/Files/Templates/Survey" target="/Files/Templates/Survey" overwrite="false" />
	</package>


	<package version="458" date="16-08-2011" internalversion="19.2.2.0">
    <file name="functions.js" source="/Files/Templates/BasicForum" target="/Files/Templates/BasicForum" overwrite="false" />
    <file name="Styles.css" source="/Files/Templates/BasicForum" target="/Files/Templates/BasicForum" overwrite="false" />
    <file name="CreatePost.html" source="/Files/Templates/BasicForum/CreatePost" target="/Files/Templates/BasicForum/CreatePost" overwrite="false" />
  </package>

  <package version="457" date="12-08-2011" internalversion="19.2.2.0">
        <database file="Statisticsv2.mdb">
            <OMCEmailNotification>
                <sql conditional="">
                    ALTER TABLE [OMCEmailNotification] ADD [OMCEmailNotificationType] NVARCHAR(255) NULL
                </sql>
            </OMCEmailNotification>
        </database>
    </package>
    
    <package version="456" date="12-08-2011" internalversion="19.2.2.0">
        <database file="Statisticsv2.mdb">
            <OMCReturningVisitorNotification>
                <sql conditional="">
                    CREATE TABLE [OMCReturningVisitorNotification]
                    (
                    [OMCReturningVisitorNotificationID] IDENTITY PRIMARY KEY NOT NULL,
                    [OMCReturningVisitorNotificationVisitorID] NVARCHAR(255) NOT NULL,
                    [OMCReturningVisitorNotificationSettingsID] INT NOT NULL
                    )
                </sql>

                <sql conditional="">
                    ALTER TABLE [OMCReturningVisitorNotification] ADD CONSTRAINT [OMCReturningVisitorNotification$SettingsID] FOREIGN KEY ([OMCReturningVisitorNotificationSettingsID]) REFERENCES [OMCEmailNotification] ([OMCEmailNotificationID])
                </sql>
            </OMCReturningVisitorNotification>
        </database>
    </package>

    <package version="455" date="12-08-2011" internalversion="19.2.2.0">
        <database file="Statisticsv2.mdb">
            <OMCEmailNotification>
                <sql conditional="">
                    CREATE TABLE [OMCEmailNotification]
                    (
                    [OMCEmailNotificationID] IDENTITY PRIMARY KEY NOT NULL,
                    [OMCEmailNotificationProfileID] INT NOT NULL,
                    [OMCEmailNotificationName] NVARCHAR(255) NOT NULL
                    )
                </sql>
            </OMCEmailNotification>
            <OMCEmailNotificationRecipient>
                <sql conditional="">
                    CREATE TABLE [OMCEmailNotificationRecipient]
                    (
                    [OMCEmailNotificationRecipientID] IDENTITY PRIMARY KEY NOT NULL,
                    [OMCEmailNotificationRecipientNotificationID] INT NOT NULL,
                    [OMCEmailNotificationRecipientName] NVARCHAR(255) NULL,
                    [OMCEmailNotificationRecipientEmail] NVARCHAR(255) NOT NULL
                    )
                </sql>

                <sql conditional="">
                    ALTER TABLE [OMCEmailNotificationRecipient] ADD CONSTRAINT [OMCEmailNotificationRecipient$NotificationID] FOREIGN KEY ([OMCEmailNotificationRecipientNotificationID]) REFERENCES [OMCEmailNotification] ([OMCEmailNotificationID])
                </sql>

                <sql conditional="">
                    ALTER TABLE [OMCEmailNotification] ADD CONSTRAINT [OMCEmailNotification$ProfileID] FOREIGN KEY ([OMCEmailNotificationProfileID]) REFERENCES [OMCEmailProfile] ([OMCEmailProfileID])
                </sql>
            </OMCEmailNotificationRecipient>
        </database>
    </package>

    <package version="454" date="12-08-2011" internalversion="19.2.2.0">
        <database file="Statisticsv2.mdb">
            <OMCEmailProfile>
                <sql conditional="">
                    CREATE TABLE [OMCEmailProfile]
                    (
                    [OMCEmailProfileID] IDENTITY PRIMARY KEY NOT NULL,
                    [OMCEmailProfileSenderName] NVARCHAR(255) NULL,
                    [OMCEmailProfileSenderEmail] NVARCHAR(255) NOT NULL,
                    [OMCEmailProfileSubject] NVARCHAR(255) NULL,
                    [OMCEmailProfileTemplate] NVARCHAR(255) NULL,
                    [OMCEmailProfileEncoding] NVARCHAR(100) NULL
                    )
                </sql>

                <sql conditional="SELECT TOP 1 [OMCEmailProfileID] FROM [OMCEmailProfile] WHERE [OMCEmailProfileSenderEmail] = 'noreply@dynamicweb.dk' AND [OMCEmailProfileSubject] = 'Marketing - Leads'">
                    INSERT INTO [OMCEmailProfile] ([OMCEmailProfileSenderEmail], [OMCEmailProfileSubject], [OMCEmailProfileTemplate], [OMCEmailProfileEncoding])
                    VALUES ('noreply@dynamicweb.dk', 'Marketing - Leads', '/Files/Templates/OMC/Notifications/EmailLeads.html', 'UTF-8')
                </sql>
            </OMCEmailProfile>
        </database>
    </package>

    <package version="453" date="12-08-2011" internalversion="19.2.2.0">
        <file name="EmailLeads.html" source="/Files/Templates/OMC/Notifications" target="/Files/Templates/OMC/Notifications" overwrite="false" />
    </package>

    <package version="452" date="12-08-2011" internalversion="19.2.2.0">
        <database file="Statisticsv2.mdb">
            <Statv2Session>
                <sql conditional="">
                    ALTER TABLE [Statv2Session] ADD
                    [Statv2SessionVisitorID] NVARCHAR(255) NULL,
                    [Statv2SessionIsLead] BIT NULL,
                    [Statv2SessionEngagement] FLOAT NULL
                </sql>
            </Statv2Session>
        </database>
    </package>
    
  <package version="451" date="12-08-2011" internalversion="19.2.2.0">
    <file name="CreatePost.html" source="/Files/Templates/BasicForum/CreatePost" target="/Files/Templates/BasicForum/CreatePost" overwrite="false" />
  </package>
  
  <package version="450" date="12-08-2011" internalversion="19.2.2.0">
    <file name="Styles.css" source="/Files/Templates/BasicForum" target="/Files/Templates/BasicForum" overwrite="false" />

    <file name="ListForum.html" source="/Files/Templates/BasicForum/ListForum" target="/Files/Templates/BasicForum/ListForum" overwrite="false" />
  </package>
  
  <package version="449" date="11-08-2011" internalversion="19.2.2.0">
    <file name="functions.js" source="/Files/Templates/BasicForum" target="/Files/Templates/BasicForum" overwrite="false" />
    <file name="Styles.css" source="/Files/Templates/BasicForum" target="/Files/Templates/BasicForum" overwrite="false" />

    <file name="CreatePost.html" source="/Files/Templates/BasicForum/CreatePost" target="/Files/Templates/BasicForum/CreatePost" overwrite="false" />
    <file name="ListThread.html" source="/Files/Templates/BasicForum/ListThread" target="/Files/Templates/BasicForum/ListThread" overwrite="false" />
    <file name="ShowThread.html" source="/Files/Templates/BasicForum/ShowThread" target="/Files/Templates/BasicForum/ShowThread" overwrite="false" />
  </package>
  
	<package version="448" date="8-10-2011" internalversion="19.2.2.0">
		<database file="Forum.mdb">
			<ForumCategory>
				<sql conditional="">ALTER TABLE [ForumCategory] ADD [ForumCategoryCreatedDate]  datetime</sql>
			</ForumCategory>
		</database>
	</package>

	<package version="447" date="08-07-2011" internalversion="19.2.2.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT TOP 1 [ModuleID] FROM [Module] WHERE [ModuleSystemName] = 'UnlimitedPages'">INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleStandard], [ModuleParagraph]) VALUES ('UnlimitedPages', 'Unlimited pages', blnFalse, blnFalse, blnFalse)</sql>
      </Module>
    </database>
  </package>

  <package version="446" date="06-07-2011" internalversion="19.2.0.0">
      <file name="Default.xml" source="/Files/System/OMC/Reports/Themes" target="/Files/System/OMC/Reports/Themes" overwrite="false" />
      <file name="New referrers.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
      <file name="Pageviews by search phrase.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
      <file name="Recent search phrases.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
      <file name="Traffic distribution.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
      <file name="Traffic trend.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
      <file name="Visits by search phrase.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
      <file name="Visits trend.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
      <file name="Visits depth.xml" source="/Files/System/OMC/Reports/Marketing reports" target="/Files/System/OMC/Reports/Marketing reports" overwrite="false" />
  </package>
    
  <package version="445" date="04-07-2011" internalversion="19.2.0.0">
      <database file="Dynamic.mdb">
          <Module>
              <sql conditional="">UPDATE [Module] SET ModuleControlPanel = '/Admin/Module/OMC/OMC_cpl.aspx' WHERE ModuleSystemName = 'OMC'</sql>
          </Module>
      </database>
  </package>
    
  <package version="444" date="20-04-2011" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleControlPanel = NULL WHERE ModuleSystemName = 'Filearchive'</sql>
      </Module>
    </database>
  </package>    
    
  <package version="443" date="11-04-2011" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <newsv2>
        <sql conditional="">ALTER TABLE [NewsCategory] ADD [NewsCategoryDefaultPermission] INT NULL</sql>
        <sql conditional="">UPDATE [NewsCategory] SET [NewsCategoryDefaultPermission] = 0 WHERE [NewsCategoryDefaultPermission] IS NULL</sql>
      </newsv2>
    </database>
  </package>
  
  <package version="442" date="07-04-2011" internalversion="19.2.0.0">
    <file name="_sys_fields.xml" source="/Files" target="/Files" overwrite="false" />
  </package>
  
    <package version="441" date="06-04-2011" internalversion="19.2.2.0">
        <database file="Dynamic.mdb">
            <Module>
                <sql conditional="SELECT TOP 1 [ModuleID] FROM [Module] WHERE [ModuleSystemName] = 'Professional'">INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleStandard], [ModuleParagraph]) VALUES ('Professional', 'Professional', blnFalse, blnFalse, blnFalse)</sql>
                <sql conditional="SELECT TOP 1 [ModuleID] FROM [Module] WHERE [ModuleSystemName] = 'Enterprise'">INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleStandard], [ModuleParagraph]) VALUES ('Enterprise', 'Enterprise', blnFalse, blnFalse, blnFalse)</sql>

                <sql conditional="SELECT TOP 1 [ModuleID] FROM [Module] WHERE [ModuleSystemName] = 'eCom_Basic'">INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleStandard], [ModuleParagraph]) VALUES ('eCom_Basic', 'Basic', blnFalse, blnFalse, blnFalse)</sql>
                <sql conditional="SELECT TOP 1 [ModuleID] FROM [Module] WHERE [ModuleSystemName] = 'eCom_Professional'">INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleStandard], [ModuleParagraph]) VALUES ('eCom_Professional', 'Professional', blnFalse, blnFalse, blnFalse)</sql>
                <sql conditional="SELECT TOP 1 [ModuleID] FROM [Module] WHERE [ModuleSystemName] = 'eCom_Enterprise'">INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleStandard], [ModuleParagraph]) VALUES ('eCom_Enterprise', 'Enterprise', blnFalse, blnFalse, blnFalse)</sql>
            </Module>
        </database>
    </package>
    
  <package version="440" date="04-04-2011" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <Page>
        <sql conditional="">ALTER TABLE [NewsCategory] ADD [NewsCategoryPermissionsDeny] NVARCHAR(255) NULL</sql>
      </Page>
    </database>
  </package>

  <package version="439" date="16-03-2011" internalversion="19.2.0.0" >
    <database file="Dynamic.mdb">
      <news>
        <sql conditional="">ALTER TABLE [NewsCategory] ADD [NewsCategoryTemplateID] INT NULL</sql>
        <sql conditional="">ALTER TABLE [NewsCategory] ADD [NewsCategoryTemplateEnforcedForThisCategory] BIT NULL DEFAULT 0</sql>        
      </news>
    </database>
  </package>
  
  <package version="438" date="11-03-2011" internalversion="19.2.0.0" >
    <database file="Dynamic.mdb">
      <news>
        <sql conditional="">
          ALTER TABLE [NewsCategory] ADD [NewsCategorySort] INT NULL
        </sql>
      </news>
    </database>
  </package>
  
  <package version="437" date="09-03-2011" internalversion="19.2.0.0">
	<database file="Dynamic.mdb">
	  <Area>
		<sql conditional="">ALTER TABLE [Area] ADD [AreaRedirectFirstPage] INT NULL</sql>
	  </Area>
	</database>
  </package>
  
  <package version="436" date="09-03-2011" internalversion="19.2.0.0" >
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">
          UPDATE [Module] SET ModuleScript = '../FileManager/Browser/Default.aspx'
          WHERE [ModuleSystemName] IN ('Filearchive','FilearchiveExtended')
        </sql>
      </Module>
    </database>
  </package>
  
  <package version="435" date="09-03-2011" internalversion="19.2.0.0">
    <file name="_fields.xml" source="/Files" target="/Files" overwrite="false" />
  </package>

  <package version="434" date="05-03-2011" internalversion="19.2.0.0">
    <database file="Access.mdb">
      <Page>
        <sql conditional="">ALTER TABLE [AccessElementPermission] ADD [AccessElementPermissionTypePermission] NVARCHAR(50) NULL</sql>
      </Page>
    </database>
  </package>

    <package version="433" date="03-03-2011" internalversion="19.2.0.0">
        <database file="Dynamic.mdb">
            <Module>
                <sql conditional="">UPDATE [Module] SET [ModuleIsBeta] = blnFalse WHERE ModuleSystemName = 'LanguageManagement'</sql>
            </Module>
        </database>
    </package>

    <package version="432" date="25-02-2011" internalversion="19.2.0.0">
        <database file="Dynamic.mdb">
            <OMC>
                <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'OMC'">
                    INSERT INTO [Module]
                    (
                        [ModuleSystemName],
                        [ModuleName],
                        [ModuleScript],
                        [ModuleControlPanel],
                        [ModuleHiddenMode],
                        [ModuleAccess],
                        [ModuleStandard],
                        [ModuleParagraph],
                        [ModuleIsBeta]
                    )
                    VALUES
                    (
                        'OMC',
                        'Marketing',
                        '/Admin/Module/OMC/Default.aspx',
                        '',
                        0,
                        0,
                        0,
                        0,
                        1
                    )
                </sql>
            </OMC>
        </database>
    </package>
    
<package version="431" date="08-02-2011" internalversion="19.2.0.0">
    <database file="Statisticsv2.mdb">
        <Statv2Session>
            <sql conditional="">
                ALTER TABLE [Statv2Session] ADD
                [Statv2SessionRefererSearchKeywords] NVARCHAR(255) NULL,
                [Statv2SessionUserAgentIsMobile] BIT NULL,
                [Statv2SessionUserAgentOriginalString] NVARCHAR(255) NULL,
                [Statv2SessionUserAgentName] NVARCHAR(25) NULL,
                [Statv2SessionUserAgentFamily] NVARCHAR(25) NULL,
                [Statv2SessionUserAgentOperatingSystem] NVARCHAR(25) NULL,
                [Statv2SessionUserAgentPlatform] NVARCHAR(25) NULL
            </sql>
            <sql conditional="">
                ALTER TABLE [Statv2Session] ADD PRIMARY KEY ([Statv2SessionID])
            </sql>
        </Statv2Session>
    </database>
</package>
    
  <package version="430" date="08-02-2011" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <Booking>
        <sql conditional="">ALTER TABLE [BookingItem] DROP [BookingItemServices]</sql>
        <sql conditional="">ALTER TABLE [BookingItem] DROP [BookingItemResources]</sql>
        <sql conditional="">ALTER TABLE [BookingItem] ADD [BookingItemCalendarSetup] NVARCHAR(MAX) NULL</sql>
        <sql conditional="">ALTER TABLE [BookingCategory] ADD [BookingCategoryCalendarSetup] NVARCHAR(MAX) NULL</sql>
      </Booking>
    </database>
  </package>

  <package version="429" date="04-02-2011" internalversion="19.2.0.0">
    <database file="Access.mdb">
      <Page>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserSortXML NVARCHAR(MAX) NULL</sql>
      </Page>
    </database>
  </package>

  <package version="428" date="04-02-2011" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <Booking>
        <sql conditional="">UPDATE [Module] SET [ModuleControlPanel] = '' WHERE [ModuleSystemName] = 'Booking'</sql>
      </Booking>
    </database>
  </package>

  <package version="427" date="31-01-2011" internalversion="19.2.0.0">
	<database file="Dynamic.mdb">
	  <Page>
		<sql conditional="">ALTER TABLE Page ADD PageNavigationTag VARCHAR(255)</sql>
	  </Page>
	</database>
  </package>
  
  <package version="426" date="28-01-2011" internalversion="19.2.0.0">
    <file name="anonymous.png" source="/Files/Templates/BasicForum" target="/Files/Templates/BasicForum" overwrite="false" />
    <file name="Dialog.js" source="/Files/Templates/BasicForum" target="/Files/Templates/BasicForum" overwrite="false" />
    <file name="Styles.css" source="/Files/Templates/BasicForum" target="/Files/Templates/BasicForum" overwrite="false" />

    <file name="CreatePost.html" source="/Files/Templates/BasicForum/CreatePost" target="/Files/Templates/BasicForum/CreatePost" overwrite="false" />
    <file name="Editor.css" source="/Files/Templates/BasicForum/CreatePost" target="/Files/Templates/BasicForum/CreatePost" overwrite="false" />
    <file name="ListForum.html" source="/Files/Templates/BasicForum/ListForum" target="/Files/Templates/BasicForum/ListForum" overwrite="false" />
    <file name="ListThread.html" source="/Files/Templates/BasicForum/ListThread" target="/Files/Templates/BasicForum/ListThread" overwrite="false" />
    <file name="ShowThread.html" source="/Files/Templates/BasicForum/ShowThread" target="/Files/Templates/BasicForum/ShowThread" overwrite="false" />
    <file name="Update.html" source="/Files/Templates/BasicForum/Subscription" target="/Files/Templates/BasicForum/Subscription" overwrite="false" />
  </package>
  
  <package version="425" date="26-01-2011" internalversion="19.2.0.0">
    <database file="Forum.mdb">
      <ForumMessage>
        <sql conditional="">ALTER TABLE [ForumMessage] ADD [ForumMessageIsSticky] BIT NULL</sql>
        <sql conditional="">ALTER TABLE [ForumMessage] ADD [ForumMessageIsAnswer] BIT NULL</sql>
      </ForumMessage>
      <ForumUserRelation>
        <sql conditional="">ALTER TABLE [ForumUserRelation] ADD PRIMARY KEY ([ForumUserRelationID])</sql>
        <sql conditional="">ALTER TABLE [ForumUserRelation] ADD [ForumUserRelationThreadID] INT NULL</sql>
        <sql conditional="">ALTER TABLE [ForumUserRelation] ADD [ForumUserRelationName] NVARCHAR(255) NULL</sql>
        <sql conditional="">ALTER TABLE [ForumUserRelation] ADD [ForumUserRelationEmail] NVARCHAR(255) NULL</sql>
        <sql conditional="">ALTER TABLE [ForumUserRelation] ADD [ForumUserRelationType] INT NULL</sql>
      </ForumUserRelation>
    </database>
    <database file="Dynamic.mdb">
      <BasicForum>
        <sql conditional="">UPDATE [Module] SET [ModuleControlPanel] = '/Admin/Module/BasicForum/BasicForum_cpl.aspx' WHERE [ModuleSystemName] = 'BasicForum'</sql>
      </BasicForum>
    </database>
  </package>

  <package version="424" date="20-01-2011" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <BasicForum>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'BasicForum'">
          INSERT INTO [Module]
          (
            [ModuleSystemName],
            [ModuleName],
            [ModuleScript],
            [ModuleControlPanel],
            [ModuleDescription],
            [ModuleHiddenMode],
            [ModuleAccess],
            [ModuleStandard],
            [ModuleParagraph],
            [ModuleIsBeta]
          )
          VALUES
          (
            'BasicForum',
            'Basic forum',
            '/Admin/Module/BasicForum/Default.aspx',
            '',
            'Basic implementation of the forum.',
            0,
            0,
            1,
            1,
            1
          )
        </sql>
      </BasicForum>
    </database>
  </package>
  
  <package version="423" date="20-01-2011" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <Booking>
        <sql conditional="">ALTER TABLE [BookingReservation] ADD BookingReservationAllDay BIT NULL</sql>
      </Booking>
    </database>
  </package>

  <package version="422" date="20-01-2011" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <Booking>
        <sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'Booking_cpl.aspx' WHERE ModuleSystemName = 'Booking'</sql>
      </Booking>
    </database>
  </package>

  <package version="421" date="28-12-2010" internalversion="19.2.0.0">
    <file name="list_groups_users_hierarchy.html" source="/Files/Templates/UserManagement/List" target="/Files/Templates/UserManagement/List" overwrite="false" />
  </package>


  <package version="420" date="27-12-2010" internalversion="18.11.1.0">
    <database file="Access.mdb">
      <AccessCustomFieldType>
        <sql conditional="SELECT * FROM AccessCustomFieldType WHERE AccessCustomFieldTypeName='Rich Editor'">INSERT INTO AccessCustomFieldType (AccessCustomFieldTypeName, AccessCustomFieldTypeDB, AccessCustomFieldTypeDBSQL) VALUES ( 'Rich Editor', 'MEMO NULL', 'NVARCHAR(MAX) NULL')</sql>
      </AccessCustomFieldType>
    </database>
  </package>
  
    <package version="419" date="22-12-2010" internalversion="19.2.0.0">
        <database file="Dynamic.mdb">
            <Metadata>
                <sql conditional="">DELETE FROM NewsMetadata WHERE MetadataFieldID IN (SELECT FieldID FROM MetadataField WHERE FieldName = 'URL')</sql>
                <sql conditional="">DELETE FROM MetadataField WHERE FieldName = 'URL'</sql>
                <sql conditional="">ALTER TABLE News ADD NewsMetaURL NVARCHAR(255) NULL</sql>
            </Metadata>
        </database>
    </package>

    <package version="418" date="09-12-2010" internalversion="19.2.0.0">
        <database file="Dynamic.mdb">
            <Metadata>
                <sql conditional="SELECT * FROM [MetadataField] WHERE [FieldName] = 'URL'">INSERT INTO [MetadataField] (FieldTypeID, FieldName, FieldDefault) values (1, 'URL', 1)</sql>
            </Metadata>
        </database>
    </package>    
    
  <package version="417" date="08-12-2010" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <paragraph>
      <sql conditional="select moduleAccess from Module where   moduleSystemName='UsersExtended' and ModuleAccess not in (select ModuleAccess from Module where ModuleSystemName='UserManagementBackend'and ModuleAccess=1)">
        UPDATE Module SET ModuleAccess = 'false' WHERE ModuleSystemName ='UsersExtended' or ModuleSystemName='Users'
      </sql>
      </paragraph>
    </database>
  </package>
  <package version="416" date="03-12-2010" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <IndexScheduledUpdate>
        <sql conditional="">
          CREATE TABLE [NewsRelatedCategories]
          (
          [NewsRelatedCategoriesID] IDENTITY PRIMARY KEY NOT NULL,
          [NewsRelatedCategoriesCategoryID] INT,
          [NewsRelatedCategoriesNewID] INT 
          )
        </sql>
      </IndexScheduledUpdate>
    </database>
  </package>

  <package version="415" date="25-11-2010" internalversion="19.2.0.0">
    <file name="sitemapv2.xslt" source="Files/Templates/SitemapV2" target="Files/Templates/SitemapV2" overwrite="false" />
  </package>
  
  <package version="414" date="23-11-2010" internalversion="19.1.0.0">
	<database file="Dynamic.mdb">
	  <Paragraph>
		<sql conditional="">ALTER TABLE [Page] ADD [PageLayoutApplyToSubPages] INT NULL DEFAULT 0</sql>
	  </Paragraph>
	</database>
  </package>
  <package version="413" date="22-11-2010" internalversion="18.13.1.0">
    <database file="Access.mdb">
      <Modify>
        <sql conditional="">ALTER TABLE AccessCustomFieldValue ALTER COLUMN AccessCustomFieldValueKey NVARCHAR(MAX) NOT NULL</sql>
        <sql conditional="">ALTER TABLE AccessCustomFieldValue ALTER COLUMN AccessCustomFieldValueValue NVARCHAR(MAX) NOT NULL</sql>
      </Modify>
    </database>
  </package>

  <package version="412" date="18-11-2010" internalversion="19.2.0.0">
    <file name="ProductListCompareAndRating.html" source="/Files/Templates/eCom/ProductList" target="/Files/Templates/eCom/ProductList" overwrite="false" />
    <file name="CompareProducts.html" source="/Files/Templates/eCom/ProductList" target="/Files/Templates/eCom/ProductList" overwrite="false" />
    <file name="Compare.js" source="/Files/Templates/eCom/ProductList" target="/Files/Templates/eCom/ProductList" overwrite="false" />
    <file name="ecom.css" source="/Files/Templates/eCom/ProductList" target="/Files/Templates/eCom/ProductList" overwrite="false" />
    <!--<file name="cartbg.png" source="/Files/Images/Ecom/Grafik" target="/Files/Images/Ecom/Grafik" overwrite="false" /> NO DW FILES OR IMAGES IN EDITOR FOLDERS -->
  </package>

  <package version="411" date="18-11-2010" internalversion="19.2.0.0">
        <file name="CalendarDefault.html" overwrite="false" target="Files/Templates/Calendar/Booking" source="Files/Templates/Calendar/Booking" />
        <file name="EditBooking.html" overwrite="false" target="Files/Templates/Calendar/Booking" source="Files/Templates/Calendar/Booking" />
        <!--<file name="AcceptCart.html" overwrite="false" target="Files/Templates/eCom/Cart" source="Files/Templates/eCom/Cart" />
        <file name="Customer.html" overwrite="false" target="Files/Templates/eCom/Cart" source="Files/Templates/eCom/Cart" />
        <file name="Method.html" overwrite="false" target="Files/Templates/eCom/Cart" source="Files/Templates/eCom/Cart" />-->
        <file name="Debitech.html" overwrite="false" target="Files/Templates/eCom/Gateway" source="Files/Templates/eCom/Gateway" />
        <file name="Ogone.html" overwrite="false" target="Files/Templates/eCom/Gateway" source="Files/Templates/eCom/Gateway" />
        <file name="PBS.html" overwrite="false" target="Files/Templates/eCom/Gateway" source="Files/Templates/eCom/Gateway" />
        <file name="SecPay.html" overwrite="false" target="Files/Templates/eCom/Gateway" source="Files/Templates/eCom/Gateway" />
        <file name="Post.html" overwrite="false" target="Files/Templates/eCom7/CheckoutHandler/Ogone/Post" source="Files/Templates/eCom7/CheckoutHandler/Ogone/Post" />
        <!--<file name="ChangePassword.html" overwrite="false" target="Files/Templates/Extranet" source="Files/Templates/Extranet" />
        <file name="Login_dk.html" overwrite="false" target="Files/Templates/Extranet" source="Files/Templates/Extranet" />
        <file name="Login_dk_password.html" overwrite="false" target="Files/Templates/Extranet" source="Files/Templates/Extranet" />
        <file name="Login_uk.html" overwrite="false" target="Files/Templates/Extranet" source="Files/Templates/Extranet" />
        <file name="Login_uk_password.html" overwrite="false" target="Files/Templates/Extranet" source="Files/Templates/Extranet" />-->
        <file name="Coloumn_Element.html" overwrite="false" target="Files/Templates/MediaDB" source="Files/Templates/MediaDB" />
        <file name="Element.html" overwrite="false" target="Files/Templates/MediaDB" source="Files/Templates/MediaDB" />
        <file name="Element_en.html" overwrite="false" target="Files/Templates/MediaDB" source="Files/Templates/MediaDB" />
        <file name="Element_jp.html" overwrite="false" target="Files/Templates/MediaDB" source="Files/Templates/MediaDB" />
        <file name="SendToFriendForm.html" overwrite="false" target="Files/Templates/PageFeatures" source="Files/Templates/PageFeatures" />
        <file name="Password/Login.html" overwrite="false" target="Files/Templates/Password" source="Files/Templates/Password" />
        <file name="Login_en.html" overwrite="false" target="Files/Templates/Password" source="Files/Templates/Password" />
        <file name="Login_jp.html" overwrite="false" target="Files/Templates/Password" source="Files/Templates/Password" />
        <!--<file name="DIBSv2.html" overwrite="false" target="Files/Templates/Shop" source="Files/Templates/Shop" />
        <file name="DOBSGateWay.html" overwrite="false" target="Files/Templates/Shop" source="Files/Templates/Shop" />
        <file name="GateWay.html" overwrite="false" target="Files/Templates/Shop" source="Files/Templates/Shop" />
        <file name="EditArticle.html" overwrite="false" target="Files/Templates/Weblog" source="Files/Templates/Weblog" />-->
    </package>
    
  <package version="410" date="30-09-2010" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <Page>
        <sql conditional="">ALTER TABLE [Page] ADD [PageNoindexNofollow] BIT NULL</sql>
        <sql conditional="">ALTER TABLE [Page] ADD [PageRobots404] BIT NULL</sql>
      </Page>
    </database>
  </package>

  <package version="409" date="15-11-2010" internalversion="19.1.0.0">
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="">UPDATE [Module] SET [ModuleIsBeta] = blnFalse, ModuleAccess = blnTrue WHERE ModuleSystemName = 'RemoteHttp'</sql>
	  </Module>
	</database>
  </package>
  
  <package version="408" date="15-11-2010" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <IndexScheduledUpdate>
        <sql conditional="">
          CREATE TABLE [IndexScheduledUpdate]
          (
            [IndexScheduledUpdateID] IDENTITY PRIMARY KEY NOT NULL,
            [IndexScheduledUpdatePath] NVARCHAR(255) NOT NULL,
            [IndexScheduledUpdateType] INT NULL DEFAULT 0,
            [IndexScheduledUpdateInterval] INT NULL DEFAULT 0,
            [IndexScheduledUpdateStartDate] DATETIME NULL,
            [IndexScheduledUpdateLastExecuted] DATETIME NULL,
            [IndexScheduledUpdateIsFullUpdate] BIT NULL DEFAULT 0
          )
        </sql>
      </IndexScheduledUpdate>
    </database>
  </package>
  
  <package version="407" date="08-11-2010" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE ModuleSystemName = 'Metadata' AND ModuleControlPanel = ''">
            UPDATE [Module] SET ModuleControlPanel = '' WHERE ModuleSystemName='Metadata'
        </sql>
      </Module>
    </database>
  </package>

  <package version="406" date="08-11-2010" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE ModuleSystemName = 'Form' AND ModuleAccess = blnFalse">
          UPDATE [Module] SET ModuleAccess = blnTrue WHERE ModuleSystemName='DM_Form'
        </sql>
        <sql conditional="SELECT * FROM [Module] WHERE ModuleSystemName = 'FormExtended' AND ModuleAccess = blnFalse">
          UPDATE [Module] SET ModuleAccess = blnTrue WHERE ModuleSystemName='DM_Form_Extended'
        </sql>
      </Module>
    </database>
  </package>

  <package version="405" date="04-11-2010" internalversion="19.2.0.0">
    <file name="InstantSearch.css" source="/Files/System" target="/Files/System" overwrite="false" />
    <file name="TextFilter.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
    <file name="TextFilterAdvanced.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
  </package>
  
  <package version="404" date="04-11-2010" internalversion="19.2.0.0">
      <database file="Dynamic.mdb">
          <Area>
              <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'CRMIntegration'">
                  INSERT INTO [Module]
                  (
                  [ModuleSystemName],
                  [ModuleName],
                  [ModuleControlPanel],
                  [ModuleDescription],
                  [ModuleHiddenMode],
                  [ModuleParagraph],
                  [ModuleIsBeta]
                  )
                  VALUES
                  (
                  'CRMIntegration',
                  'CRM Integration',
                  '',
                  'Integration to Microsoft CRM',
                  0,
                  0,
                  0
                  )
              </sql>
          </Area>
      </database>
  </package>
  
  <package version="403" date="10-11-2006" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">CREATE TABLE ScheduledTask_tmp (TaskID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, TaskName VARCHAR(255) NOT NULL, TaskBegin DATETIME NOT NULL, TaskEnd DATETIME NOT NULL, TaskLastRun DATETIME NOT NULL, TaskNextRun DATETIME NOT NULL, TaskEnabled BIT NOT NULL, TaskType INT NOT NULL, TaskMinute int NOT NULL DEFAULT -1, TaskHour int NOT NULL DEFAULT -1, TaskDay int NOT NULL DEFAULT -1, TaskWday int NOT NULL DEFAULT -1, TaskTarget VARCHAR(255) NOT NULL, TaskAssembly VARCHAR(255) NULL, TaskNamespace VARCHAR(255) NULL, TaskClass VARCHAR(255) NULL, TaskParam0 VARCHAR(255) NULL, TaskParam1 VARCHAR(255) NULL, TaskParam2 VARCHAR(255) NULL, TaskParam3 VARCHAR(255) NULL, TaskParam4 VARCHAR(255) NULL)</sql>
        <sql conditional="">INSERT INTO ScheduledTask_tmp (TaskName, TaskBegin, TaskEnd, TaskLastRun, TaskNextRun, TaskEnabled, TaskType, TaskMinute, TaskHour, TaskDay, TaskWday, TaskTarget, TaskAssembly, TaskNamespace, TaskClass, TaskParam0, TaskParam1, TaskParam2, TaskParam3, TaskParam4) SELECT TaskName, TaskBegin, TaskEnd, TaskLastRun, TaskNextRun, TaskEnabled, TaskType, TaskMinute, TaskHour, TaskDay, TaskWday, TaskTarget, TaskAssembly, TaskNamespace, TaskClass, TaskParam0, TaskParam1, TaskParam2, TaskParam3, TaskParam4 FROM ScheduledTask</sql>
        <sql conditional="">DROP TABLE ScheduledTask</sql>
        <sql conditional="">CREATE TABLE ScheduledTask (TaskID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, TaskName VARCHAR(255) NOT NULL, TaskBegin DATETIME NOT NULL, TaskEnd DATETIME NOT NULL, TaskLastRun DATETIME NOT NULL, TaskNextRun DATETIME NOT NULL, TaskEnabled BIT NOT NULL, TaskType INT NOT NULL, TaskMinute int NOT NULL DEFAULT -1, TaskHour int NOT NULL DEFAULT -1, TaskDay int NOT NULL DEFAULT -1, TaskWday int NOT NULL DEFAULT -1, TaskTarget VARCHAR(255) NOT NULL, TaskAssembly VARCHAR(255) NULL, TaskNamespace VARCHAR(255) NULL, TaskClass VARCHAR(255) NULL, TaskParam0 VARCHAR(255) NULL, TaskParam1 VARCHAR(255) NULL, TaskParam2 VARCHAR(255) NULL, TaskParam3 VARCHAR(255) NULL, TaskParam4 VARCHAR(255) NULL)</sql>
        <sql conditional="">INSERT INTO ScheduledTask (TaskName, TaskBegin, TaskEnd, TaskLastRun, TaskNextRun, TaskEnabled, TaskType, TaskMinute, TaskHour, TaskDay, TaskWday, TaskTarget, TaskAssembly, TaskNamespace, TaskClass, TaskParam0, TaskParam1, TaskParam2, TaskParam3, TaskParam4) SELECT TaskName, TaskBegin, TaskEnd, TaskLastRun, TaskNextRun, TaskEnabled, TaskType, TaskMinute, TaskHour, TaskDay, TaskWday, TaskTarget, TaskAssembly, TaskNamespace, TaskClass, TaskParam0, TaskParam1, TaskParam2, TaskParam3, TaskParam4 FROM ScheduledTask_tmp</sql>
        <sql conditional="">DROP TABLE ScheduledTask_tmp</sql>
      </Module>
    </database>
  </package>

  <package version="402" date="23-10-2010" internalversion="19.2.0.0">
	<database file="Dynamic.mdb">
	  <Comment>
		<sql conditional="">
		  CREATE TABLE [Comment]
		  (
		  [CommentID] IDENTITY PRIMARY KEY NOT NULL,
		  [CommentName] NVARCHAR(255) NULL,
		  [CommentEmail] NVARCHAR(255) NULL,
		  [CommentWebsite] NVARCHAR(255) NULL,
		  [CommentRating] INT NULL,
		  [CommentText] NVARCHAR(MAX) NULL,
		  [CommentItemType] NVARCHAR(25) NOT NULL,
		  [CommentItemID] NVARCHAR(35) NOT NULL,
		  [CommentLangID] NVARCHAR(25) NULL,
		  [CommentCreatedDate] DATETIME NOT NULL,
		  [CommentEditedDate] DATETIME NULL,
		  [CommentCreatedBy] INT NOT NULL,
		  [CommentEditedBy] INT NULL
		  )
		</sql>
	  </Comment>
	</database>
  </package>

  <package version="401" date="14-10-2010" internalversion="19.2.0.0">
	<database file="Log.mdb">
	  <Paragraph>
		<sql conditional="">DELETE FROM GeneralLog WHERE LogDescription LIKE '*PWD:*'</sql>
		<sql conditional="">DELETE FROM GeneralLog WHERE LogDescription LIKE '%PWD:%'</sql>
	  </Paragraph>
	</database>
  </package>

  <package version="400" date="30-09-2010" internalversion="19.2.0.0">
	<database file="Dynamic.mdb">
	  <Paragraph>
		<sql conditional="">ALTER TABLE [Page] ADD [PageMasterType] INT</sql>
	  </Paragraph>
	</database>
  </package>

  <package version="399" date="20-09-2010" internalversion="19.2.0.0">
	<database file="Dynamic.mdb">
	  <Paragraph>
		<sql conditional="">ALTER TABLE [Paragraph] ADD [ParagraphMasterType] INT</sql>
	  </Paragraph>
	</database>
  </package>
  
  <package version="398" date="06-08-2010" internalversion="19.2.0.0">
    <file name="search_form.html" source="/Files/Templates/UserManagement/Search" target="/Files/Templates/UserManagement/Search" overwrite="false" />
    <file name="list_users.html" source="/Files/Templates/UserManagement/List" target="/Files/Templates/UserManagement/List" overwrite="false" />
  </package>
  
  <package version="397" date="04-08-2010" internalversion="19.2.0.0">
    <database file="Access.mdb">
      <Template>
        <sql conditional="">CREATE INDEX Ix_AccessUser_ExternalId ON AccessUser(AccessUserExternalId)</sql>
      </Template>
    </database>
  </package>

  <package version="396" date="03-08-2010" internalversion="19.2.0.0">
    <file name="Subscribe.html" source="/Files/Templates/NewsLetterV3/Edit" target="/Files/Templates/NewsLetterV3/Edit" overwrite="false" />
  </package>

  <package version="395" date="29-07-2010" internalversion="19.2.0.0">
    <database file="Access.mdb">
      <Template>
        <sql conditional="">ALTER TABLE [AccessUser] ADD [AccessUserExternalID] NVARCHAR(250) NULL</sql>
      </Template>
    </database>
  </package>
  
  <package version="394" date="29-07-2010" internalversion="19.2.0.0">
	  <database file="Dynamic.mdb">
	    <UrlPath>
		  <sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName IN ('FilePublishingV2', 'Html', 'LanguageControl')</sql>
	    </UrlPath>
	  </database>
  </package>

  <package version="393" date="22-07-2010" internalversion="19.2.0.0">
	<database file="Dynamic.mdb">
	  <Page>
		<sql conditional="">ALTER TABLE [Page] ADD [PageDisableAutoMeta] BIT</sql>
	  </Page>
  </database>
  </package>
  <package version="392" date="16-07-2010" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">
          UPDATE [Module] SET ModuleLightExpressAccess = blnTrue, ModuleLightFreeAccess = blnTrue 
          WHERE [ModuleSystemName] IN ('Frontpage','Html','Update','TemplateColumn')
        </sql>
      </Module>
    </database>
  </package>
  <package version="391" date="08-07-2010" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <UrlPath>
        <sql conditional="">ALTER TABLE [UrlPath] ADD [UrlPathAreaID] INT</sql>
      </UrlPath>
    </database>
  </package>
  <package version="390" date="05-05-2010" internalversion="19.1.0.0">
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="">update [Module] set ModuleControlPanel = 'LanguageManagement_cpl.aspx' WHERE [ModuleSystemName] = 'LanguageManagement'</sql>
	  </Module>
	</database>
  </package>
  <package version="389" date="12-05-2010" internalversion="19.1.0.0">
    <file name="Detail.html" source="/Files/Templates/DataManagement/Publishings/Custom" target="/Files/Templates/DataManagement/Publishings/Custom" overwrite="false" />
    <file name="Detail.xslt" source="/Files/Templates/DataManagement/Publishings/Custom" target="/Files/Templates/DataManagement/Publishings/Custom" overwrite="false" />
  </package>

  <package version="388" date="05-05-2010" internalversion="19.1.0.0">
	<database file="Dynamic.mdb">
	  <Area>
		<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'LanguageManagement'">
		  INSERT INTO [Module]
		  (
		  [ModuleSystemName],
		  [ModuleName],
		  [ModuleControlPanel],
		  [ModuleDescription],
		  [ModuleHiddenMode],
		  [ModuleParagraph],
		  [ModuleIsBeta]
		  )
		  VALUES
		  (
		  'LanguageManagement',
		  'Language management',
		  'LanguageManagement_cpl.aspx',
		  'Language management',
		  0,
		  0,
		  1
		  )
		</sql>
	  </Area>
	</database>
  </package>
  <package version="387" date="29-04-2010" internalversion="19.1.0.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET [ModuleIsBeta] = blnTrue WHERE ModuleSystemName = 'Booking'</sql>
      </Module>
    </database>
  </package>
  
  <package version="386" date="14-04-2010" internalversion="19.1.0.0">
    <file name="validation.js" source="/Files/System" target="/Files/System" overwrite="false" />
    <file name="Default_validation.html" source="/Files/Templates/DataManagement/Forms/Form" target="/Files/Templates/DataManagement/Forms/Form" overwrite="false" />
    <file name="Default_validation.xslt" source="/Files/Templates/DataManagement/Forms/Form" target="/Files/Templates/DataManagement/Forms/Form" overwrite="false" />
  </package>

  <package version="385" date="09-04-2010" internalversion="19.1.0.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">ALTER TABLE [DMFormField] ADD [FormFieldValidationValue] NVARCHAR(MAX)</sql>
      </Module>
    </database>
  </package>

  <package version="384" date="09-04-2010" internalversion="19.1.0.0">
	<file name="SearchBoxSpellcheck.html" source="/Files/Templates/Searchv1" target="/Files/Templates/Searchv1" overwrite="false" />
  </package>

  <package version="383" date="07-04-2010" internalversion="19.1.0.0">
	<database file="Dynamic.mdb">
      <Module>
        <sql conditional="">ALTER TABLE [Paragraph] ADD [ParagraphPermission] NVARCHAR(MAX)</sql>
      </Module>
    </database>
  </package>

  <package version="382" date="07-04-2010" internalversion="19.1.0.0">
	  <folder source="Files/Templates/Designs" target="Files/Templates" />
  </package>

  <package version="381" date="30-03-2010" internalversion="19.1.0.0">
	<database file="Dynamic.mdb">
	  <Statv2Session>
		<sql conditional="">ALTER TABLE [Paragraph] ADD [ParagraphTemplate] NVARCHAR(255)</sql>
	  </Statv2Session>
	</database>
  </package>
  <package version="380" date="30-03-2010" internalversion="19.1.0.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">ALTER TABLE [Module] ADD [ModuleLightExpressAccess] BIT</sql>
        <sql conditional="">ALTER TABLE [Module] ADD [ModuleLightFreeAccess] BIT</sql>
        <sql conditional="">
          UPDATE [Module] SET [ModuleLightExpressAccess] = blnTrue, [ModuleLightFreeAccess] = blnTrue WHERE [ModuleSystemName] IN
          (
          'SearchFriendlyUrls',
          'UrlPath',
          'Factbox',
          'Filearchive',
          'Password',
          'Tagwall',
          'eCards',
          'Publish',
          'Rotation',
          'RSSFeed',
          'Statisticsv2',
          'Template'
          )
        </sql>
      </Module>
    </database>
  </package>

  <package version="379" date="26-03-2010" internalversion="19.1.0.0">
    <folder source="Files/Templates/Gallery" target="Files/Templates" />
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">DELETE FROM [Module] WHERE [ModuleSystemName] = 'GalleryPDF'</sql>
      </Module>
    </database>
  </package>
  <package version="378" date="23-02-2010" internalversion="19.1.0.0">
    <file name="user_edit.html" source="/Files/Templates/UserManagement/ViewProfile" target="/Files/Templates/UserManagement/ViewProfile" overwrite="false" />
    <file name="user_detail.html" source="/Files/Templates/UserManagement/ViewProfile" target="/Files/Templates/UserManagement/ViewProfile" overwrite="false" />
  </package>

  <package version="377" date="16-02-2010" internalversion="19.1.0.0">
    <database file="Dynamic.mdb">
      <eCom_CartV2>
        <sql conditional="SELECT [ModuleID] FROM [Module] WHERE ModuleSystemName = 'eCom_CartV2'">
          INSERT INTO [Module]
          (
          [ModuleSystemName],
          [ModuleName],
          [ModuleControlPanel],
          [ModuleDescription],
          [ModuleParagraph],
          [ModuleParagraphEditPath],
          [ModuleEcomNotInstalledAccess]
          )
          VALUES
          (
          'eCom_CartV2',
          'Shopping Cart V2',
          '',
          'Cart for Dynamicweb eCommerce',
          blnTrue,
          '/Admin/Module/eCom_CartV2',
          blnFalse
          )
        </sql>
      </eCom_CartV2>
    </database>
  </package>

  <package version="376" date="16-02-2010" internalversion="19.1.0.0">
    <database file="Dynamic.mdb">
      <Statv2Session>
        <sql conditional="">ALTER TABLE [Area] ADD [AreaNotFound] NVARCHAR(255)</sql>
      </Statv2Session>
    </database>
  </package>
  <package version="375" date="16-02-2010" internalversion="19.1.0.0">
    <database file="Statisticsv2.mdb">
      <Statv2Session>
        <sql conditional="">ALTER TABLE [Statv2Session] ADD [Statv2SessionRefererSearchWordRank] INT</sql>
      </Statv2Session>
    </database>
  </package>
  <package version="374" date="10-02-2010" internalversion="19.1.0.0">
    <database file="Dynamic.mdb">
      <SeoExpress>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'SeoExpress'">
          INSERT INTO [Module]
          (
          [ModuleSystemName],
          [ModuleName],
          [ModuleControlPanel],
          [ModuleDescription],
          [ModuleHiddenMode],
          [ModuleParagraph]
          )
          VALUES
          (
          'SeoExpress',
          'Seo Express',
          '',
          'Seo Express',
          0,
          0
          )
        </sql>
      </SeoExpress>
    </database>
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE ModuleSystemName = 'Seo' AND ModuleAccess = blnFalse">UPDATE [Module] SET ModuleAccess = blnTrue, ModuleStandard = blnTrue WHERE ModuleSystemName='SeoExpress'</sql>
      </Module>
    </database>
  </package>
  <package version="373" date="26-01-2010" internalversion="19.1.0.0">
    <database file="Dynamic.mdb">
      <Paragraph>
        <sql conditional="">ALTER TABLE [Paragraph] ADD [ParagraphContainer] NVARCHAR(255)</sql>
      </Paragraph>
    </database>
  </package>
  <package version="372" date="26-01-2010" internalversion="19.1.0.0">
    <database file="Dynamic.mdb">
      <Paragraph>
        <sql conditional="">ALTER TABLE [Page] ADD [PageLayout] NVARCHAR(255)</sql>
        <sql conditional="">ALTER TABLE [Area] ADD [AreaLayout] NVARCHAR(255)</sql>
      </Paragraph>
    </database>
  </package>
  <package version="371" date="16-01-2010" internalversion="19.1.0.0">
    <database file="Dynamic.mdb">
      <GalleryModule>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Gallery'">
          INSERT INTO [Module]
          (
          [ModuleSystemName],
          [ModuleName],
          [ModuleControlPanel],
          [ModuleDescription],
          [ModuleHiddenMode],
          [ModuleParagraph]
          )
          VALUES
          (
          'Gallery',
          'Gallery',
          '',
          'Gallery module',
          0,
          1
          )
        </sql>
      </GalleryModule>
    </database>
  </package>
  <package version="370" date="11-01-2010" internalversion="19.1.0.0">
    <database file="Dynamic.mdb">
      <BookingModule>
        <sql conditional="">DROP TABLE [Booking]</sql>
        <sql conditional="">DROP TABLE [BookingBookingEquipment]</sql>
        <sql conditional="">DROP TABLE [BookingBookingProvision]</sql>
        <sql conditional="">DROP TABLE [BookingCustomField]</sql>
        <sql conditional="">DROP TABLE [BookingCustomFieldType]</sql>
        <sql conditional="">DROP TABLE [BookingCustomFieldValue]</sql>
        <sql conditional="">DROP TABLE [BookingDate]</sql>
        <sql conditional="">DROP TABLE [BookingEquipment]</sql>
        <sql conditional="SELECT COUNT([BookingItemName]) FROM [BookingItem]">DROP TABLE [BookingItem]</sql>
        <sql conditional="">DROP TABLE [BookingItemCustomField]</sql>
        <sql conditional="">DROP TABLE [BookingItemEquipment]</sql>
        <sql conditional="">DROP TABLE [BookingItemProvision]</sql>
        <sql conditional="">DROP TABLE [BookingProvision]</sql>
        <sql conditional="">
          CREATE TABLE [BookingCategory]
          (
          [BookingCategoryID] IDENTITY PRIMARY KEY NOT NULL,
          [BookingCategoryName] NVARCHAR(255) NOT NULL,
          [BookingCategoryAreaID] INT NOT NULL,
          [BookingCategoryCreatedDate] DATETIME NOT NULL,
          [BookingCategoryEditedDate] DATETIME NULL,
          [BookingCategoryCreatedBy] INT NOT NULL,
          [BookingCategoryEditedBy] INT NULL
          )
        </sql>
        <sql conditional="">
          CREATE TABLE [BookingItem]
          (
          [BookingItemID] IDENTITY PRIMARY KEY NOT NULL,
          [BookingItemName] NVARCHAR(255) NOT NULL,
          [BookingItemCategoryID] INT REFERENCES [BookingCategory]([BookingCategoryID]) NOT NULL,
          [BookingItemType] INT NOT NULL,
          [BookingItemServices] NVARCHAR(MAX) NULL,
          [BookingItemResources] NVARCHAR(MAX) NULL,
          [BookingItemDescription] NVARCHAR(MAX) NULL,
          [BookingItemCreatedDate] DATETIME NOT NULL,
          [BookingItemEditedDate] DATETIME NULL,
          [BookingItemCreatedBy] INT NOT NULL,
          [BookingItemEditedBy] INT NULL
          )
        </sql>
        <sql conditional="">
          CREATE TABLE [BookingReservation]
          (
          [BookingReservationID] IDENTITY PRIMARY KEY NOT NULL,
          [BookingReservationName] NVARCHAR(255) NOT NULL,
          [BookingReservationBookingItemID] INT REFERENCES [BookingItem]([BookingItemID]) NOT NULL,
          [BookingReservationParentID] INT NOT NULL,
          [BookingReservationText] NVARCHAR(MAX) NULL,
          [BookingReservationStartTime] DATETIME NOT NULL,
          [BookingReservationEndTime] DATETIME NOT NULL,
          [BookingReservationCreatedDate] DATETIME NOT NULL,
          [BookingReservationEditedDate] DATETIME NULL,
          [BookingReservationCreatedBy] INT NOT NULL,
          [BookingReservationEditedBy] INT NULL
          )
        </sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Booking'">
          INSERT INTO [Module]
          (
          [ModuleSystemName],
          [ModuleName],
          [ModuleScript],
          [ModuleControlPanel],
          [ModuleDescription],
          [ModuleHiddenMode],
          [ModuleParagraph]
          )
          VALUES
          (
          'Booking',
          'Booking',
          'Booking/Default.aspx',
          '',
          'Booking module',
          0,
          1
          )
        </sql>
      </BookingModule>
    </database>
  </package>

  <package version="369" date="11-01-2010" internalversion="19.1.0.0">
    <file name="NewsletterRecipientEdit.html" source="/Files/Templates/NewsletterV3/Edit" target="/Files/Templates/NewsletterV3/Edit" overwrite="false" />
    <file name="NewsletterRecipientEditQuick.html" source="/Files/Templates/NewsletterV3/Edit" target="/Files/Templates/NewsletterV3/Edit" overwrite="false" />
    <file name="NewsletterRecipientUnSubscribe.html" source="/Files/Templates/NewsletterV3/Edit" target="/Files/Templates/NewsletterV3/Edit" overwrite="false" />
    <file name="Subscribe.html" source="/Files/Templates/NewsletterV3/Edit" target="/Files/Templates/NewsletterV3/Edit" overwrite="false" />
    <file name="UnSubscribe.html" source="/Files/Templates/NewsletterV3/Edit" target="/Files/Templates/NewsletterV3/Edit" overwrite="false" />
  </package>

  <package version="368" date="11-12-2009" internalversion="19.1.0.0">
    <database file="Dynamic.mdb">
      <Paragraph>
        <sql conditional="">ALTER TABLE [Paragraph] ADD [ParagraphModuleCSS] NVARCHAR(MAX)</sql>
        <sql conditional="">ALTER TABLE [Paragraph] ADD [ParagraphModuleJS] NVARCHAR(MAX)</sql>
      </Paragraph>
    </database>
  </package>

  <package version="367" date="18-11-2009" internalversion="19.0.1.3">
    <database file="Dynamic.mdb">
      <Area>
        <sql conditional="">ALTER TABLE [Area] ADD [AreaCopyOf] INT NULL</sql>
      </Area>
      <Page>
        <sql conditional="">ALTER TABLE [Page] ADD [PageCopyOf] INT NULL</sql>
      </Page>
      <Paragraph>
        <sql conditional="">ALTER TABLE [Paragraph] ADD [ParagraphCopyOf] INT NULL</sql>
      </Paragraph>
    </database>
  </package>

  <package version="366" date="05-11-2009" internalversion="19.0.0.5">
    <database file="Access.mdb">
      <NewsLetterV3>
        <sql conditional="">ALTER TABLE [NewsLetterV3NewsLetter] DROP [NewsletterSendMethod]</sql>
      </NewsLetterV3>
    </database>
  </package>

  <package version="365" date="20-10-2009" internalversion="19.0.0.5">
    <database file="Dynamic.mdb">
      <PersonalSettings>
        <sql conditional="">
          CREATE TABLE [PersonalSettings]
          (
          [PersonalSettingsID] IDENTITY PRIMARY KEY NOT NULL,
          [PersonalSettingsUserID] INT NOT NULL,
          [PersonalSettingsPagePath] NVARCHAR(MAX) NOT NULL,
          [PersonalSettingsControlID] NVARCHAR(100) NULL,
          [PersonalSettingsData] NVARCHAR(MAX) NULL
          )
        </sql>
      </PersonalSettings>
    </database>
  </package>

  <package version="364" date="19-10-2009" internalversion="19.0.0.5">
    <database file="Dynamic.mdb">
      <Area>
        <sql conditional="">ALTER TABLE [Area] ADD [AreaUpdatedDate] DATETIME NULL</sql>
        <sql conditional="">ALTER TABLE [Area] ADD [AreaCreatedDate] DATETIME NULL</sql>
      </Area>
    </database>
  </package>


  <package version="362" date="08-10-2009" internalversion="19.0.0.3">
    <database file="Dynamic.mdb">
      <Page>
        <sql conditional="">ALTER TABLE [Page] ADD [PageNavigation_UseEcomGroups] BIT NULL </sql>
        <sql conditional="">ALTER TABLE [Page] ADD [PageNavigationParentType] NVARCHAR(50) NULL </sql>
        <sql conditional="">ALTER TABLE [Page] ADD [PageNavigationGroupSelector] NVARCHAR(MAX) NULL </sql>
        <sql conditional="">ALTER TABLE [Page] ADD [PageNavigationMaxLevels] NVARCHAR(50) NULL </sql>
        <sql conditional="">ALTER TABLE [Page] ADD [PageNavigationProductPage] NVARCHAR(MAX) NULL </sql>
        <sql conditional="">ALTER TABLE [Page] ADD [PageNavigationShopSelector] NVARCHAR(MAX) NULL </sql>
      </Page>
    </database>
  </package>

  <package version="360" date="07-10-2009" internalversion="19.0.0.3">
    <!-- Empty - Seo module doesn't need a Control Panel -->
  </package>

  <package version="359" date="18-09-2009" internalversion="19.0.0.1">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">
          UPDATE [Module] SET [ModuleParagraphEditPath] = '/Admin/Module/DataManagement/Form' WHERE [ModuleSystemName] = 'DM_Form';
        </sql>
      </DataManagement>
    </database>
  </package>

  <package version="358" date="11-09-2009" internalversion="19.0.0.0">
    <database file="Dynamic.mdb">
      <ManagementTreeAccessRule>
        <sql conditional="">
          CREATE TABLE [ManagementTreeAccessRule]
          (
          [ManagementTreeAccessRuleID] IDENTITY PRIMARY KEY NOT NULL,
          [ManagementTreeAccessRulePath] MAXCHAR NOT NULL,
          [ManagementTreeAccessRuleType] NVARCHAR (30) NOT NULL
          )
        </sql>
      </ManagementTreeAccessRule>
      <ManagementTreeAccessRuleEntry>
        <sql conditional="">
          CREATE TABLE [ManagementTreeAccessRuleEntry]
          (
          [ManagementTreeAccessRuleEntryID] IDENTITY PRIMARY KEY NOT NULL,
          [ManagementTreeAccessRuleEntryRuleID] INT NOT NULL,
          [ManagementTreeAccessRuleEntryType] NVARCHAR (255) NOT NULL,
          [ManagementTreeAccessRuleEntryFiledName] NVARCHAR (255),
          [ManagementTreeAccessRuleEntryFiledValue] NVARCHAR (255)
          )
        </sql>
      </ManagementTreeAccessRuleEntry>
    </database>
  </package>

  <package version="357" date="04-09-2009" internalversion="19.0.0.0">
    <database file="Dynamic.mdb">
      <Module>
        <!-- Remove UserManagement - replaced by 4 new module licenses -->
        <sql conditional="">DELETE FROM [Module] WHERE [ModuleSystemName] = 'UserManagement'</sql>

        <!-- Add the 4 new module licenses -->
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'UserManagementFrontend'">
          INSERT INTO [Module]
          (
          [ModuleSystemName],
          [ModuleName],
          [ModuleScript],
          [ModuleControlPanel],
          [ModuleDescription],
          [ModuleHiddenMode]
          )
          VALUES
          (
          'UserManagementFrontend',
          'Extranet',
          'UserManagement/Main.aspx',
          'UserManagement_cpl.aspx',
          'Provides an engine and a user interface for frontend users',
          1
          )
        </sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'UserManagementFrontendExtended'">
          INSERT INTO [Module]
          (
          [ModuleSystemName],
          [ModuleName],
          [ModuleDescription],
          [ModuleParagraph],
          [ModuleParagraphEditPath],
          [ModuleHiddenMode]
          )
          VALUES
          (
          'UserManagementFrontendExtended',
          'Udvidet extranet',
          'Extra functionality for the Extranet module',
          blnTrue,
          '/Admin/Module/UserManagement',
          1
          )
        </sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'UserManagementBackend'">
          INSERT INTO [Module]
          (
          [ModuleSystemName],
          [ModuleName],
          [ModuleScript],
          [ModuleControlPanel],
          [ModuleDescription],
          [ModuleHiddenMode]
          )
          VALUES
          (
          'UserManagementBackend',
          'Brugere',
          'UserManagement/Main.aspx',
          'UserManagement_cpl.aspx',
          'Provides an engine and a user interface for backend users',
          1
          )
        </sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'UserManagementBackendExtended'">
          INSERT INTO [Module]
          (
          [ModuleSystemName],
          [ModuleName],
          [ModuleDescription],
          [ModuleHiddenMode]
          )
          VALUES
          (
          'UserManagementBackendExtended',
          'Udvidet brugerstyring',
          'Extra functionality for the Users module',
          1
          )
        </sql>

        <!-- If no old modules is installed, then hide the old modules and unhide the new modules -->
        <sql conditional="SELECT [ModuleID] FROM [Module] WHERE [ModuleSystemName] IN ('Users', 'UsersExtended', 'Extranet', 'ExtranetExtended') AND [ModuleAccess] = blnTrue">
          UPDATE [Module] SET [ModuleHiddenMode] = 0 WHERE [ModuleSystemName] IN ('UserManagementFrontend', 'UserManagementFrontendExtended', 'UserManagementBackend', 'UserManagementBackendExtended');
        </sql>
        <!--
        <sql conditional="SELECT [ModuleID] FROM [Module] WHERE [ModuleSystemName] IN ('Users', 'UsersExtended', 'Extranet', 'ExtranetExtended') AND [ModuleAccess] = blnTrue">
          UPDATE [Module] SET [ModuleHiddenMode] = 1 WHERE [ModuleSystemName] IN ('Users', 'UsersExtended', 'Extranet', 'ExtranetExtended');
        </sql>
        -->
      </Module>
    </database>
  </package>

  <package version="356" date="07-09-2009" internalversion="19.0.0.0">
    <file name="SearchBox.html" source="/Files/Templates/Searchv1" target="/Files/Templates/Searchv1" overwrite="false" />
  </package>

  <package version="355" date="03-09-2009" internalversion="19.0.0.0">
    <file name="newsfunctions.js" source="/Files/Templates/NewsV2" target="/Files/Templates/NewsV2" overwrite="false" />
  </package>

  <package version="354" date="02-09-2009" internalversion="18.17.1.1">
    <database file="Dynamic.mdb">
      <Modules>
        <sql conditional="">
          UPDATE [Module] SET [ModuleLightMicro15Access] = blnTrue, [ModuleLightMicro30Access] = blnTrue WHERE [ModuleSystemName] IN
          ('SearchFriendlyUrls', 'UrlPath', 'Factbox', 'Password', 'Tagwall', 'Publish', 'Template', 'Form');
        </sql>
        <sql conditional="">
          UPDATE [Module] SET [ModuleLightMicro30Access] = blnTrue WHERE [ModuleSystemName] = 'News';
        </sql>
      </Modules>
    </database>
  </package>

  <package version="353" date="31-08-2009" internalversion="18.17.1.1">
    <database file="Dynamic.mdb">
      <Page>
        <sql conditional="">ALTER TABLE Page ADD PageMetaTitle VARCHAR(255)</sql>
      </Page>
    </database>
  </package>

  <package version="352" date="27-08-2009" internalversion="18.17.1.1">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET [ModuleIsBeta] = blnFalse WHERE [ModuleSystemName] IN ('DM_Form', 'DM_Form_Extended', 'DM_Publishing', 'DM_Publishing_Extended')</sql>
      </Module>
    </database>
  </package>

  <package version="351" date="15-06-2009" internalversion="18.17.1.1">
    <database file="Dynamic.mdb">
      <UserManagement>
        <sql conditional="">UPDATE [Module] SET [ModuleIsBeta] = blnFalse WHERE [ModuleSystemName] = 'UserManagement'</sql>
      </UserManagement>
    </database>
  </package>

  <package version="350" date="18-08-2009" internalversion="18.17.1.1">
    <database file="Dynamic.mdb">
      <CustomField>
        <sql conditional="">
          CREATE TABLE CustomField
          (
          CustomFieldSystemName nvarchar(50) NOT NULL,
          CustomFieldTableName nvarchar(255) NOT NULL,
          CustomFieldType nvarchar(50) NOT NULL,
          CustomFieldName nvarchar(255) NOT NULL,
          CustomFieldOptions nvarchar(MAX) NULL,
          PRIMARY KEY (CustomFieldSystemName, CustomFieldTableName)
          )
        </sql>
      </CustomField>
    </database>
  </package>

  <package version="349" date="13-06-2009" internalversion="18.17.1.1">
    <database file="Access.mdb">
      <MyPage>
        <sql conditional="">
          CREATE TABLE MyPageGadgets(
          SystemID nvarchar(50) PRIMARY KEY NOT NULL,
          Title nvarchar(255) NULL,
          Resource nvarchar(max) NULL,
          IsSystemGadget bit NULL,
          InheritSecurityModel nvarchar(255) NULL
          )
        </sql>
        <sql conditional="">
          CREATE TABLE AccessUserMyPageGadgets(
          recID IDENTITY PRIMARY KEY NOT NULL,
          AccessUserID int NOT NULL,
          GadgetSystemID nvarchar(255) NOT NULL,
          Sort int NOT NULL
          )
        </sql>
        <sql conditional="SELECT * FROM MyPageGadgets WHERE SystemID = 'Dynamicweb.MyPageGadgets.LatestNews'">INSERT INTO MyPageGadgets(SystemID, Title, Resource, IsSystemGadget) VALUES('Dynamicweb.MyPageGadgets.LatestNews', 'Latest News', '/Admin/Content/MyPage/Gadgets/News.aspx', blnTrue)</sql>
        <sql conditional="SELECT * FROM MyPageGadgets WHERE SystemID = 'Dynamicweb.MyPageGadgets.Modules'">INSERT INTO MyPageGadgets(SystemID, Title, Resource, IsSystemGadget) VALUES('Dynamicweb.MyPageGadgets.Modules', 'Modules', '/Admin/Content/MyPage/Gadgets/Modules.aspx', blnTrue)</sql>
        <sql conditional="SELECT * FROM MyPageGadgets WHERE SystemID = 'Dynamicweb.MyPageGadgets.MyPages'">INSERT INTO MyPageGadgets(SystemID, Title, Resource, IsSystemGadget) VALUES('Dynamicweb.MyPageGadgets.MyPages', 'My Pages', '/Admin/Content/MyPage/Gadgets/MyPages.aspx', blnTrue)</sql>
        <sql conditional="SELECT * FROM MyPageGadgets WHERE SystemID = 'Dynamicweb.MyPageGadgets.MyTasks'">INSERT INTO MyPageGadgets(SystemID, Title, Resource, IsSystemGadget, InheritSecurityModel) VALUES('Dynamicweb.MyPageGadgets.MyTasks', 'My Tasks', '/Admin/Content/MyPage/Gadgets/MyTasks.aspx', blnTrue, 'TaskManager')</sql>
        <sql conditional="SELECT * FROM MyPageGadgets WHERE SystemID = 'Dynamicweb.MyPageGadgets.Statistics'">INSERT INTO MyPageGadgets(SystemID, Title, Resource, IsSystemGadget, InheritSecurityModel) VALUES('Dynamicweb.MyPageGadgets.Statistics', 'Statistics', '/Admin/Content/MyPage/Gadgets/Statistics.aspx', blnTrue, 'StatisticsV2')</sql>
        <sql conditional="SELECT * FROM MyPageGadgets WHERE SystemID = 'Dynamicweb.MyPageGadgets.Workflow'">INSERT INTO MyPageGadgets(SystemID, Title, Resource, IsSystemGadget, InheritSecurityModel) VALUES ('Dynamicweb.MyPageGadgets.Workflow', 'Workflow', '/Admin/Content/MyPage/Gadgets/Workflow.aspx', blnTrue, 'Workflow')</sql>
      </MyPage>
    </database>
  </package>
  <package version="348" date="15-06-2009" internalversion="18.17.1.1">
    <database file="Dynamic.mdb">
      <UserManagement>
        <sql conditional="">ALTER TABLE [Page] ADD [PageHidden] BIT</sql>
        <sql conditional="">ALTER TABLE [Page] ADD [PageIsTemplate] BIT</sql>
        <sql conditional="">ALTER TABLE [Page] ADD [PageTemplateDescription] NVARCHAR (255) NULL</sql>
      </UserManagement>
    </database>
  </package>
  <package version="347" date="10-06-2009" internalversion="18.16.1.2">
    <folder source="Files/Templates/UserManagement/List" target="Files/Templates/UserManagement" />
    <folder source="Files/Templates/UserManagement/ViewProfile" target="Files/Templates/UserManagement" />
    <folder source="Files/Templates/UserManagement/CreateProfile" target="Files/Templates/UserManagement" />
  </package>

  <package version="346" date="08-07-2009" internalversion="18.16.1.2">
    <!--
    <database file="NewsletterExtended.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE NewsletterExtendedStat ALTER COLUMN NewsletterStatLink MAXCHAR NULL</sql>
      </DataManagement>
    </database>
    -->
  </package>

  <package version="345" date="30-04-2009" internalversion="18.17.1.1">
    <database file="Dynamic.mdb">
      <Template>
        <sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'Sitemap_cpl.aspx' WHERE ModuleSystemName = 'Sitemap'</sql>
      </Template>
    </database>
  </package>

  <package version="344" date="28-05-2009" internalversion="18.16.1.2">
  </package>

  <package version="343" date="27-05-2009" internalversion="18.17.1.1">
    <database file="Access.mdb">
      <Template>
        <sql conditional="">ALTER TABLE [AccessUser] ADD [AccessUserApprovalKey] NVARCHAR(50) NULL</sql>
        <sql conditional="">ALTER TABLE [AccessUser] DROP [AccessUserPagePermissions]</sql>
      </Template>
    </database>
  </package>

  <package version="342" date="27-05-2009" internalversion="18.16.1.2">
    <folder source="Files/Templates/DataManagement/Forms/Form" target="Files/Templates/DataManagement/Forms" />
    <folder source="Files/Templates/DataManagement/Forms/Email" target="Files/Templates/DataManagement/Forms" />
    <folder source="Files/Templates/DataManagement/Forms/Confirmation" target="Files/Templates/DataManagement/Forms" />
  </package>

  <package version="341" date="14-05-2009" internalversion="18.17.1.1">
    <database file="Dynamic.mdb">
      <Template>
        <sql conditional="">ALTER TABLE [Template] ADD [TemplateModifiedDate] DATETIME NULL</sql>
      </Template>
    </database>
  </package>

  <package version="340" date="04-05-2009" internalversion="18.17.1.1">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [ManagementTree] ADD [ManagementTreeSort] INT NULL</sql>
      </DataManagement>
    </database>
  </package>

  <package version="339" date="30-04-2009" internalversion="18.17.1.1">
    <database file="Dynamic.mdb">
      <UserManagement>
        <sql conditional="">ALTER TABLE [Area] ADD [AreaUrlName] NVARCHAR (50) NULL</sql>
        <sql conditional="">ALTER TABLE [Page] ADD [PageUrlName] NVARCHAR (50) NULL</sql>
      </UserManagement>
    </database>
  </package>
  <package version="338" date="15-04-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <UserManagement>
        <sql conditional="">
          UPDATE [Module] SET
          [ModuleParagraph] = blnTrue,
          [ModuleParagraphEditPath] = '/Admin/Module/UserManagement'
          WHERE [ModuleSystemName] = 'UserManagement'
        </sql>
      </UserManagement>
    </database>
    <folder source="Files/Templates/UserManagement" target="Files/Templates" />
  </package>

  <package version="337" date="23-03-2009" internalversion="18.16.1.2">
    <!--
    <database file="NewsletterExtended.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE NewsletterExtendedStat ALTER COLUMN NewsletterStatLink MAXCHAR NULL</sql>
      </DataManagement>
    </database>
    -->
  </package>

  <package version="336" date="23-03-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">UPDATE [Module] SET [ModuleScript] = '/Admin/Module/DataManagement/Default.aspx' WHERE [ModuleSystemName] IN ('DM_Form', 'DM_Publishing')</sql>
      </DataManagement>
    </database>
  </package>

  <package version="335" date="23-03-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [Area] ADD [AreaUserManagementPermissions] MAXCHAR NULL</sql>
        <sql conditional="">ALTER TABLE [Page] ADD [PageUserManagementPermissions] MAXCHAR NULL</sql>
        <sql conditional="">ALTER TABLE [Page] DROP [PageDefaultPermissions]</sql>
      </DataManagement>
    </database>
  </package>

  <package version="334" date="19-03-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [DMFormField] ADD [FormFieldCheckedStatus] BIT</sql>
      </DataManagement>
    </database>
  </package>

  <package version="333" date="13-03-2009" internalversion="18.16.1.2">
    <folder source="Files/Templates/DataManagement/Publishings/Custom" target="Files/Templates/DataManagement/Publishings" />
  </package>

  <package version="332" date="12-03-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [Page] ADD [PageDefaultPermissions] MAXCHAR NULL</sql>
      </DataManagement>
    </database>
  </package>

  <package version="331" date="11-03-2009" internalversion="18.17.1.1">
    <database file="Dynamic.mdb">
      <Management>
        <sql conditional="">
          CREATE TABLE [ManagementTree]
          (
          [ManagementTreeID] IDENTITY PRIMARY KEY NOT NULL,
          [ManagementTreeSystemID] NVARCHAR (30),
          [ManagementTreeSystemParentID] NVARCHAR (30),
          [ManagementTreeName] NVARCHAR (255),
          [ManagementTreeLink] NVARCHAR (255),
          [ManagementTreeTarget] NVARCHAR (20),
          [ManagementTreeIcon] NVARCHAR (255)
          )
        </sql>
      </Management>
    </database>
  </package>

  <package version="330" date="12-03-2009" internalversion="18.16.1.13">
    <!--
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'MwProductSheet'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleEcomNotInstalledAccess, ModuleHiddenMode, ModuleIsBeta, ModuleControlPanel) VALUES ('MwProductSheet', 'Produktark', blnFalse, blnTrue, blnFalse, NULL, blnFalse, blnFalse, 'MwProductSheet_cpl.aspx')</sql>
      </Module>
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'MwCatalog'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleEcomNotInstalledAccess, ModuleHiddenMode, ModuleIsBeta, ModuleControlPanel) VALUES ('MwCatalog', 'Produkt katalog', blnFalse, blnTrue, blnFalse, NULL, blnFalse, blnFalse, 'MwCatalog_cpl.aspx')</sql>
      </Module>
    </database>
    -->
  </package>

  <package version="329" date="09-03-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [Module] ADD [ModuleDefaultPermissions] MAXCHAR NULL</sql>
      </DataManagement>
    </database>
  </package>

  <package version="328" date="09-03-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">DELETE FROM [Module] WHERE [ModuleSystemName] = 'Data_Form'</sql>
        <sql conditional="">DELETE FROM [Module] WHERE [ModuleSystemName] = 'Data_Form_Extended'</sql>
        <sql conditional="">DELETE FROM [Module] WHERE [ModuleSystemName] = 'Data_List'</sql>
        <sql conditional="">DELETE FROM [Module] WHERE [ModuleSystemName] = 'Data_List_Extended'</sql>
      </DataManagement>
    </database>
  </package>

  <package version="327" date="27-02-2009" internalversion="18.16.1.2">
    <file name="FavoritesList.html" overwrite="false" target="Files/Templates/PageFeatures" source="Files/Templates/PageFeatures" />
  </package>

  <package version="326" date="24-02-2009" internalversion="18.16.1.2">
    <!--Empty due to changes in the files structure for Form Templates-->
  </package>

  <package version="325" date="20-02-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">DELETE FROM [Module] WHERE [ModuleSystemName] = 'DataManagement'</sql>
      </DataManagement>
    </database>
  </package>

  <package version="324" date="18-02-2009" internalversion="18.16.1.2">
    <file name="Default_Publishing.xslt" overwrite="false" target="Files/Templates/DataManagement/XSLT/Publishing" source="Files/Templates/DataManagement/XSLT/Publishing" />
  </package>

  <package version="323" date="17-02-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'DataManagement'">
          INSERT INTO [Module]
          (
          ModuleSystemName,
          ModuleName,
          ModuleAccess,
          ModuleStandard,
          ModuleParagraph,
          ModuleScript,
          ModuleDescription,
          ModuleIsBeta
          )
          VALUES
          (
          'DataManagement',
          'DataManagement',
          blnFalse,
          blnFalse,
          blnTrue,
          '/Admin/Module/DataManagement/Default.aspx',
          'Provides utilities for data management',
          blnTrue
          )
        </sql>
      </Module>
    </database>
  </package>

  <package version="322" date="17-02-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'DM_Publishing'">
          INSERT INTO [Module]
          (
          ModuleSystemName,
          ModuleName,
          ModuleAccess,
          ModuleStandard,
          ModuleParagraph,
          ModuleDescription,
          ModuleScript,
          ModuleIsBeta,
          ModuleParagraphEditPath
          )
          VALUES
          (
          'DM_Publishing',
          'DataManagement Publishing',
          blnFalse,
          blnFalse,
          blnTrue,
          'Provides the ability to create and insert data list on pages',
          '/Admin/Module/DataManagement/Default.aspx',
          blnTrue,
          '/Admin/Module/DataManagement/Publishing'
          )
        </sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'DM_Publishing_Extended'">
          INSERT INTO [Module]
          (
          ModuleSystemName,
          ModuleName,
          ModuleAccess,
          ModuleStandard,
          ModuleParagraph,
          ModuleDescription,
          ModuleIsBeta
          )
          VALUES
          (
          'DM_Publishing_Extended',
          'DataManagement Publishing (Extended)',
          blnFalse,
          blnFalse,
          blnFalse,
          'Provides the ability to create and insert data list on pages',
          blnTrue
          )
        </sql>
      </Module>
    </database>
  </package>

  <package version="321" date="17-02-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'DM_Form'">
          INSERT INTO [Module]
          (
          ModuleSystemName,
          ModuleName,
          ModuleAccess,
          ModuleStandard,
          ModuleParagraph,
          ModuleDescription,
          ModuleScript,
          ModuleIsBeta
          )
          VALUES
          (
          'DM_Form',
          'DataManagement Form',
          blnFalse,
          blnFalse,
          blnTrue,
          'Provides the ability to create and insert forms on pages',
          '/Admin/Module/DataManagement/Default.aspx',
          blnTrue
          )
        </sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'DM_Form_Extended'">
          INSERT INTO [Module]
          (
          ModuleSystemName,
          ModuleName,
          ModuleAccess,
          ModuleStandard,
          ModuleParagraph,
          ModuleDescription,
          ModuleIsBeta
          )
          VALUES
          (
          'DM_Form_Extended',
          'DataManagement Form (Extended)',
          blnFalse,
          blnFalse,
          blnFalse,
          'Provides the ability to create and insert forms on pages',
          blnTrue
          )
        </sql>
      </Module>
    </database>
  </package>

  <package version="320" date="12-02-2009" internalversion="18.16.1.2">
    <!--Empty due to changes in the files structure for Form Templates-->
  </package>

  <package version="319" date="11-02-2009" internalversion="18.16.1.2">
    <database file="Access.mdb">
      <UserManagement>
        <sql conditional="">ALTER TABLE AccessUser ALTER COLUMN AccessUserUserName NVARCHAR(255)</sql>
        <sql conditional="">ALTER TABLE AccessUser ALTER COLUMN AccessUserPassword NVARCHAR(255)</sql>
        <sql conditional="">ALTER TABLE AccessUser ALTER COLUMN AccessUserDepartment NVARCHAR(255)</sql>
        <sql conditional="">ALTER TABLE AccessUser ALTER COLUMN AccessUserEmail NVARCHAR(255)</sql>
        <sql conditional="">ALTER TABLE AccessUser ALTER COLUMN AccessUserAddress NVARCHAR(255)</sql>
        <sql conditional="">ALTER TABLE AccessUser ALTER COLUMN AccessUserAddress2 NVARCHAR(255)</sql>
        <sql conditional="">ALTER TABLE AccessUser ALTER COLUMN AccessUserCity NVARCHAR(255)</sql>
        <sql conditional="">ALTER TABLE AccessUser ALTER COLUMN AccessUserCountry NVARCHAR(255)</sql>
        <sql conditional="">ALTER TABLE AccessUser ALTER COLUMN AccessUserJobTitle NVARCHAR(255)</sql>
        <sql conditional="">ALTER TABLE AccessUser ALTER COLUMN AccessUserCompany NVARCHAR(255)</sql>
        <sql conditional="">ALTER TABLE AccessUser ALTER COLUMN AccessUserCustomerNumber NVARCHAR(255)</sql>
        <sql conditional="">ALTER TABLE AccessUser ALTER COLUMN AccessUserZip NVARCHAR(255)</sql>
        <sql conditional="">ALTER TABLE AccessUser ALTER COLUMN AccessUserPhonePriv NVARCHAR(255)</sql>
        <sql conditional="">ALTER TABLE AccessUser ALTER COLUMN AccessUserMobile NVARCHAR(255)</sql>
        <sql conditional="">ALTER TABLE AccessUser ALTER COLUMN AccessUserFax NVARCHAR(255)</sql>
      </UserManagement>
    </database>
  </package>

  <package version="318" date="02-02-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [DMFormSetting] ADD [FormSettingConnection] MAXCHAR NULL</sql>
      </DataManagement>
    </database>
  </package>

  <package version="317" date="02-02-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [DMFormSetting] DROP COLUMN [FormSettingConnectionID]</sql>
      </DataManagement>
    </database>
  </package>

  <package version="316" date="02-02-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [DMFormSetting] ADD [FormSettingConnectionID] INT</sql>
      </DataManagement>
    </database>
  </package>

  <package version="315" date="30-01-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [DMFormSetting] ADD [FormSettingTableName] MAXCHAR NULL</sql>
      </DataManagement>
    </database>
  </package>

  <package version="314" date="27-01-2009" internalversion="18.16.1.2">
    <database file="Access.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [AccessUser] ADD [AccessUserPagePermissions] MAXCHAR NULL</sql>
      </DataManagement>
    </database>
  </package>

  <package version="313" date="26-01-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">ALTER TABLE [Module] ADD [ModuleParagraphEditPath] NVARCHAR (255) NULL</sql>
      </Module>
    </database>
  </package>

  <package version="312" date="26-01-2009" internalversion="18.16.1.2">
    <database file="Access.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [AccessUser] ADD [AccessUserAllowBackend] BIT</sql>
      </DataManagement>
    </database>
  </package>

  <package version="311" date="22-01-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [DMViewColumn] ADD [ViewColumnType] MAXCHAR NULL</sql>
      </DataManagement>
    </database>
  </package>

  <package version="310" date="21-01-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [DMPublishing] ADD [PublishingListStyle] MAXCHAR</sql>
        <sql conditional="">ALTER TABLE [DMPublishing] ADD [PublishingItemStyle] MAXCHAR</sql>
      </DataManagement>
    </database>
  </package>

  <package version="309" date="21-01-2009" internalversion="18.16.1.2">
    <!-- DUMMY PACKAGE SINCE THIS MODULE DOES NOT EXIST ANYMORE
    <file name="Player.html" overwrite="false" target="Files/Templates/Videoplayer" source="Files/Templates/Videoplayer" />
    <file name="player.swf" overwrite="false" target="Files/System/flv" source="Files/System/flv" />
    <file name="swfobject.js" overwrite="false" target="Files/System/flv" source="Files/System/flv" />
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Videoplayer'">
          INSERT INTO [Module]
          (
          ModuleSystemName,
          ModuleName,
          ModuleAccess,
          ModuleStandard,
          ModuleParagraph,
          ModuleScript,
          ModuleDescription,
          ModuleIsBeta,
          ModuleHiddenMode
          )
          VALUES
          (
          'Videoplayer',
          'Video player',
          blnFalse,
          blnFalse,
          blnTrue,
          'Videoplayer/Default.aspx',
          'Provides the ability to insert video on pages',
          blnTrue,
          blnTrue
          )
        </sql>
      </Module>
    </database>
    -->
  </package>

  <package version="308" date="12-01-2009" internalversion="18.16.1.2">
    <file name="DocData.html" overwrite="false" target="Files/Templates/eCom/Gateway" source="Files/Templates/eCom/Gateway" />
    <file name="Ogone.html" overwrite="false" target="Files/Templates/eCom/Gateway" source="Files/Templates/eCom/Gateway" />
  </package>

  <package version="307" date="06-01-2009" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'UserManagement'">
          INSERT INTO [Module]
          (
          ModuleSystemName,
          ModuleName,
          ModuleAccess,
          ModuleStandard,
          ModuleScript,
          ModuleControlPanel,
          ModuleDescription,
          ModuleIsBeta
          )
          VALUES
          (
          'UserManagement',
          'UserManagement',
          blnFalse,
          blnFalse,
          'UserManagement/Main.aspx',
          'UserManagement_cpl.aspx',
          'Provides an engine and a user interface for frontend and backend users',
          blnTrue
          )
        </sql>
      </Module>
    </database>
  </package>

  <package version="306" date="31-12-2008" internalversion="18.16.1.2">
    <database file="Statisticsv2.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [Statv2Report] ADD [Statv2ReportModuleSystemName] MAXCHAR NULL</sql>
        <sql conditional="">UPDATE [Statv2Report] SET Statv2ReportModuleSystemName = 'Searchv1' WHERE Statv2ReportID = 44</sql>
        <sql conditional="">UPDATE [Statv2Report] SET Statv2ReportModuleSystemName = 'Extranet,ExtranetExtended' WHERE Statv2ReportID = 45</sql>
        <sql conditional="">UPDATE [Statv2Report] SET Statv2ReportModuleSystemName = 'Extranet,ExtranetExtended' WHERE Statv2ReportID = 46</sql>
        <sql conditional="">UPDATE [Statv2Report] SET Statv2ReportModuleSystemName = 'Extranet,ExtranetExtended' WHERE Statv2ReportID = 47</sql>
        <sql conditional="">UPDATE [Statv2Report] SET Statv2ReportModuleSystemName = 'News,NewsV2' WHERE Statv2ReportID = 48</sql>
        <sql conditional="">UPDATE [Statv2Report] SET Statv2ReportModuleSystemName = 'Poll' WHERE Statv2ReportID = 49</sql>
        <sql conditional="">UPDATE [Statv2Report] SET Statv2ReportModuleSystemName = 'Form' WHERE Statv2ReportID = 50</sql>
        <sql conditional="">UPDATE [Statv2Report] SET Statv2ReportModuleSystemName = 'NewsLetterV3' WHERE Statv2ReportID = 59</sql>
        <sql conditional="">UPDATE [Statv2Report] SET Statv2ReportModuleSystemName = 'NewsLetterV3' WHERE Statv2ReportID = 60</sql>
      </DataManagement>
    </database>
  </package>

  <package version="305" date="31-12-2008" internalversion="18.16.1.2">
    <!--<file name="Profile.html" overwrite="false" target="Files/Templates/ExtranetExtended" source="Files/Templates/ExtranetExtended" />-->
  </package>

  <package version="304" date="19-12-2008" internalversion="18.16.1.2">
    <!--
    <database file="sms.mdb">
      <SMSSetting>
        <sql conditional="">ALTER TABLE [SMSSetting] ADD [SMSSettingSMSGatewayEncoding] NVARCHAR(250) NULL </sql>
      </SMSSetting>
    </database>
    -->
  </package>

  <package version="303" date="19-12-2008" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [DMPublishing] ADD [PublishingListFields] MAXCHAR NULL</sql>
        <sql conditional="">ALTER TABLE [DMPublishing] ADD [PublishingItemFields] MAXCHAR NULL</sql>
        <sql conditional="">ALTER TABLE [DMPublishing] ADD [PublishingListLayout] NVARCHAR (255)</sql>
        <sql conditional="">ALTER TABLE [DMPublishing] ADD [PublishingItemLayout] NVARCHAR (255)</sql>
        <sql conditional="">ALTER TABLE [DMPublishing] ADD [PublishingShowDetails] BIT</sql>
        <sql conditional="">ALTER TABLE [DMPublishing] ADD [PublishingShowHeadings] BIT</sql>
        <sql conditional="">ALTER TABLE [DMPublishing] ADD [PublishingSortable] BIT</sql>
      </DataManagement>
    </database>
  </package>

  <package version="302" date="15-12-2008" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [DMFormField] ADD [FormFieldDataTypeCode] INT NULL</sql>
        <sql conditional="">ALTER TABLE [DMFormField] ADD [FormFieldDescription] NVARCHAR (255)</sql>
      </DataManagement>
    </database>
  </package>

  <package version="301" date="12-12-2008" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [DMViewSetting] ADD [ViewSettingVariables] MAXCHAR NULL</sql>
      </DataManagement>
    </database>
  </package>

  <package version="300" date="05-12-2008" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [DMViewSetting] ADD [ViewSettingDesignerConfiguration] MAXCHAR NULL</sql>
      </DataManagement>
    </database>
  </package>

  <package version="299" date="02-12-2008" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [DMFormField] ADD [FormFieldDefaultValue] NVARCHAR(255) NULL</sql>
      </DataManagement>
    </database>
  </package>


  <package version="298" date="01-12-2008" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">ALTER TABLE [DMViewSetting] ADD [ViewSettingSQLStatement] MAXCHAR NULL</sql>
      </DataManagement>
    </database>
  </package>

  <package version="297" date="01-12-2008" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">
          CREATE TABLE [DMPublishing]
          (
          [PublishingID] IDENTITY PRIMARY KEY NOT NULL,
          [PublishingName] NVARCHAR (255),
          [PublishingType] INT,
          [PublishingListTemplate] NVARCHAR (255),
          [PublishingItemTemplate] NVARCHAR (255),
          [PublishingXsltFile] NVARCHAR (255),
          [PublishingViewID] INT
          )
        </sql>
      </DataManagement>
    </database>
  </package>

  <package version="296" date="28-11-2008" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <sql conditional="">DROP TABLE [FormSetting]</sql>
        <sql conditional="">DROP TABLE [ConnectionSetting]</sql>
        <sql conditional="">DROP TABLE [ViewSetting]</sql>
        <sql conditional="">DROP TABLE [ViewColumn]</sql>
        <sql conditional="">
          CREATE TABLE [DMFormSetting]
          (
          [FormSettingID] IDENTITY PRIMARY KEY NOT NULL,
          [FormSettingName] NVARCHAR (255),
          [FormSettingType] INT,
          [FormSettingViewID] INT
          )
        </sql>
        <sql conditional="">
          CREATE TABLE [DMFormField]
          (
          [FormFieldID] IDENTITY PRIMARY KEY NOT NULL,
          [FormFieldFormID] INT,
          [FormFieldName] NVARCHAR (255),
          [FormFieldSystemName] NVARCHAR (255),
          [FormFieldLabel] NVARCHAR (255),
          [FormFieldType] INT, [FormFieldWidth] INT,
          [FormFieldHeight] INT,
          [FormFieldMaxLength] INT,
          [FormFieldActive] BIT,
          [FormFieldSort] INT,
          [FormFieldRequired] BIT
          )
        </sql>
        <sql conditional="">
          CREATE TABLE [DMFormFieldOption]
          (
          [FormFieldOptionID] IDENTITY PRIMARY KEY NOT NULL,
          [FormFieldOptionFieldID] INT,
          [FormFieldOptionText] NVARCHAR (255),
          [FormFieldOptionValue] NVARCHAR (255),
          [FormFieldOptionDefault] BIT, [FormFieldOptionActive] BIT,
          [FormFieldOptionSort] INT
          )
        </sql>
        <sql conditional="">
          CREATE TABLE [DMConnectionSetting]
          (
          [ConnectionSettingID] IDENTITY PRIMARY KEY NOT NULL,
          [ConnectionSettingName] NVARCHAR (255),
          [ConnectionSettingDBName] NVARCHAR (255),
          [ConnectionSettingServer] NVARCHAR (255),
          [ConnectionSettingUserId] NVARCHAR (255),
          [ConnectionSettingPassword] NVARCHAR (255),
          [ConnectionSettingLocalPath] NVARCHAR (255),
          [ConnectionSettingString] NVARCHAR (255),
          [ConnectionSettingTrusted] BIT,
          [ConnectionSettingType] INT
          )
        </sql>
        <sql conditional="">
          CREATE TABLE [DMViewSetting]
          (
          [ViewSettingID] IDENTITY PRIMARY KEY NOT NULL,
          [ViewSettingName] NVARCHAR (255),
          [ViewSettingTableName] NVARCHAR (255),
          [ViewSettingConnectionID] INT,
          [ViewSettingConnectionDBName] NVARCHAR (255)
          )
        </sql>
        <sql conditional="">
          CREATE TABLE [DMViewColumn]
          (
          [ViewColumnID] IDENTITY PRIMARY KEY NOT NULL,
          [ViewColumnName] NVARCHAR (255),
          [ViewColumnIsKey] BIT,
          [ViewColumnSettingID] INT
          )
        </sql>
      </DataManagement>
    </database>
  </package>

  <package version="295" date="25-11-2008" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <!--<sql conditional="">
          CREATE TABLE [FormSetting]
          (
          [FormSettingID] IDENTITY PRIMARY KEY NOT NULL,
          [FormSettingName] NVARCHAR (255)
          )
        </sql>
        <sql conditional="">
          CREATE TABLE [FormField]
          (
          [FormFieldID] IDENTITY PRIMARY KEY NOT NULL,
          [FormFieldFormID] INT,
          [FormFieldName] NVARCHAR (255),
          [FormFieldSystemName] NVARCHAR (255),
          [FormFieldLabel] NVARCHAR (255),
          [FormFieldType] INT, [FormFieldWidth] INT,
          [FormFieldHeight] INT,
          [FormFieldMaxLength] INT,
          [FormFieldActive] BIT,
          [FormFieldSort] INT,
          [FormFieldRequired] BIT
          )
        </sql>
        <sql conditional="">
          CREATE TABLE [FormFieldOption]
          (
          [FormFieldOptionID] IDENTITY PRIMARY KEY NOT NULL,
          [FormFieldOptionFieldID] INT,
          [FormFieldOptionText] NVARCHAR (255),
          [FormFieldOptionValue] NVARCHAR (255),
          [FormFieldOptionDefault] BIT, [FormFieldOptionActive] BIT,
          [FormFieldOptionSort] INT
          )
        </sql>-->
      </DataManagement>
    </database>
  </package>

  <package version="294" date="21-11-2008" internalversion="18.16.1.2">
    <database file="Dynamic.mdb">
      <DataManagement>
        <!--<sql conditional="">
          CREATE TABLE [ConnectionSetting]
          (
          [ConnectionSettingID] IDENTITY PRIMARY KEY NOT NULL,
          [ConnectionSettingName] NVARCHAR (255),
          [ConnectionSettingDBName] NVARCHAR (255),
          [ConnectionSettingServer] NVARCHAR (255),
          [ConnectionSettingUserId] NVARCHAR (255),
          [ConnectionSettingPassword] NVARCHAR (255),
          [ConnectionSettingLocalPath] NVARCHAR (255),
          [ConnectionSettingString] NVARCHAR (255),
          [ConnectionSettingTrusted] BIT,
          [ConnectionSettingType] INT
          )
        </sql>
        <sql conditional="">
          CREATE TABLE [ViewSetting]
          (
          [ViewSettingID] IDENTITY PRIMARY KEY NOT NULL,
          [ViewSettingName] NVARCHAR (255),
          [ViewSettingTableName] NVARCHAR (255),
          [ViewSettingConnectionID] INT,
          [ViewSettingConnectionDBName] NVARCHAR (255)
          )
        </sql>
        <sql conditional="">
          CREATE TABLE [ViewColumn]
          (
          [ViewColumnID] IDENTITY PRIMARY KEY NOT NULL,
          [ViewColumnName] NVARCHAR (255),
          [ViewColumnIsKey] BIT,
          [ViewColumnSettingID] INT
          )
        </sql>-->
      </DataManagement>
    </database>
  </package>

  <package version="293" date="13-11-2008" internalversion="18.16.1.1">
    <file name="Results.html" overwrite="false" target="Files/Templates/Validation" source="Files/Templates/Validation" />
  </package>

  <package version="292" date="10-11-2008" internalversion="18.16.1.1">
    <file name="NewsList.html" overwrite="false" target="Files/Templates/Newsletters" source="Files/Templates/Newsletters" />
  </package>

  <package version="291" date="03-11-2008" internalversion="18.16.1.1">
    <database file="Dynamic.mdb">
      <NewsCategory>
        <sql conditional="">ALTER TABLE [NewsCategory] ADD [NewsCategoryAreaIDs] NVARCHAR(MAX) NULL</sql>
      </NewsCategory>
    </database>
  </package>

  <package version="290" date="31-10-2008" internalversion="18.16.1.1">
    <!--
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleParagraph = blnFalse WHERE ModuleSystemName = 'MwFlashPlugin'</sql>
        <sql conditional="">UPDATE [Module] SET ModuleParagraph = blnFalse WHERE ModuleSystemName = 'MwMediaDatabaseEcom'</sql>
        <sql conditional="">UPDATE [Module] SET ModuleParagraph = blnFalse WHERE ModuleSystemName = 'MwMediaDatabaseViewer'</sql>
      </Module>
    </database>
    -->
  </package>

  <package version="289" date="27-10-2008" internalversion="18.16.0.0">
    <!-- Standard files -->
    <file name="Element.html" overwrite="false" target="Files/Templates/DealersearchStandard" source="Files/Templates/DealersearchBase" />
    <file name="ListElement.html" overwrite="false" target="Files/Templates/DealersearchStandard" source="Files/Templates/DealersearchBase" />
    <file name="List.html" overwrite="false" target="Files/Templates/DealersearchStandard" source="Files/Templates/DealersearchBase" />
    <file name="Search.html" overwrite="false" target="Files/Templates/DealersearchStandard" source="Files/Templates/DealersearchBase" />
    <file name="UserList.html" overwrite="false" target="Files/Templates/DealersearchStandard" source="Files/Templates/DealersearchBase" />
    <file name="UserListElement.html" overwrite="false" target="Files/Templates/DealersearchStandard" source="Files/Templates/DealersearchBase" />
    <file name="storelocator_frontend.swf" overwrite="false" target="Files/Templates/DealersearchStandard/flash" source="Files/Templates/DealersearchBase/flash" />
    <file name="storelocator_hover_template_silver.swf" overwrite="false" target="Files/Templates/DealersearchStandard/flash" source="Files/Templates/DealersearchBase/flash" />
    <file name="storelocator_info_template.swf" overwrite="false" target="Files/Templates/DealersearchStandard/flash" source="Files/Templates/DealersearchBase/flash" />
    <file name="storelocator_setdot.swf" overwrite="false" target="Files/Templates/DealersearchStandard/flash" source="Files/Templates/DealersearchBase/flash" />
    <file name="storelocator_setdotOK.swf" overwrite="false" target="Files/Templates/DealersearchStandard/flash" source="Files/Templates/DealersearchBase/flash" />
    <file name="vectorMap.swf" overwrite="false" target="Files/Templates/DealersearchStandard/flash" source="Files/Templates/DealersearchBase/flash" />
    <!-- Extranet files -->
    <file name="Element.html" overwrite="false" target="Files/Templates/DealersearchExtranet" source="Files/Templates/DealersearchBase" />
    <file name="ListElement.html" overwrite="false" target="Files/Templates/DealersearchExtranet" source="Files/Templates/DealersearchBase" />
    <file name="List.html" overwrite="false" target="Files/Templates/DealersearchExtranet" source="Files/Templates/DealersearchBase" />
    <file name="Search.html" overwrite="false" target="Files/Templates/DealersearchExtranet" source="Files/Templates/DealersearchBase" />
    <file name="UserList.html" overwrite="false" target="Files/Templates/DealersearchExtranet" source="Files/Templates/DealersearchBase" />
    <file name="UserListElement.html" overwrite="false" target="Files/Templates/DealersearchExtranet" source="Files/Templates/DealersearchBase" />
    <file name="storelocator_frontend.swf" overwrite="false" target="Files/Templates/DealersearchExtranet/flash" source="Files/Templates/DealersearchBase/flash" />
    <file name="storelocator_hover_template_silver.swf" overwrite="false" target="Files/Templates/DealersearchExtranet/flash" source="Files/Templates/DealersearchBase/flash" />
    <file name="storelocator_info_template.swf" overwrite="false" target="Files/Templates/DealersearchExtranet/flash" source="Files/Templates/DealersearchBase/flash" />
    <file name="storelocator_setdot.swf" overwrite="false" target="Files/Templates/DealersearchExtranet/flash" source="Files/Templates/DealersearchBase/flash" />
    <file name="storelocator_setdotOK.swf" overwrite="false" target="Files/Templates/DealersearchExtranet/flash" source="Files/Templates/DealersearchBase/flash" />
    <file name="vectorMap.swf" overwrite="false" target="Files/Templates/DealersearchExtranet/flash" source="Files/Templates/DealersearchBase/flash" />
    <!-- Database -->
    <!--<database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'DealersearchExtranet'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleScript, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleIsBeta) VALUES ('DealersearchExtranet', 'Dealersearch Extranet', '/Admin/Module/DealersearchExtranet/Global/CategoryList.aspx', blnFalse, blnFalse, blnTrue, blnTrue)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'DealersearchStandard'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleScript, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleIsBeta) VALUES ('DealersearchStandard', 'Dealersearch Standard', '/Admin/Module/DealersearchStandard/Global/CategoryList.aspx', blnFalse, blnFalse, blnTrue, blnTrue)</sql>
      </Module>
    </database>-->
    <!-- New tables -->
    <!--<file name="ExtendedDealerSearch.mdb" overwrite="false" target="Database" source="Database" />-->
    <database file="ExtendedDealersearch.mdb">
      <Module>
        <sql conditional="">
          CREATE TABLE [ExtendedDealerSearchAccessUsers]
          ([DealerSearchAccessUserID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
          [AccessUserID] INT NOT NULL,
          [DealerWebsite] NVARCHAR(255),
          [DealerImage] NVARCHAR(255),
          [DealerViewID] INT,
          [DealerTypeID] INT,
          [DealerActionRolloverID] INT,
          [DealerActionRolloverText] NVARCHAR(255),
          [DealerActionClickID] INT,
          [DealerActionClickFile] VARCHAR(255),
          [DealerActionClickTarget] VARCHAR(50),
          [DealerCoordinateX] VARCHAR(50),
          [DealerCoordinateY] VARCHAR(50),
          [DealerSearchDealerCustomUserFields] NTEXT NOT NULL)
        </sql>
        <sql conditional="">
          CREATE TABLE [ExtendedDealerSearchCategory]
          ([DealerSearchCategoryID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
          [DealerSearchCategoryName] NVARCHAR(255) NOT NULL,
          [DealerSearchCategoryHeight] INT,
          [DealerSearchCategoryWidth] INT,
          [DealerSearchCategoryImage] NVARCHAR(255),
          [DealerSearchCategoryMouseOverImage] NVARCHAR(255),
          [DealerSearchCategoryOnClickImage] NVARCHAR(255),
          [DealerSearchCategoryAccessUserID] INT)
        </sql>
        <sql conditional="">
          CREATE TABLE [ExtendedDealerSearchDealer]
          ([DealerSearchDealerID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
          [DealerSearchDealerCategoryID] INT,
          [DealerSearchDealerTypeID] INT,
          [DealerSearchDealerActionRolloverID] INT,
          [DealerSearchDealerActionRolloverText] NVARCHAR(255),
          [DealerSearchDealerViewName] INT,
          [DealerSearchDealerActionClickID] INT,
          [DealerSearchDealerActionClickFile] VARCHAR(255),
          [DealerSearchDealerActionClickTarget] VARCHAR(50),
          [DealerSearchDealerName] NVARCHAR(255) NOT NULL,
          [DealerSearchDealerAdress] NVARCHAR(255),
          [DealerSearchDealerAdress2] NVARCHAR(255),
          [DealerSearchDealerZip] VARCHAR(50),
          [DealerSearchDealerCity] NVARCHAR(255),
          [DealerSearchDealerCountry] NVARCHAR(255),
          [DealerSearchDealerPhone1] VARCHAR(50),
          [DealerSearchDealerPhone2] VARCHAR(50),
          [DealerSearchDealerFax1] VARCHAR(50),
          [DealerSearchDealerEmail] NVARCHAR(255),
          [DealerSearchDealerWebsite] NVARCHAR(255),
          [DealerSearchDealerCoordinateX] VARCHAR(50),
          [DealerSearchDealerCoordinateY] VARCHAR(50),
          [DealerSearchDealerActive] BIT NOT NULL,
          [DealerSearchDealerCustomUserFields] NTEXT,
          [DealerSearchDealerView] INT,
          [DealerSearchDealerImage] NVARCHAR(255))
        </sql>
        <sql conditional="">
          CREATE TABLE [ExtendedDealerSearchDealerType]
          ([DealerSearchDealerTypeID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
          [DealerSearchDealerTypeName] NVARCHAR(255),
          [DealerSearchDealerTypeDot] NVARCHAR(255),
          [DealerSearchDealerTypeDotRollover] NVARCHAR(255),
          [DealerSearchDealerTypeActionRollover] NVARCHAR(255),
          [DealerSearchDealerTypeActionRolloverText] VARCHAR(50),
          [DealerSearchDealerTypeActionClick] NVARCHAR(255),
          [DealerSearchDealerTypeActionClickFile] NVARCHAR(255))
        </sql>
        <sql conditional="">
          CREATE TABLE [ExtendedDealerSearchUserField]
          ([DealerSearchUserFieldID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
          [DealerSearchUserFieldSystemName] NVARCHAR(255) NOT NULL,
          [DealerSearchUserFieldSort] INT NOT NULL)
        </sql>
        <sql conditional="">
          CREATE TABLE [ExtendedDealersearchView]
          ([DealerSearchViewID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
          [DealerSearchViewName] NVARCHAR(255)  NOT NULL,
          [DealerSearchViewSort] NTEXT NOT NULL,
          [IsExtranet] BIT NOT NULL)
        </sql>
      </Module>
    </database>
  </package>
  <!-- END ExtendedDealerSearch -->


  <package version="288" date="09-10-2008" internalversion="18.16.0.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleLightMicro30Access = 1 WHERE ModuleSystemName = 'NewsV2'</sql>
      </Module>
    </database>
  </package>


  <package version="287" date="21-10-2008" internalversion="18.16.0.0">
    <database file="Forum.mdb">
      <ForumCategory>
        <sql conditional="">ALTER TABLE [ForumCategory] ADD [ForumCategoryAreaID] INT DEFAULT 0</sql>
      </ForumCategory>
    </database>
  </package>

  <package version="286" date="09-10-2008" internalversion="18.16.0.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">ALTER TABLE [Module] ADD [ModuleLightMicro15Access] INT DEFAULT 0</sql>
        <sql conditional="">ALTER TABLE [Module] ADD [ModuleLightMicro30Access] INT DEFAULT 0</sql>
        <sql conditional="">UPDATE [Module] SET ModuleLightMicro15Access = 1 WHERE ModuleSystemName IN ('Statisticsv2', 'Filearchive', 'eCards', 'Rotation', 'RSSFeed', 'Form')</sql>
        <sql conditional="">UPDATE [Module] SET ModuleLightMicro30Access = 1 WHERE ModuleSystemName IN ('Statisticsv2', 'Filearchive', 'eCards', 'Rotation', 'RSSFeed', 'Form', 'NewsV2')</sql>
      </Module>
    </database>
  </package>

  <package version="285" date="09-10-2008" internalversion="18.15.1.1">
    <!--
    <database file="sms.mdb">
      <Module>
        <sql conditional="">DELETE FROM [SMSCountriesDefault]</sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (45,'DK',blnTrue) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (46,'SE', blnFalse) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (47,'NO',blnFalse) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (31,'NL',blnFalse) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (34,'ES',blnFalse) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (351,'PT',blnFalse) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (44,'UK',blnFalse) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (30,'GR',blnFalse) </sql>
      </Module>
    </database>
    -->
  </package>

  <package version="284" date="08-10-2008" internalversion="18.15.1.1">
    <!--
    <database file="sms.mdb">
      <Module>
        <sql conditional="">CREATE TABLE [SMSCampaignHTTPParameters]([SMSCampaignHTTPParametersID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL, [SMSCampaignHTTPParametersCampaignID] INT NOT NULL, [SMSCampaignHTTPParametersText] NVARCHAR(255) NOT NULL, [SMSCampaignHTTPParametersActive] BIT NOT NULL)</sql>
        <sql conditional="">ALTER TABLE [SMSCampaignHTTPParameters] ADD FOREIGN KEY([SMSCampaignHTTPParametersCampaignID]) REFERENCES [SMSCampaign] ([SMSCampaignID]) ON DELETE CASCADE </sql>
        <sql conditional="">ALTER TABLE [SMSCampaign] ADD [SMSCampaignLinkURL] NVARCHAR(255) NULL </sql>
        <sql conditional="">ALTER TABLE [SMSCampaign] DROP [SMSCampaignForwardToHTTPOption1]</sql>
        <sql conditional="">ALTER TABLE [SMSCampaign] DROP [SMSCampaignForwardToHTTPOption2]</sql>
        <sql conditional="">ALTER TABLE [SMSCampaign] DROP [SMSCampaignForwardToHTTPOption3]</sql>
      </Module>
    </database>
    -->
  </package>

  <package version="283" date="16-09-2008" internalversion="18.15.1.1">
    <database file="Dynamic.mdb">
      <Page>
        <sql conditional="">ALTER TABLE [Page] DROP [Navigation_UseEcomGroups]</sql>
        <sql conditional="">ALTER TABLE [Page] DROP [NavigationParentType]</sql>
        <sql conditional="">ALTER TABLE [Page] DROP [NavigationGroupSelector]</sql>
        <sql conditional="">ALTER TABLE [Page] DROP [NavigationMaxLevels]</sql>
        <sql conditional="">ALTER TABLE [Page] DROP [NavigationProductPage]</sql>
        <sql conditional="">ALTER TABLE [Page] DROP [NavigationShopSelector]</sql>
        <sql conditional="">ALTER TABLE [Page] ADD [PageNavigation_UseEcomGroups] BIT NULL </sql>
        <sql conditional="">ALTER TABLE [Page] ADD [PageNavigationParentType] NVARCHAR(50) NULL </sql>
        <sql conditional="">ALTER TABLE [Page] ADD [PageNavigationGroupSelector] NVARCHAR(MAX) NULL </sql>
        <sql conditional="">ALTER TABLE [Page] ADD [PageNavigationMaxLevels] NVARCHAR(50) NULL </sql>
        <sql conditional="">ALTER TABLE [Page] ADD [PageNavigationProductPage] NVARCHAR(MAX) NULL </sql>
        <sql conditional="">ALTER TABLE [Page] ADD [PageNavigationShopSelector] NVARCHAR(MAX) NULL </sql>
      </Page>
    </database>
  </package>

  <package version="282" date="15-09-2008" internalversion="18.15.1.1">
    <database file="Dynamic.mdb">
      <Page>
        <sql conditional="">ALTER TABLE [Page] ADD [Navigation_UseEcomGroups] BIT NULL </sql>
        <sql conditional="">ALTER TABLE [Page] ADD [NavigationParentType] NVARCHAR(50) NULL </sql>
        <sql conditional="">ALTER TABLE [Page] ADD [NavigationGroupSelector] NVARCHAR(MAX) NULL </sql>
        <sql conditional="">ALTER TABLE [Page] ADD [NavigationMaxLevels] NVARCHAR(50) NULL </sql>
        <sql conditional="">ALTER TABLE [Page] ADD [NavigationProductPage] NVARCHAR(MAX) NULL </sql>
        <sql conditional="">ALTER TABLE [Page] ADD [NavigationShopSelector] NVARCHAR(MAX) NULL </sql>
      </Page>
    </database>
  </package>

  <package version="281" date="15-09-2008" internalversion="18.15.1.1">
    <!--
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'MwMediaDatabase'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleEcomNotInstalledAccess, ModuleHiddenMode, ModuleIsBeta, ModuleControlPanel) VALUES ('MwMediaDatabase', 'Mediadatabase', blnFalse, blnTrue, blnTrue, NULL, blnFalse, blnFalse, 'MwMediaDatabase_cpl.aspx')</sql>
      </Module>
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'MwFlashPlugin'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleEcomNotInstalledAccess, ModuleHiddenMode, ModuleIsBeta, ModuleControlPanel) VALUES ('MwFlashPlugin', 'Flash Plugin', blnFalse, blnTrue, blnFalse, NULL, blnFalse, blnFalse, 'MwFlashPlugin_cpl.aspx')</sql>
      </Module>
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'MwMediaDatabaseEcom'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleEcomNotInstalledAccess, ModuleHiddenMode, ModuleIsBeta) VALUES ('MwMediaDatabaseEcom', 'Mediadatabase eCommerce integration', blnFalse, blnTrue, blnFalse, NULL, blnFalse, blnFalse)</sql>
      </Module>
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'MwMediaDatabaseViewer'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleEcomNotInstalledAccess, ModuleHiddenMode, ModuleIsBeta) VALUES ('MwMediaDatabaseViewer', 'Mediadatabase Viewer', blnFalse, blnTrue, blnFalse, NULL, blnFalse, blnFalse)</sql>
      </Module>
    </database>
    <file name="MwJsScripts.js" overwrite="false" target="Files" source="Files" />
    <file name="Element.html" overwrite="false" target="Files/Templates/MwMediaDatabase" source="Files/Templates/MwMediaDatabase" />
    <file name="Element_FlashViewer.html" overwrite="false" target="Files/Templates/MwMediaDatabase" source="Files/Templates/MwMediaDatabase" />
    <file name="Element_Raw.html" overwrite="false" target="Files/Templates/MwMediaDatabase" source="Files/Templates/MwMediaDatabase" />
    <file name="List.html" overwrite="false" target="Files/Templates/MwMediaDatabase" source="Files/Templates/MwMediaDatabase" />
    <file name="List_Detailed.html" overwrite="false" target="Files/Templates/MwMediaDatabase" source="Files/Templates/MwMediaDatabase" />
    <file name="List_Slideshow.html" overwrite="false" target="Files/Templates/MwMediaDatabase" source="Files/Templates/MwMediaDatabase" />
    <file name="Search.html" overwrite="false" target="Files/Templates/MwMediaDatabase" source="Files/Templates/MwMediaDatabase" />
    <file name="FlashViewer_Error.swf" overwrite="false" target="Files/Templates/MwMediaDatabase/swf" source="Files/Templates/MwMediaDatabase/swf" />
    <file name="Mw.css" overwrite="false" target="Files/Templates/MwMediaDatabase/css" source="Files/Templates/MwMediaDatabase/css" />
    <file name="MW_loading.gif" overwrite="false" target="Files/Templates/MwMediaDatabase/Images" source="Files/Templates/MwMediaDatabase/Images" />
    <file name="tap_background.gif" overwrite="false" target="Files/Templates/MwMediaDatabase/Images" source="Files/Templates/MwMediaDatabase/Images" />
    <file name="tap_left.gif" overwrite="false" target="Files/Templates/MwMediaDatabase/Images" source="Files/Templates/MwMediaDatabase/Images" />
    <file name="tap_right.gif" overwrite="false" target="Files/Templates/MwMediaDatabase/Images" source="Files/Templates/MwMediaDatabase/Images" />
    <file name="MmdFolder.js" overwrite="false" target="Files/Templates/MwMediaDatabase/js" source="Files/Templates/MwMediaDatabase/js" />
    <file name="MwSlideShow.js" overwrite="false" target="Files/Templates/MwMediaDatabase/js" source="Files/Templates/MwMediaDatabase/js" />
    -->
  </package>

  <package version="280" date="08-09-2008" internalversion="18.15.1.1">
    <file name="MasterList.html" overwrite="false" target="Files/Templates/DBPub/Base" source="Files/Templates/DBPub/Base" />
  </package>

  <package version="279" date="01-09-2008" internalversion="18.15.1.1">
    <database file="Access.mdb">
      <NewsLetterV3Link>
        <sql conditional="">ALTER TABLE [NewsLetterV3Link] ALTER COLUMN [LinkURL] varchar(4000)</sql>
      </NewsLetterV3Link>
    </database>
  </package>

  <package version="278" date="22-07-2008" internalversion="18.15.1.1">
    <database file="Survey.mdb">
      <SMS>
        <sql conditional="">DROP TRIGGER [T_SurveyResult_ITrig]</sql>
        <sql conditional="">DROP TRIGGER [T_SurveyResult_UTrig]</sql>
      </SMS>
    </database>
  </package>


  <package version="277" date="22-07-2008" internalversion="18.15.1.1">
    <file name="EventTemplate.html" target="Files/Templates/Calendar/Mail" source="Files/Templates/Calendar/Mail" overwrite="false" />
  </package>

  <package version="276" date="17-07-2008" internalversion="18.15.1.1">
    <database file="Statisticsv2.mdb">
      <NotFoundReports>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID] = 65">INSERT INTO [Statv2Report] (Statv2ReportID, Statv2ReportType, Statv2ReportName) VALUES (65, 2, 'Not found - Pages')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID] = 66">INSERT INTO [Statv2Report] (Statv2ReportID, Statv2ReportType, Statv2ReportName) VALUES (66, 2, 'Not found - Documents')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID] = 67">INSERT INTO [Statv2Report] (Statv2ReportID, Statv2ReportType, Statv2ReportName) VALUES (67, 2, 'Not found - Others')</sql>
      </NotFoundReports>
    </database>
  </package>

  <package version="275" date="14-07-2008" internalversion="18.15.1.1">
    <!--
    <database file="Weblog.mdb">
      <WeblogArticle>
        <sql conditional="">ALTER TABLE [WeblogArticle] ALTER COLUMN [WeblogArticleHeadline] nvarchar(250) not null</sql>
        <sql conditional="">ALTER TABLE [WeblogArticle] ALTER COLUMN [WeblogArticleDescription] ntext null</sql>
      </WeblogArticle>
      <WeblogBlog>
        <sql conditional="">ALTER TABLE [WeblogBlog] ALTER COLUMN [WeblogBlogName] nvarchar(250) not null</sql>
      </WeblogBlog>
    </database>
    -->
  </package>


  <package version="274" date="14-07-2008" internalversion="18.15.0.0">

  </package>

  <package version="273" date="03-07-2008" internalversion="18.15.0.0">
    <file name="DefaultList.html" target="Files/Templates/StatisticsExtended" source="Files/Templates/StatisticsExtended" overwrite="false" />
  </package>

  <package version="272" date="02-07-2008" internalversion="18.15.0.0">
    <!--<file name="Extranet_CanEdit_View.html" target="Files/Templates/ExtranetExtended" source="Files/Templates/ExtranetExtended" overwrite="false" />-->
    <database file="dynamic.mdb">
      <!--
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleScript = '../access/access_users.aspx' WHERE ModuleSystemName ='ExtranetExtended'</sql>
      </Module>
      -->
      <Page>
        <sql conditional="">ALTER TABLE [Page] ALTER COLUMN [PageNeedTranslation] BIT NULL</sql>
      </Page>
    </database>
  </package>

  <package version="271" date="30-06-2008" internalversion="18.15.0.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleIsBeta = blnFalse WHERE ModuleSystemName IN('Sms', 'UrlPath')</sql>
      </Module>
    </database>
  </package>



  <package version="270" date="24-06-2008" internalversion="18.14.1.0">
    <!--
    <database file="sms.mdb">
      <SMSCountriesDefault>
        <sql conditional="">UPDATE [SMSCountriesDefault] SET [CountryDefault] = 'false' WHERE [CountryCode] &lt;&gt; 45</sql>
      </SMSCountriesDefault>
    </database>
    -->
  </package>



  <package version="269" date="23-06-2008" internalversion="18.14.1.0">
    <!--
    <database file="sms.mdb">
      <SMSSetting>
        <sql conditional="">ALTER TABLE [SMSSetting] ADD [SMSSettingSMSGatewayEncoding] NVARCHAR(250) NULL </sql>
      </SMSSetting>
    </database>
    -->
  </package>

  <package version="268" date="23-06-2008" internalversion="18.14.1.0">
    <!--
    <database file="sms.mdb">
      <SMSCountriesDefault>
        <sql conditional="SELECT * FROM [SMSCountriesDefault] WHERE [CountryCode] = 45">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (45,'Denmark',blnTrue)</sql>
        <sql conditional="SELECT * FROM [SMSCountriesDefault] WHERE [CountryCode] = 49">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (49,'Germany',blnTrue) </sql>
        <sql conditional="SELECT * FROM [SMSCountriesDefault] WHERE [CountryCode] = 30">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (30,'Greece',blnTrue) </sql>
        <sql conditional="SELECT * FROM [SMSCountriesDefault] WHERE [CountryCode] = 354">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (354,'Iceland',blnTrue) </sql>
        <sql conditional="SELECT * FROM [SMSCountriesDefault] WHERE [CountryCode] = 81">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (81,	'Japan',blnTrue) </sql>
        <sql conditional="SELECT * FROM [SMSCountriesDefault] WHERE [CountryCode] = 31">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (31,'Netherlands',blnTrue) </sql>
        <sql conditional="SELECT * FROM [SMSCountriesDefault] WHERE [CountryCode] = 47">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (47,'Norway',blnTrue) </sql>
        <sql conditional="SELECT * FROM [SMSCountriesDefault] WHERE [CountryCode] = 351">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (351,'Portugal',blnTrue) </sql>
        <sql conditional="SELECT * FROM [SMSCountriesDefault] WHERE [CountryCode] = 7">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (7,'Russia',blnTrue) </sql>
        <sql conditional="SELECT * FROM [SMSCountriesDefault] WHERE [CountryCode] = 34">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (34,'Spain',blnTrue) </sql>
        <sql conditional="SELECT * FROM [SMSCountriesDefault] WHERE [CountryCode] = 46">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (46,'Sweden',blnTrue) </sql>
        <sql conditional="SELECT * FROM [SMSCountriesDefault] WHERE [CountryCode] = 34">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (34,'United Kingdom',blnTrue) </sql>
      </SMSCountriesDefault>
    </database>
    -->
  </package>

  <package version="267" date="19-06-2008" internalversion="18.14.1.0">
    <!--<file name="ListThread.html" target="Files/Templates/ForumV2/Thread" source="Files/Templates/ForumV2/Thread" overwrite="false" />-->
  </package>

  <package version="266" date="19-06-2008" internalversion="18.14.1.0">
    <!--
    <file name="Forumv2Editor.html" target="Files/Templates/ForumV2/ForumV2Editor" source="Files/Templates/ForumV2/ForumV2Editor" overwrite="false" />
    <file name="Forumv2EditorSimple.html" target="Files/Templates/ForumV2/ForumV2Editor" source="Files/Templates/ForumV2/ForumV2Editor" overwrite="false" />
    -->
  </package>

  <package version="265" date="18-06-2008" internalversion="18.14.1.0">
    <database file="Access.mdb">
      <NewsletterV3Newsletter>
        <sql conditional="">ALTER TABLE [NewsletterV3Newsletter] ADD [NewsletterPageDoctype] nvarchar(255) NULL</sql>
        <sql conditional="">ALTER TABLE [NewsletterV3Newsletter] ADD [NewsletterPageInlineStyle] MEMO NULL</sql>
      </NewsletterV3Newsletter>
    </database>
  </package>

  <package version="264" date="11-06-2008" internalversion="18.14.1.0">
    <file name="Subscribe.html" target="Files/Templates/NewsLetterV3/Edit" source="Files/Templates/NewsLetterV3/Edit" overwrite="false" />
    <file name="UnSubscribe.html" target="Files/Templates/NewsLetterV3/Edit" source="Files/Templates/NewsLetterV3/Edit" overwrite="false" />
  </package>

  <package version="263" date="09-06-2008" internalversion="18.14.1.0">
    <database file="Statisticsv2.mdb">
      <TemplateStylesheetUsage>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID] = 61">INSERT INTO [Statv2Report] (Statv2ReportID, Statv2ReportType, Statv2ReportName) VALUES (61, 1, 'Stylesheets - Default')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID] = 62">INSERT INTO [Statv2Report] (Statv2ReportID, Statv2ReportType, Statv2ReportName) VALUES (62, 1, 'Templates - Page')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID] = 63">INSERT INTO [Statv2Report] (Statv2ReportID, Statv2ReportType, Statv2ReportName) VALUES (63, 1, 'Templates - Paragraph')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID] = 64">INSERT INTO [Statv2Report] (Statv2ReportID, Statv2ReportType, Statv2ReportName) VALUES (64, 1, 'Templates - News')</sql>
      </TemplateStylesheetUsage>
    </database>
  </package>

  <package version="262" date="05-06-2008" internalversion="18.14.1.0">
    <!--
    <database file="sms.mdb">
      <SMS>
        <sql conditional="">ALTER TABLE [SMSSetting] ADD [SMSSettingSMSemailSender] NVARCHAR(250) NULL</sql>
      </SMS>
    </database>
    -->
  </package>


  <package version="261" date="04-06-2008" internalversion="18.14.1.0">
    <!--
    <database file="sms.mdb">
      <SMS>
        <sql conditional="">ALTER TABLE [SMSCountries] ADD [CountryDefault] BIT NULL</sql>
        <sql conditional="">CREATE TABLE [SMSCountriesDefault] ([CountryID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL, [CountryCode] SMALLINT NULL, [CountryName] NVARCHAR(250) NULL, [CountryDefault] BIT NULL)</sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (46,'Denmark',blnTrue) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (298,'Faroe Islands', blnTrue) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (49,'Germany',blnTrue) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (30,'Greece',blnTrue) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (354,'Iceland',blnTrue) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (81,	'Japan',blnTrue) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (31,'Netherlands',blnTrue) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (47,'Norway',blnTrue) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (351,'Portugal',blnTrue) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (7,'Russia',blnTrue) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (34,'Spain',blnTrue) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (46,'Sweden',blnTrue) </sql>
        <sql conditional="">INSERT INTO [SMSCountriesDefault] ([CountryCode] ,[CountryName] ,[CountryDefault])  VALUES (34,'United Kingdom',blnTrue) </sql>
      </SMS>
    </database>
    -->
  </package>



  <package version="260" date="02-06-2008" internalversion="18.14.1.0">
    <database file="Dynamic.mdb">
      <Template>
        <sql conditional="">ALTER TABLE [TemplateCategory] ADD [TemplateCategorySort] INT NULL</sql>
        <sql conditional="">UPDATE [TemplateCategory] SET [TemplateCategorySort] = 1 WHERE [TemplateCategoryName]='Side'</sql>
        <sql conditional="">UPDATE [TemplateCategory] SET [TemplateCategorySort] = 2 WHERE [TemplateCategoryName]='Afsnit'</sql>
        <sql conditional="">UPDATE [TemplateCategory] SET [TemplateCategorySort] = 3 WHERE [TemplateCategoryName]='Nyheder'</sql>
        <sql conditional="">UPDATE [TemplateCategory] SET [TemplateCategorySort] = 4 WHERE [TemplateCategoryName]='NewsV2'</sql>
        <sql conditional="">UPDATE [TemplateCategory] SET [TemplateCategorySort] = 5 WHERE [TemplateCategoryName]='Nyhedsbreve'</sql>
      </Template>
    </database>
  </package>

  <package version="259" date="02-06-2008" internalversion="18.14.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <Transaction>
		  <sql conditional="select pageid from page where Pageid=0">ALTER TABLE Page ALTER COLUMN PagePermission MAXCHAR</sql>
        </Transaction>
      </Module>
    </database>
  </package>

  <package version="258" date="16-05-2008" internalversion="18.14.1.0">
    <!--
    <database file="sms.mdb">
      <SMS>
        <sql conditional="">ALTER TABLE [SMSCountries] ADD [CountryName] nvarchar(250) NULL</sql>
      </SMS>
    </database>
    -->
  </package>

  <package version="257" date="30-04-2008" internalversion="18.14.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">CREATE INDEX NewsCategory_IDX001 ON NewsCategory (NewsCategoryAccess)</sql>
      </Module>
    </database>
  </package>

  <package version="256" date="04-04-2008" internalversion="18.14.1.0">
    <database file="dynamic.mdb">
      <Page>
        <sql conditional="">ALTER TABLE [Page] ADD [PageNeedTranslation] BIT NOT NULL DEFAULT 0</sql>
      </Page>
    </database>
  </package>

  <package version="255" date="29-03-2008" internalversion="18.14.1.0">
    <!--
    <file name="EditProfile.html" target="Files/Templates/ForumV2/Other" source="Files/Templates/ForumV2/Other" overwrite="false" />
    <file name="Login.html" target="Files/Templates/ForumV2/Other" source="Files/Templates/ForumV2/Other" overwrite="false" />
    <file name="ForgotPassword.html" target="Files/Templates/ForumV2/Other" source="Files/Templates/ForumV2/Other" overwrite="false" />
    <file name="ForgotPasswordEmail.html" target="Files/Templates/ForumV2/Other" source="Files/Templates/ForumV2/Other" overwrite="false" />
    -->
  </package>

  <package version="254" date="28-03-2008" internalversion="18.14.1.0">
    <database file="Access.mdb">
      <NewsLetterV3InsertSettings>
        <sql conditional="SELECT * FROM [NewsLetterV3Settings] WHERE [SettingsName]='DBFields'">INSERT INTO [NewsLetterV3Settings](SettingsName, SettingsValue) VALUES('DBFields', '')</sql>
      </NewsLetterV3InsertSettings>
    </database>
  </package>

  <package version="253" date="28-03-2008" internalversion="18.14.1.0">
    <file name="NewsletterRecipientEdit.html" target="Files/Templates/NewsLetterV3/Edit" source="Files/Templates/NewsLetterV3/Edit" overwrite="false" />
    <!--<file name="Profile.html" target="Files/Templates/ExtranetExtended" source="Files/Templates/ExtranetExtended" overwrite="false" />
    <file name="EditProfile.html" target="Files/Templates/Weblog/Authorized" source="Files/Templates/Weblog/Authorized" overwrite="false" />
    <file name="MasterEdit.html" target="Files/Templates/Employee/FrontendEdit" source="Files/Templates/Employee/FrontendEdit" overwrite="false" />
    <file name="ValidationEmail.html" target="Files/Templates/Employee/FrontendEdit" source="Files/Templates/Employee/FrontendEdit" overwrite="false" />-->
  </package>
  <package version="252" date="26-03-2008" internalversion="18.14.1.0">
    <!--<file name="ListPost.html" target="Files/Templates/ForumV2/Post" source="Files/Templates/ForumV2/Post" overwrite="false" />-->
  </package>

  <package version="251" date="19-03-2008" internalversion="18.14.1.0">
    <!--<file name="ListThread.html" target="Files/Templates/ForumV2/Thread" source="Files/Templates/ForumV2/Thread" overwrite="false" />-->
  </package>
  <package version="250" date="13-03-2008" internalversion="18.14.1.0">
    <!--
    <file name="EditThread.html" target="Files/Templates/ForumV2/Thread" source="Files/Templates/ForumV2/Thread" overwrite="false" />
    <file name="EditPost.html" target="Files/Templates/ForumV2/Post" source="Files/Templates/ForumV2/Post" overwrite="false" />
    -->
  </package>
  <package version="249" date="12-03-2008" internalversion="18.14.1.0">
    <!--
    <file name="UploadFile.html" target="Files/Templates/ForumV2/Other" source="Files/Templates/ForumV2/Other" overwrite="false" />
    <file name="ListFiles.html" target="Files/Templates/ForumV2/Other" source="Files/Templates/ForumV2/Other" overwrite="false" />
    <file name="EditPost.html" target="Files/Templates/ForumV2/Post" source="Files/Templates/ForumV2/Post" overwrite="false" />
    <file name="ListPost.html" target="Files/Templates/ForumV2/Post" source="Files/Templates/ForumV2/Post" overwrite="false" />
    <file name="EditThread.html" target="Files/Templates/ForumV2/Thread" source="Files/Templates/ForumV2/Thread" overwrite="false" />
    <database file="forumv2.mdb">
      <Module>
        <sql conditional="">CREATE TABLE [ForumV2File] (ForumV2FileID IDENTITY PRIMARY KEY NOT NULL, ForumV2FileThreadID INT NOT NULL, ForumV2FilePostID INT NOT NULL, ForumV2FileLink VARCHAR(255) NOT NULL, ForumV2FileName VARCHAR(255) NOT NULL)</sql>
        <sql conditional="">ALTER TABLE [ForumV2Settings] ADD [ForumV2SettingsUploadDirectory] VARCHAR(255) NULL</sql>
      </Module>
    </database>
    -->
  </package>
  <package version="248" date="04-03-2008" internalversion="18.14.1.0">
    <database file="access.mdb">
      <Module>
        <sql conditional="">ALTER TABLE [AccessCustomFieldValue] ADD [AccessCustomFieldValueSort] INT NULL</sql>
        <sql conditional="">ALTER TABLE [AccessCustomFieldValue] ADD [AccessCustomFieldValueActive] BIT NOT NULL DEFAULT 1</sql>
        <sql conditional="">ALTER TABLE [AccessCustomFieldValue] ADD [AccessCustomFieldValueDropdownDefault] BIT NOT NULL DEFAULT 0</sql>
      </Module>
    </database>
  </package>

  <package version="247" date="02-06-2008" internalversion="18.14.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <Transaction>
		  <sql conditional="select pageid from page where Pageid=0">ALTER TABLE Page ALTER COLUMN PagePermission MAXCHAR</sql>
        </Transaction>
      </Module>
    </database>
  </package>

  <package version="246" date="29-05-2008" internalversion="18.14.1.0">
    <database file="Dynamic.mdb">
      <Template>
        <sql conditional="">ALTER TABLE [TemplateCategory] ADD [TemplateCategorySort] INT NULL</sql>
        <sql conditional="">UPDATE [TemplateCategory] SET [TemplateCategorySort] = 1 WHERE [TemplateCategoryName]='Side'</sql>
        <sql conditional="">UPDATE [TemplateCategory] SET [TemplateCategorySort] = 2 WHERE [TemplateCategoryName]='Afsnit'</sql>
        <sql conditional="">UPDATE [TemplateCategory] SET [TemplateCategorySort] = 3 WHERE [TemplateCategoryName]='Nyheder'</sql>
        <sql conditional="">UPDATE [TemplateCategory] SET [TemplateCategorySort] = 4 WHERE [TemplateCategoryName]='NewsV2'</sql>
        <sql conditional="">UPDATE [TemplateCategory] SET [TemplateCategorySort] = 5 WHERE [TemplateCategoryName]='Nyhedsbreve'</sql>
      </Template>
    </database>
  </package>

  <package version="245" date="30-04-2008" internalversion="18.14.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">CREATE INDEX NewsCategory_IDX001 ON NewsCategory (NewsCategoryAccess)</sql>
      </Module>
    </database>
  </package>

  <package version="244" date="08-04-2008" internalversion="18.14.1.0">
    <database file="Dynamic.mdb">
      <Page>
        <sql conditional="">ALTER TABLE Page ADD PageTopLogoImageAlt VARCHAR(255)</sql>
      </Page>
    </database>
  </package>

  <package version="243" date="03-04-2008" internalversion="18.14.1.0">
    <!--
    <file name="ListThread.html" target="Files/Templates/ForumV2/Thread" source="Files/Templates/ForumV2/Thread" overwrite="false" />
    <file name="EditThread.html" target="Files/Templates/ForumV2/Thread" source="Files/Templates/ForumV2/Thread" overwrite="false" />
    <file name="EditPost.html" target="Files/Templates/ForumV2/Post" source="Files/Templates/ForumV2/Post" overwrite="false" />
    -->
  </package>

  <package version="242" date="06-03-2008" internalversion="18.13.1.0">
    <file name="Dwdd.css" target="Files/Templates/Navigation" source="Files/Templates/Navigation" overwrite="false" />
    <file name="Dwdd.js" target="Files/Templates/Navigation" source="Files/Templates/Navigation" overwrite="false" />
    <file name="Dwdd.gif" target="Files/Templates/Navigation" source="Files/Templates/Navigation" overwrite="false" />
    <file name="DwddDropdown.xslt" target="Files/Templates/Navigation" source="Files/Templates/Navigation" overwrite="false" />
  </package>

  <package version="241" date="21-02-2008" internalversion="18.14.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'ControlLoader'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleEcomNotInstalledAccess, ModuleHiddenMode, ModuleIsBeta) VALUES ('ControlLoader', 'Insert .ascx control', 0, 1, 1, NULL, 0, 0)</sql>
      </Module>
    </database>
  </package>

  <package version="240" date="21-02-2008" internalversion="18.14.1.0">
    <!--
    <file name="Sms.mdb" target="Database" source="Database" />
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleAccess = 0 WHERE ModuleSystemName='Sms'</sql>
      </Module>
    </database>
    -->
  </package>

  <package version="239" date="20-02-2008" internalversion="18.13.1.0">
    <folder source="Files/Templates/NewsV2/List" target="Files/Templates/NewsV2" />
    <folder source="Files/Templates/NewsV2/Item" target="Files/Templates/NewsV2" />
    <folder source="Files/Templates/NewsV2/Edit" target="Files/Templates/NewsV2" />
    <database file="Dynamic.mdb">
      <templates>
        <sql conditional="">
          UPDATE [TemplateCategory] SET [TemplateCatgeoryDirectory] = 'NewsV2/Item' WHERE [TemplateCategoryName]='NewsV2'
        </sql>
      </templates>
    </database>
  </package>

  <package version="238" date="19-02-2008" internalversion="18.14.1.0">
    <file name="ArchiveList.html" target="Files/Templates/NewsLetterV3/Archive" source="Files/Templates/NewsLetterV3/Archive" overwrite="false" />
    <file name="ArchiveDetailsList.html" target="Files/Templates/NewsLetterV3/Archive" source="Files/Templates/NewsLetterV3/Archive" overwrite="false" />
    <file name="NewsletterRecipientEdit.html" target="Files/Templates/NewsLetterV3/Edit" source="Files/Templates/NewsLetterV3/Edit" overwrite="false" />
    <file name="NewsletterRecipientEditQuick.html" target="Files/Templates/NewsLetterV3/Edit" source="Files/Templates/NewsLetterV3/Edit" overwrite="false" />
    <file name="NewsLetterRecipientUnSubscribe.html" target="Files/Templates/NewsLetterV3/Edit" source="Files/Templates/NewsLetterV3/Edit" overwrite="false" />
    <file name="NewsList.html" target="Files/Templates/NewsLetterV3/Integration" source="Files/Templates/NewsLetterv3/Integration" overwrite="false" />
    <file name="NewsLetterLogin.html" target="Files/Templates/NewsLetterV3/Login" source="Files/Templates/NewsLetterv3/Login" overwrite="false" />
    <file name="NewsLetterForgotPassword.html" target="Files/Templates/NewsLetterV3/Login" source="Files/Templates/NewsLetterv3/Login" overwrite="false" />
    <file name="AdminNotificationMail.html" target="Files/Templates/NewsLetterV3/Mail" source="Files/Templates/NewsLetterv3/Mail" overwrite="false" />
    <file name="ConfirmationMail.html" target="Files/Templates/NewsLetterV3/Mail" source="Files/Templates/NewsLetterV3/Mail" overwrite="false" />
  </package>

  <package version="234" date="01-11-2007" internalversion="18.14.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">DELETE FROM [Module] WHERE [ModuleSystemName] = 'RemoteHttp'</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'RemoteHttp'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleEcomNotInstalledAccess, ModuleHiddenMode, ModuleIsBeta) VALUES ('RemoteHttp', 'Content integrator', 0, 1, 1, NULL, 0, 1)</sql>
      </Module>
    </database>
  </package>

  <package version="233" date="13-02-2008" internalversion="18.14.1.0">
    <!--<file name="Profile.html" overwrite="false" target="Files/Templates/ExtranetExtended" source="Files/Templates/ExtranetExtended" />-->
  </package>

  <package version="232" date="12-02-2008" internalversion="18.14.1.0">
    <database file="Dynamic.mdb">
      <css_element>
        <sql conditional="SELECT * FROM [Template] WHERE [TemplateName]='css_element' AND [TemplateCategoryID]=(SELECT [TemplateCategoryID] FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2')">
          INSERT INTO [template] ([TemplateCategoryID],[TemplateName],[TemplateFile],[TemplateIcon],[TemplateIsProtected],[TemplateIsDefault],[TemplateTypeID],[TemplatePutInTable],[TemplateSettings],[TemplateImageColumns],[TemplateImageWidth],[TemplateDescription],[TemplateActive],[TemplateSort],[TemplateAutoResize],[TemplateImageHeight])
          SELECT [TemplateCategoryID], 'css_element','css_element.html','default.gif',1,0,0,'True',NULL,0,0,NULL,1,NULL,0,NULL FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'
        </sql>
      </css_element>
    </database>
  </package>

  <package version="227" date="01-02-2008" internalversion="18.14.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleIsBeta = blnFalse WHERE ModuleSystemName IN('NewsV2', 'eCom_CustomerCareCenter', 'NewsLetterV3')</sql>
      </Module>
    </database>
  </package>

  <package version="226" date="01-02-2008" internalversion="18.13.1.0">
    <file name="newsv2.css" target="Files/Templates/NewsV2" source="Files/Templates/NewsV2" />
    <file name="newsfunctions.js" target="Files/Templates/NewsV2" source="Files/Templates/NewsV2" />
  </package>

  <package version="223" date="18-01-2008" internalversion="18.13.1.0">
    <database file="Access.mdb">
      <NewsletterUnsubscribeRedirectLink>
        <sql conditional="SELECT * FROM [NewsLetterV3NewsLetter] WHERE [NewsletterUnsubscribeRedirectLink] IS NULL OR [NewsletterUnsubscribeRedirectLink] IS NOT NULL">ALTER TABLE [NewsLetterV3NewsLetter] ADD NewsletterUnsubscribeRedirectLink MEMO NULL </sql>
      </NewsletterUnsubscribeRedirectLink>
    </database>
  </package>

  <package version="221" date="14-01-2008" internalversion="18.13.1.0">
    <database file="dynamic.mdb">
      <Module>
        <sql conditional="">ALTER TABLE [Trashbin] ADD [TrashbinMasterID] INT NULL</sql>
      </Module>
    </database>
  </package>

  <package version="220" date="14-01-2008" internalversion="18.13.1.0">
    <!--
    <database file="sms.mdb">
      <Module>
        <sql conditional="">alter table SMSSetting drop SMSSettingSMSgatewayUserID</sql>
        <sql conditional="">alter table SMSSetting drop SMSSettingSMSgatewayKeyword</sql>
      </Module>
    </database>
    -->
  </package>

  <package version="219" date="11-01-2008" internalversion="18.13.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql>UPDATE [Module] SET [ModuleControlPanel] = 'NewsV2_cpl.aspx' WHERE [ModuleSystemName] = 'NewsV2'</sql>
      </Module>
    </database>
  </package>

  <package version="217" date="21-12-2007" internalversion="18.13.1.0">
    <!--
    <file name="Sms.mdb" target="Database" source="Database" />
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Sms'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleScript, ModuleControlPanel, ModuleIsBeta) VALUES ('Sms', 'Sms center', 0, 0, 0, '/Admin/Module/Sms/Default.aspx', 'Sms_cpl.aspx', 1)</sql>
      </Module>
    </database>
    <database file="sms.mdb">
      <Module>
        <sql conditional="">CREATE TABLE SMSCampaignType(SMSCampaignTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,SMSCampaignTypeName NVARCHAR(255) NULL,SMSCampaignTypeDescription ntext NULL,SMSCampaignTypeExtendedOnly BIT NOT NULL)</sql>
        <sql conditional="SELECT * FROM [SMSCampaignType] WHERE [SMSCampaignTypeName] = 'Competition'">INSERT INTO SMSCampaignType(SMSCampaignTypeName, SMSCampaignTypeDescription, SMSCampaignTypeExtendedOnly) VALUES('Competition', NULL, 0)</sql>
        <sql conditional="SELECT * FROM [SMSCampaignType] WHERE [SMSCampaignTypeName] = 'Poll'">INSERT INTO SMSCampaignType(SMSCampaignTypeName, SMSCampaignTypeDescription, SMSCampaignTypeExtendedOnly) VALUES('Poll', NULL, 0)</sql>
        <sql conditional="SELECT * FROM [SMSCampaignType] WHERE [SMSCampaignTypeName] = 'HTTP-Request'">INSERT INTO SMSCampaignType(SMSCampaignTypeName, SMSCampaignTypeDescription, SMSCampaignTypeExtendedOnly) VALUES('HTTP-Request', NULL, 1)</sql>
        <sql conditional="">CREATE TABLE SMSKeyword(SMSKeywordID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, SMSKeywordName NVARCHAR(255) NULL, SMSKeywordChannel NVARCHAR(255) NULL, SMSKeywordDescription ntext NULL, SMSKeywordCreated datetime NULL, SMSKeywordCountry NVARCHAR(255) NULL)</sql>
        <sql conditional="">CREATE TABLE SMSCampaignGroup(SMSCampaignGroupID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, SMSCampaignGroupName NVARCHAR(255) NULL, SMSCampaignGroupDescription ntext NULL, SMSCampaignGroupCreated datetime NULL)</sql>
        <sql conditional="">CREATE TABLE SMSCampaign(SMSCampaignID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,SMSCampaignGroupID INT NULL,SMSKeywordID INT NULL,SMSCampaignOrderCode NVARCHAR(255) NULL,SMSCampaignReturnSMSheader NVARCHAR(255) NULL,SMSCampaignReturnSMStext ntext NULL,SMSCampaignAddToSMSRecipientListID INT NULL,SMSCampaignCreated datetime NULL,SMSCampaignForwardToEmail BIT NOT NULL,SMSCampaignForwardToEmailAddress NVARCHAR(255) NULL,SMSCampaignForwardToHTTP BIT NOT NULL,SMSCampaignForwardToHTTPUrl NVARCHAR(255) NULL,SMSCampaignForwardToHTTPOption1 ntext NULL,SMSCampaignForwardToHTTPOption2 ntext NULL,SMSCampaignForwardToHTTPOption3 ntext NULL,SMSCampaignPrice decimal NULL,SMSCampaignDonation BIT NOT NULL)</sql>
        <sql conditional="">ALTER TABLE [SMSCampaign] ADD FOREIGN KEY([SMSCampaignGroupID]) REFERENCES [SMSCampaignGroup] ([SMSCampaignGroupID])</sql>
        <sql conditional="">ALTER TABLE [SMSCampaign] ADD FOREIGN KEY([SMSKeywordID]) REFERENCES [SMSKeyword] ([SMSKeywordID])</sql>
        <sql conditional="">CREATE TABLE SMSOrder(SMSOrderID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, SMSCampaignID INT NULL, SMSOrderText NTEXT NULL, SMSOrderMobile NVARCHAR(255) NULL, SMSOrderCreated datetime NULL)</sql>
        <sql conditional="">ALTER TABLE [SMSOrder] ADD FOREIGN KEY([SMSCampaignID]) REFERENCES [SMSCampaign] ([SMSCampaignID])</sql>
        <sql conditional="">CREATE TABLE SMSCountries(CountryID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, CountryCode SMALLINT NULL)</sql>
        <sql conditional="select * from SMSCountries where CountryCode=45">INSERT INTO SMSCountries(CountryCode) values(45)</sql>
        <sql conditional="select * from SMSCountries where CountryCode=46">INSERT INTO SMSCountries(CountryCode) values(46)</sql>
        <sql conditional="select * from SMSCountries where CountryCode=47">INSERT INTO SMSCountries(CountryCode) values(47)</sql>
        <sql conditional="select * from SMSCountries where CountryCode=31">INSERT INTO SMSCountries(CountryCode) values(31)</sql>
        <sql conditional="select * from SMSCountries where CountryCode=351">INSERT INTO SMSCountries(CountryCode) values(351)</sql>
        <sql conditional="">CREATE TABLE SMSIncomming(SMSIncommingID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, SMSIncommingText NVARCHAR(255) NULL, SMSIncommingMobile NVARCHAR(255) NULL, SMSIncommingNetwork NVARCHAR(255) NULL, SMSIncommingChannel NVARCHAR(255) NULL, SMSIncommingServiceid NVARCHAR(255) NULL, SMSIncommingCreated datetime NULL)</sql>
        <sql conditional="">CREATE TABLE SMSOutgoing( SMSOutgoingID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, SMSOutgoingMobile NVARCHAR(255) NULL, SMSOutgoingGatewayMessageID NVARCHAR(255) NULL, SMSOutgoingCreated datetime NULL, SMSOutgoingText ntext NULL, SMSOutgoingStatus INT NULL)</sql>
        <sql conditional="">CREATE TABLE SMSRecipientList( SMSRecipientListID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, SMSRecipientListName NVARCHAR(255) NULL, SMSRecipientListDescription ntext NULL, SMSRecipientListCreated datetime NULL)</sql>
        <sql conditional="">CREATE TABLE SMSRecipient(SMSRecipientID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,SMSRecipientListID INT NULL,SMSRecipientFirstname NVARCHAR(255) NULL,SMSRecipientLastname NVARCHAR(255) NULL,SMSRecipientMobile NVARCHAR(255) NULL,SMSRecipientCreated datetime NULL)</sql>
        <sql conditional="">ALTER TABLE [SMSRecipient] ADD FOREIGN KEY([SMSRecipientListID]) REFERENCES [SMSRecipientList] ([SMSRecipientListID])</sql>
        <sql conditional="">CREATE TABLE SMSSetting(SMSSettingID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, SMSSettingVersionIsExtended BIT NOT NULL, SMSSettingSMSgatewayURL NVARCHAR(255) NULL, SMSSettingSMSgatewayUsername NVARCHAR(255) NULL, SMSSettingSMSgatewayPassword NVARCHAR(255) NULL, SMSSettingSMSgatewayErrorMessageHeader NVARCHAR(255) NULL, SMSSettingSMSgatewayErrorMessage NVARCHAR(255) NULL, SMSSettingSMSgatewayUserID INT NULL, SMSSettingSMSgatewayKeyword NVARCHAR(50) NULL)</sql>
        <sql conditional="select * from SMSSetting">INSERT INTO SMSSetting(SMSSettingVersionIsExtended, SMSSettingSMSgatewayURL, SMSSettingSMSgatewayUsername, SMSSettingSMSgatewayPassword, SMSSettingSMSgatewayErrorMessageHeader, SMSSettingSMSgatewayErrorMessage) values(1, '', '', '', 'Customer', 'Sorry - we dont understand our message. Please check text and try again')</sql>
      </Module>
    </database>
    -->
  </package>

  <package version="216" date="03-12-2007" internalversion="18.13.1.0">
    <file name="RSSExt_News2Default_Page.html" overwrite="false" target="Files/Templates/RSSfeed/RSSList" source="Files/Templates/RSSfeed/RSSList" />
  </package>

  <package version="215" date="17-09-2007" internalversion="18.13.1.0">
    <!--
    <file name="ValidatorMessages.html" target="Files/Templates/ExtranetExtended" source="Files/Templates/ExtranetExtended" />
    <file name="UserNotification.html" target="Files/Templates/ExtranetExtended" source="Files/Templates/ExtranetExtended" />
    <file name="UserConfirmation.html" target="Files/Templates/ExtranetExtended" source="Files/Templates/ExtranetExtended" />
    <file name="Profile.html" target="Files/Templates/ExtranetExtended" source="Files/Templates/ExtranetExtended" />
    <file name="Login.html" target="Files/Templates/ExtranetExtended" source="Files/Templates/ExtranetExtended" />
    <file name="ForgottenPassword.html" target="Files/Templates/ExtranetExtended" source="Files/Templates/ExtranetExtended" />
    <file name="EmailForgottenPassword.html" target="Files/Templates/ExtranetExtended" source="Files/Templates/ExtranetExtended" />
    <file name="AdminConfirmation.html" target="Files/Templates/ExtranetExtended" source="Files/Templates/ExtranetExtended" />
    -->
  </package>

  <package version="214" date="10-09-2007" internalversion="18.13.1.0">
    <file name="DNSName.html" target="Files/Templates/StatisticsV3/ReportUserAll/ShowSessionReport" source="Files/Templates/StatisticsV3/ReportUserAll/ShowSessionReport" />
    <file name="UserLocalize.html" target="Files/Templates/StatisticsV3/ReportUserAll/ShowSessionReport" source="Files/Templates/StatisticsV3/ReportUserAll/ShowSessionReport" />
    <file name="SiteMapEmailLink.html" target="Files/Templates/StatisticsV3" source="Files/Templates/StatisticsV3" />
  </package>

  <package version="213" date="06-09-2007" internalversion="18.13.1.0">
    <folder source="Files/Templates/eCom/Order" target="Files/Templates/eCom" />
  </package>

  <package version="212" date="08-01-2008" internalversion="18.13.1.0">
    <database file="Dynamic.mdb">
      <Area>
        <sql conditional="">ALTER TABLE Area ADD AreaRobotsTxt NVARCHAR(255) Null, AreaRobotsTxtIncludeSitemap BIT NOT NULL DEFAULT 0</sql>
      </Area>
    </database>
  </package>

  <package version="211" date="11-12-2007" internalversion="18.13.1.0">
    <!--
    <file name="ShowArticle.html" overwrite="false" target="Files/Templates/Weblog/Articles" source="Files/Templates/Weblog/Articles" />
    <file name="ListArticle.html" overwrite="false" target="Files/Templates/Weblog/Articles" source="Files/Templates/Weblog/Articles" />
    <file name="LatestPosts.html" overwrite="false" target="Files/Templates/Weblog/Articles" source="Files/Templates/Weblog/Articles" />
    -->
  </package>

  <package version="209" date="04-12-2007" internalversion="18.13.1.0">
    <!--<file name="SearchFields.html" overwrite="false" target="Files/Templates/Employee/Search" source="Files/Templates/Employee/Search" />-->
    <file name="MasterList.html" overwrite="false" target="Files/Templates/DBPub/Base" source="Files/Templates/DBPub/Base" />
  </package>

  <package version="207" date="26-11-2007" internalversion="18.13.3.0">
    <database file="Ipaper.mdb">
      <field>
        <sql conditional="">UPDATE IpaperLanguageKeys SET DefaultValue = 'Click here to go to the previous page.', FriendlyName = 'Forrige side ikon', Visible = 1 WHERE Name = 'help_zoomPaginLeft'</sql>
        <sql conditional="">UPDATE IpaperLanguageKeys SET DefaultValue = 'Click here to go to the next page.', FriendlyName = 'Næste side ikon', Visible = 1 WHERE Name = 'help_zoomPaginRight'</sql>
      </field>
    </database>
  </package>

  <package version="206" date="15-11-2007" internalversion="18.13.2.0">
    <database file="DbPub.mdb">
      <field>
        <sql conditional="">ALTER TABLE DBPubField ADD DBPubFieldLabel NVARCHAR(255) Null</sql>
      </field>
    </database>
  </package>

  <package version="205" date="09-11-2007" internalversion="18.13.1.0">
    <!--
    <file name="ListArticle.html" overwrite="false" target="Files/Templates/Weblog/Articles" source="Files/Templates/Weblog/Articles" />
    <file name="ShowArticle.html" overwrite="false" target="Files/Templates/Weblog/Articles" source="Files/Templates/Weblog/Articles" />
    <file name="LatestPosts.html" overwrite="false" target="Files/Templates/Weblog/Articles" source="Files/Templates/Weblog/Articles" />
    -->
  </package>

  <package version="204" date="06-11-2007" internalversion="18.13.1.0">
    <file name="MasterList.html" overwrite="false" target="Files/Templates/DBPub/Base" source="Files/Templates/DBPub/Base" />
  </package>

  <package version="203" date="26-10-2007" internalversion="18.13.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">DELETE FROM [Module] WHERE [ModuleSystemName] = 'RemoteHttp'</sql>
      </Module>
    </database>
  </package>

  <package version="202" date="30-10-2007" internalversion="18.13.1.0">
    <!--<file name="ListTeam.html" overwrite="false" target="Files/Templates/Weblog/Shared" source="Files/Templates/Weblog/Shared" />-->
  </package>

  <package version="201" date="22-10-2007" internalversion="18.13.1.0">
    <database file="Dynamic.mdb">
      <Template>
        <sql conditional="">ALTER TABLE [Template] ADD TemplateImageLargeHeight INT NULL</sql>
        <sql conditional="">ALTER TABLE [Template] ADD TemplateImageLargeWidth INT NULL</sql>
        <sql conditional="">ALTER TABLE [Template] ADD TemplateImageThumbnailHeight INT NULL</sql>
        <sql conditional="">ALTER TABLE [Template] ADD TemplateImageThumbnailWidth INT NULL</sql>
      </Template>
    </database>
  </package>

  <package version="200" date="19-10-2007" internalversion="18.13.1.0">
    <!--
    <file name="EditArticle.html" overwrite="false" target="Files/Templates/Weblog/Articles" source="Files/Templates/Weblog/Articles" />
    <file name="ListComment.html" overwrite="false" target="Files/Templates/Weblog/Comments" source="Files/Templates/Weblog/Comments" />
    <database file="Weblog.mdb">
      <WeblogArticle>
        <sql conditional="">ALTER TABLE [WeblogArticle] ADD WeblogArticleAllowComments BIT NOT NULL DEFAULT 0</sql>
      </WeblogArticle>
    </database>
    -->
  </package>

  <package version="199" date="17-10-2007" internalversion="18.13.1.0">
    <file name="xmltoscv_order_statements.xslt" overwrite="false" target="Files/Files/Integration" source="Files/Files/Integration" />
    <file name="csvtoxml_order_structure.xml" overwrite="false" target="Files/Files/Integration" source="Files/Files/Integration" />
    <file name="Orders_Export_to_CSV.pipe" overwrite="false" target="Files/Files/Integration/eCommerce" source="Files/Files/Integration/eCommerce" />
    <file name="Orders_Export_to_XML.pipe" overwrite="false" target="Files/Files/Integration/eCommerce" source="Files/Files/Integration/eCommerce" />
    <file name="Orders_Import_from_CSV.pipe" overwrite="false" target="Files/Files/Integration/eCommerce" source="Files/Files/Integration/eCommerce" />
    <file name="Orders_Import_from_XML.pipe" overwrite="false" target="Files/Files/Integration/eCommerce" source="Files/Files/Integration/eCommerce" />
  </package>

  <package version="198" date="10-10-2007" internalversion="18.13.1.0">
    <database file="Statisticsv2.mdb">
      <Statv2NotFound>
        <sql conditional="">CREATE TABLE Statv2NotFound (Statv2NotFoundID  INT IDENTITY(1,1) PRIMARY KEY, Statv2NotFoundPath VARCHAR (255) NOT NULL, Statv2NotFoundReferer VARCHAR (255) NOT NULL, Statv2NotFoundTimestamp DATETIME NULL)</sql>
      </Statv2NotFound>
    </database>
  </package>

  <package version="197" date="05-10-2007" internalversion="18.13.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE ModuleSystemName = 'Update' AND ModuleAccess = blnTrue">UPDATE [Module] SET ModuleAccess = blnTrue, ModuleStandard = blnTrue WHERE ModuleSystemName='RemoteHttp'</sql>
      </Module>
    </database>
  </package>

  <package version="196" date="03-10-2007" internalversion="18.13.1.0">
    <database file="Survey.mdb">
      <Survey>
        <sql conditional="">ALTER TABLE [SurveyAnswerOption] ADD SurveyAnswerOptionTypeInstruction INT DEFAULT 0</sql>
        <sql conditional="">ALTER TABLE [SurveyAnswerOption] ADD SurveyAnswerOptionPageInstruction VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE [SurveyAnswerOption] ADD SurveyAnswerOptionTextInstruction MEMO NULL</sql>
        <sql conditional="">ALTER TABLE [SurveyQuestion] ADD SurveyQuestionTextInstruction MEMO NULL</sql>
        <sql conditional="">ALTER TABLE [SurveyQuestion] ADD SurveyQuestionTypeInstruction INT DEFAULT 0</sql>
      </Survey>
    </database>
  </package>

  <package version="195" date="02-10-2007" internalversion="18.13.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'RegisterModule'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleScript, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleIsBeta) VALUES ('RegisterModule', 'Dynamicweb Developer', 'RegisterModule/List.aspx', 0, 0, 0, 0, 0, 0)</sql>
      </Module>
    </database>
  </package>
  <package version="194" date="26-09-2007" internalversion="18.13.1.0">
    <database file="Dynamic.mdb">
      <Area>
        <sql conditional="">ALTER TABLE Area ADD AreaDomainLock NVARCHAR(255) Null</sql>
      </Area>
    </database>
  </package>
  <package version="193" date="01-10-2007" internalversion="18.13.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleIsBeta = blnTrue WHERE ModuleSystemName = 'NewsV2'</sql>
      </Module>
    </database>
  </package>
  <package version="192" date="25-09-2007" internalversion="18.13.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'UrlPath'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleScript, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleIsBeta) VALUES ('UrlPath', 'Direkte stier', 'UrlPath/List.aspx', 0, 0, 0, 0, 0, 1)</sql>
      </Module>
      <urlpath>
        <sql conditional="">CREATE TABLE UrlPath (UrlPathID  INT IDENTITY(1,1) PRIMARY KEY, UrlPathPath VARCHAR (255) NOT NULL, UrlPathRedirect VARCHAR (255) NOT NULL, UrlPathStatus INT NULL, UrlPathCreated DATETIME NULL, UrlPathUpdated DATETIME NULL, UrlPathActive BIT NOT NULL DEFAULT 1)</sql>
      </urlpath>
    </database>
  </package>
  <package version="191" date="19-09-2007" internalversion="18.13.1.0">
    <database file="Dynamic.mdb">
      <Paragraph>
        <sql conditional="">ALTER TABLE MetadataField ADD FieldDublinCore BIT NOT NULL DEFAULT 0</sql>
      </Paragraph>
    </database>
  </package>
  <package version="190" date="10-09-2007" internalversion="18.13.1.0">
    <database file="Dynamic.mdb">
      <Paragraph>
        <sql conditional="">ALTER TABLE Paragraph ADD ParagraphPreview BIT NOT NULL DEFAULT 0</sql>
      </Paragraph>
    </database>
  </package>
  <package version="189" date="10-09-2007" internalversion="18.13.1.0">
    <database file="Dynamic.mdb">
      <NewsV2TemplatesFix>
        <sql conditional="SELECT * FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'">
          INSERT INTO [templatecategory] ([TemplateCategoryName],[TemplateCatgeoryDirectory],[TemplateCategoryIsProtected])VALUES('NewsV2','NewsV2',1)
        </sql>
        <sql conditional="SELECT * FROM [Template] WHERE [TemplateName]='T11-B11' AND [TemplateCategoryID]=(SELECT [TemplateCategoryID] FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2')">
          INSERT INTO [template] ([TemplateCategoryID],[TemplateName],[TemplateFile],[TemplateIcon],[TemplateIsProtected],[TemplateIsDefault],[TemplateTypeID],[TemplatePutInTable],[TemplateSettings],[TemplateImageColumns],[TemplateImageWidth],[TemplateDescription],[TemplateActive],[TemplateSort],[TemplateAutoResize],[TemplateImageHeight])
          SELECT [TemplateCategoryID], 'T11-B11','T11-B11.html','default.gif',1,1,0,'True',NULL,0,0,NULL,1,NULL,0,NULL FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'
        </sql>
        <sql conditional="SELECT * FROM [Template] WHERE [TemplateName]='T5-B1' AND [TemplateCategoryID]=(SELECT [TemplateCategoryID] FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2')">
          INSERT INTO [template] ([TemplateCategoryID],[TemplateName],[TemplateFile],[TemplateIcon],[TemplateIsProtected],[TemplateIsDefault],[TemplateTypeID],[TemplatePutInTable],[TemplateSettings],[TemplateImageColumns],[TemplateImageWidth],[TemplateDescription],[TemplateActive],[TemplateSort],[TemplateAutoResize],[TemplateImageHeight])
          SELECT [TemplateCategoryID], 'T5-B1','T5-B1.html','T5-B1.gif',1,0,0,'True',NULL,0,0,NULL,1,NULL,0,NULL FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'
        </sql>
        <sql conditional="SELECT * FROM [Template] WHERE [TemplateName]='T4-B2' AND [TemplateCategoryID]=(SELECT [TemplateCategoryID] FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2')">
          INSERT INTO [template] ([TemplateCategoryID],[TemplateName],[TemplateFile],[TemplateIcon],[TemplateIsProtected],[TemplateIsDefault],[TemplateTypeID],[TemplatePutInTable],[TemplateSettings],[TemplateImageColumns],[TemplateImageWidth],[TemplateDescription],[TemplateActive],[TemplateSort],[TemplateAutoResize],[TemplateImageHeight])
          SELECT [TemplateCategoryID], 'T4-B2','T4-B2.html','T4-B2.gif',1,0,0,'True',NULL,0,0,NULL,1,NULL,0,NULL FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'
        </sql>
        <sql conditional="SELECT * FROM [Template] WHERE [TemplateName]='T3-B3' AND [TemplateCategoryID]=(SELECT [TemplateCategoryID] FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2')">
          INSERT INTO [template] ([TemplateCategoryID],[TemplateName],[TemplateFile],[TemplateIcon],[TemplateIsProtected],[TemplateIsDefault],[TemplateTypeID],[TemplatePutInTable],[TemplateSettings],[TemplateImageColumns],[TemplateImageWidth],[TemplateDescription],[TemplateActive],[TemplateSort],[TemplateAutoResize],[TemplateImageHeight])
          SELECT [TemplateCategoryID], 'T3-B3','T3-B3.html','T3-B3.gif',1,0,0,'True',NULL,0,0,NULL,1,NULL,0,NULL FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'
        </sql>
        <sql conditional="SELECT * FROM [Template] WHERE [TemplateName]='T2-B4' AND [TemplateCategoryID]=(SELECT [TemplateCategoryID] FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2')">
          INSERT INTO [template] ([TemplateCategoryID],[TemplateName],[TemplateFile],[TemplateIcon],[TemplateIsProtected],[TemplateIsDefault],[TemplateTypeID],[TemplatePutInTable],[TemplateSettings],[TemplateImageColumns],[TemplateImageWidth],[TemplateDescription],[TemplateActive],[TemplateSort],[TemplateAutoResize],[TemplateImageHeight])
          SELECT [TemplateCategoryID], 'T2-B4','T2-B4.html','T2-B4.gif',1,0,0,'True',NULL,0,0,NULL,1,NULL,0,NULL FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'
        </sql>
        <sql conditional="SELECT * FROM [Template] WHERE [TemplateName]='T2-B2' AND [TemplateCategoryID]=(SELECT [TemplateCategoryID] FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2')">
          INSERT INTO [template] ([TemplateCategoryID],[TemplateName],[TemplateFile],[TemplateIcon],[TemplateIsProtected],[TemplateIsDefault],[TemplateTypeID],[TemplatePutInTable],[TemplateSettings],[TemplateImageColumns],[TemplateImageWidth],[TemplateDescription],[TemplateActive],[TemplateSort],[TemplateAutoResize],[TemplateImageHeight])
          SELECT [TemplateCategoryID], 'T2-B2','T2-B2.html','T2-B2.gif',1,0,0,'True',NULL,0,0,NULL,1,NULL,0,NULL FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'
        </sql>
        <sql conditional="SELECT * FROM [Template] WHERE [TemplateName]='T1-B5' AND [TemplateCategoryID]=(SELECT [TemplateCategoryID] FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2')">
          INSERT INTO [template] ([TemplateCategoryID],[TemplateName],[TemplateFile],[TemplateIcon],[TemplateIsProtected],[TemplateIsDefault],[TemplateTypeID],[TemplatePutInTable],[TemplateSettings],[TemplateImageColumns],[TemplateImageWidth],[TemplateDescription],[TemplateActive],[TemplateSort],[TemplateAutoResize],[TemplateImageHeight])
          SELECT [TemplateCategoryID], 'T1-B5','T1-B5.html','T1-B5.gif',1,0,0,'True',NULL,0,0,NULL,1,NULL,0,NULL FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'
        </sql>
        <sql conditional="SELECT * FROM [Template] WHERE [TemplateName]='Tx-Bx' AND [TemplateCategoryID]=(SELECT [TemplateCategoryID] FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2')">
          INSERT INTO [template] ([TemplateCategoryID],[TemplateName],[TemplateFile],[TemplateIcon],[TemplateIsProtected],[TemplateIsDefault],[TemplateTypeID],[TemplatePutInTable],[TemplateSettings],[TemplateImageColumns],[TemplateImageWidth],[TemplateDescription],[TemplateActive],[TemplateSort],[TemplateAutoResize],[TemplateImageHeight])
          SELECT [TemplateCategoryID],'Tx-Bx','Tx-Bx.html','Tx-Bx.gif',1,0,0,'False','Align="right" vspace="5" hspace="5"',0,0,NULL,1,NULL,0,NULL FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'
        </sql>
        <sql conditional="SELECT * FROM [Template] WHERE [TemplateName]='B1-T5' AND [TemplateCategoryID]=(SELECT [TemplateCategoryID] FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2')">
          INSERT INTO [template] ([TemplateCategoryID],[TemplateName],[TemplateFile],[TemplateIcon],[TemplateIsProtected],[TemplateIsDefault],[TemplateTypeID],[TemplatePutInTable],[TemplateSettings],[TemplateImageColumns],[TemplateImageWidth],[TemplateDescription],[TemplateActive],[TemplateSort],[TemplateAutoResize],[TemplateImageHeight])
          SELECT [TemplateCategoryID],'B1-T5','B1-T5.html','B1-T5.gif',1,0,0,'True',NULL,0,0,NULL,1,NULL,0,NULL FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'
        </sql>
        <sql conditional="SELECT * FROM [Template] WHERE [TemplateName]='B2-T2' AND [TemplateCategoryID]=(SELECT [TemplateCategoryID] FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2')">
          INSERT INTO [template] ([TemplateCategoryID],[TemplateName],[TemplateFile],[TemplateIcon],[TemplateIsProtected],[TemplateIsDefault],[TemplateTypeID],[TemplatePutInTable],[TemplateSettings],[TemplateImageColumns],[TemplateImageWidth],[TemplateDescription],[TemplateActive],[TemplateSort],[TemplateAutoResize],[TemplateImageHeight])
          SELECT [TemplateCategoryID],'B2-T2','B2-T2.html','B2-T2.gif',1,0,0,'True',NULL,0,0,NULL,1,NULL,0,NULL FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'
        </sql>
        <sql conditional="SELECT * FROM [Template] WHERE [TemplateName]='B2-T4' AND [TemplateCategoryID]=(SELECT [TemplateCategoryID] FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2')">
          INSERT INTO [template] ([TemplateCategoryID],[TemplateName],[TemplateFile],[TemplateIcon],[TemplateIsProtected],[TemplateIsDefault],[TemplateTypeID],[TemplatePutInTable],[TemplateSettings],[TemplateImageColumns],[TemplateImageWidth],[TemplateDescription],[TemplateActive],[TemplateSort],[TemplateAutoResize],[TemplateImageHeight])
          SELECT [TemplateCategoryID],'B2-T4','B2-T4.html','B2-T4.gif',1,0,0,'True',NULL,0,0,NULL,1,NULL,0,NULL FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'
        </sql>
        <sql conditional="SELECT * FROM [Template] WHERE [TemplateName]='B3-T3' AND [TemplateCategoryID]=(SELECT [TemplateCategoryID] FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2')">
          INSERT INTO [template] ([TemplateCategoryID],[TemplateName],[TemplateFile],[TemplateIcon],[TemplateIsProtected],[TemplateIsDefault],[TemplateTypeID],[TemplatePutInTable],[TemplateSettings],[TemplateImageColumns],[TemplateImageWidth],[TemplateDescription],[TemplateActive],[TemplateSort],[TemplateAutoResize],[TemplateImageHeight])
          SELECT [TemplateCategoryID],'B3-T3','B3-T3.html','B3-T3.gif',1,0,0,'True',NULL,0,0,NULL,1,NULL,0,NULL FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'
        </sql>
        <sql conditional="SELECT * FROM [Template] WHERE [TemplateName]='B4-T2' AND [TemplateCategoryID]=(SELECT [TemplateCategoryID] FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2')">
          INSERT INTO [template] ([TemplateCategoryID],[TemplateName],[TemplateFile],[TemplateIcon],[TemplateIsProtected],[TemplateIsDefault],[TemplateTypeID],[TemplatePutInTable],[TemplateSettings],[TemplateImageColumns],[TemplateImageWidth],[TemplateDescription],[TemplateActive],[TemplateSort],[TemplateAutoResize],[TemplateImageHeight])
          SELECT [TemplateCategoryID],'B4-T2','B4-T2.html','B4-T2.gif',1,0,0,'True',NULL,0,0,NULL,1,NULL,0,NULL FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'
        </sql>
        <sql conditional="SELECT * FROM [Template] WHERE [TemplateName]='B5-T1' AND [TemplateCategoryID]=(SELECT [TemplateCategoryID] FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2')">
          INSERT INTO [template] ([TemplateCategoryID],[TemplateName],[TemplateFile],[TemplateIcon],[TemplateIsProtected],[TemplateIsDefault],[TemplateTypeID],[TemplatePutInTable],[TemplateSettings],[TemplateImageColumns],[TemplateImageWidth],[TemplateDescription],[TemplateActive],[TemplateSort],[TemplateAutoResize],[TemplateImageHeight])
          SELECT [TemplateCategoryID],'B5-T1','B5-T1.html','B5-T1.gif',1,0,0,'True',NULL,0,0,NULL,1,NULL,0,NULL FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'
        </sql>
        <sql conditional="SELECT * FROM [Template] WHERE [TemplateName]='Bx-Tx' AND [TemplateCategoryID]=(SELECT [TemplateCategoryID] FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2')">
          INSERT INTO [template] ([TemplateCategoryID],[TemplateName],[TemplateFile],[TemplateIcon],[TemplateIsProtected],[TemplateIsDefault],[TemplateTypeID],[TemplatePutInTable],[TemplateSettings],[TemplateImageColumns],[TemplateImageWidth],[TemplateDescription],[TemplateActive],[TemplateSort],[TemplateAutoResize],[TemplateImageHeight])
          SELECT [TemplateCategoryID],'Bx-Tx','Bx-Tx.html','Bx-Tx.gif',1,0,0,'False','Align="Left" vspace="5" hspace="5"',0,0,NULL,1,NULL,0,NULL FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'
        </sql>
        <sql conditional="SELECT * FROM [Template] WHERE [TemplateName]='B11-T11' AND [TemplateCategoryID]=(SELECT [TemplateCategoryID] FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2')">
          INSERT INTO [template] ([TemplateCategoryID],[TemplateName],[TemplateFile],[TemplateIcon],[TemplateIsProtected],[TemplateIsDefault],[TemplateTypeID],[TemplatePutInTable],[TemplateSettings],[TemplateImageColumns],[TemplateImageWidth],[TemplateDescription],[TemplateActive],[TemplateSort],[TemplateAutoResize],[TemplateImageHeight])
          SELECT [TemplateCategoryID],'B11-T11','B11-T11.html','B11-T11.gif',1,0,0,'True',NULL,0,0,NULL,1,NULL,0,NULL FROM [TemplateCategory] WHERE [TemplateCategoryName]='NewsV2'
        </sql>
      </NewsV2TemplatesFix>
    </database>
  </package>

  <package version="188" date="04-09-2007" internalversion="18.13.1.0">
    <!--
    <database file="Weblog.mdb">
      <Modify>
        <sql conditional="">ALTER TABLE WeblogBlog ALTER COLUMN WeblogBlogDescription ntext NULL</sql>
      </Modify>
    </database>
    -->
  </package>

  <package version="187" date="22-08-2007" internalversion="18.13.0.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleIsBeta = blnFalse WHERE ModuleSystemName = 'Ipaper'</sql>
        <sql conditional="">UPDATE [Module] SET ModuleIsBeta = blnFalse WHERE ModuleSystemName = 'IpaperExtended'</sql>
        <sql conditional="">UPDATE [Module] SET ModuleIsBeta = blnFalse WHERE ModuleSystemName = 'NewsV2'</sql>
        <sql conditional="">UPDATE [Module] SET ModuleIsBeta = blnFalse WHERE ModuleSystemName = 'eCom_ImportExport'</sql>
        <sql conditional="">UPDATE [Module] SET ModuleIsBeta = blnFalse WHERE ModuleSystemName = 'eCom_Statistics'</sql>
      </Module>
    </database>
  </package>

  <package version="185" date="17-08-2007" internalversion="18.12.1.0">
    <file name="RSS_Page.html" target="/Files/Templates/RSSfeed" overwrite="false"  source="/Files/Templates/RSSfeed" />
    <file name="RSSFeed_Page.html" target="/Files/Templates/RSSfeed" overwrite="false"  source="/Files/Templates/RSSfeed" />
  </package>

  <package version="178" date="07-08-2007" internalversion="18.12.1.0">
    <database file="Access.mdb">
      <GroupTables>
        <sql conditional="">CREATE TABLE AccessCustomGroup (AccessCustomGroupID INT NOT NULL IDENTITY(1,1) PRIMARY KEY, AccessCustomGroupName VARCHAR(255) NOT NULL, AccessCustomGroupContext VARCHAR(255) NOT NULL)</sql>
        <sql conditional="">CREATE TABLE AccessCustomCategoryGroup (AccessCustomCategoryID INT NOT NULL, AccessCustomGroupID INT NOT NULL, AccessCustomCategoryContext VARCHAR(255) NOT NULL, PRIMARY KEY(AccessCustomCategoryID, AccessCustomGroupID, AccessCustomCategoryContext))</sql>
        <sql conditional="">CREATE TABLE AccessCustomGroupFieldRelation (AccessCustomRelationGroupID INT NOT NULL, AccessCustomRelationFieldID INT NOT NULL, PRIMARY KEY(AccessCustomRelationGroupID, AccessCustomRelationFieldID))</sql>
      </GroupTables>
      <GroupConstraints>
        <sql conditional="">CREATE INDEX AccessCustomGroupFieldRelation_IDX001 ON AccessCustomGroupFieldRelation (AccessCustomRelationGroupID)</sql>
        <sql conditional="">CREATE INDEX AccessCustomCategoryGroup_IDX001 ON AccessCustomCategoryGroup (AccessCustomGroupID)</sql>
        <sql conditional="">CREATE INDEX AccessCustomCategoryGroup_IDX002 ON AccessCustomCategoryGroup (AccessCustomCategoryID, AccessCustomCategoryContext)</sql>
        <sql conditional="">ALTER TABLE [AccessCustomGroupFieldRelation] ADD CONSTRAINT AccessCustomGroupFieldRelation_FK01 FOREIGN KEY (AccessCustomRelationFieldID) REFERENCES AccessCustomField (AccessCustomFieldID) ON DELETE CASCADE </sql>
        <sql conditional="">ALTER TABLE [AccessCustomGroupFieldRelation] ADD CONSTRAINT AccessCustomGroupFieldRelation_FK02 FOREIGN KEY (AccessCustomRelationGroupID) REFERENCES AccessCustomGroup (AccessCustomGroupID) ON DELETE CASCADE </sql>
        <sql conditional="">ALTER TABLE [AccessCustomCategoryGroup] ADD CONSTRAINT AccessCustomCategoryGroup_FK01 FOREIGN KEY (AccessCustomGroupID) REFERENCES AccessCustomGroup (AccessCustomGroupID) ON DELETE CASCADE </sql>
      </GroupConstraints>
      <NewsLetterV3RelatedItemMsSqlFix>
        <sql conditional="">ALTER TABLE NewsLetterV3RelatedItem ADD ItemType INT NOT NULL DEFAULT 1</sql>
        <sql conditional="">ALTER TABLE [NewsLetterV3RelatedItem] ADD CONSTRAINT NewsLetterV3RelatedItem_PK PRIMARY KEY (NewsLetterID, ItemID, ItemType)</sql>
        <sql conditional="">CREATE INDEX NewsLetterV3RelatedItem_IDX001 ON NewsLetterV3RelatedItem (NewsLetterID, ItemType)</sql>
      </NewsLetterV3RelatedItemMsSqlFix>
    </database>
  </package>

  <package version="176" date="31-07-2007" internalversion="18.12.1.0">
    <database file="Access.mdb">
      <CustomFieldTables>
        <sql conditional="">ALTER TABLE NewsLetterV3NewsLetter DROP NewsletterName</sql>
        <sql conditional="">ALTER TABLE NewsLetterV3IntegrationRule DROP IntegrationRuleName</sql>
      </CustomFieldTables>
    </database>
  </package>

  <package version="175" date="30-07-2007" internalversion="18.12.1.0">
    <database file="Dynamic.mdb">
      <CustomFieldTables>
        <sql conditional="">UPDATE [Module] SET ModuleControlpanel = 'NewsletterV3_cpl.aspx' WHERE ModuleSystemName = 'NewsLetterV3'</sql>
      </CustomFieldTables>
    </database>
  </package>

  <package version="174" date="26-07-2007" internalversion="18.12.1.0">
    <database file="Access.mdb">
      <CustomFieldTables>
        <sql conditional="">ALTER TABLE [AccessCustomField] ADD [AccessCustomFieldRequired] BIT NOT NULL DEFAULT 0</sql>
      </CustomFieldTables>
    </database>
  </package>

  <package version="173" date="19-07-2007" internalversion="18.12.1.0">
    <database file="Access.mdb">
      <CustomFieldTables>
        <sql conditional="">CREATE TABLE AccessCustomFieldRow (CustomFieldRowID INT NOT NULL IDENTITY(1,1) PRIMARY KEY, CustomFieldRowFieldID INT NOT NULL, CustomFieldRowItemID INT NOT NULL, CustomFieldRowValue MEMO NULL)</sql>
        <sql conditional="">ALTER TABLE [AccessCustomField] ADD AccessCustomFieldSort INT DEFAULT 0</sql>
      </CustomFieldTables>
      <CustomFieldConstraints>
        <sql conditional="">ALTER TABLE [AccessCustomFieldRow] ADD CONSTRAINT AccessCustomFieldRow_FK01 FOREIGN KEY (CustomFieldRowFieldID) REFERENCES AccessCustomField (AccessCustomFieldID) ON DELETE CASCADE </sql>
        <sql conditional="">CREATE INDEX AccessCustomFieldRow_IDX001 ON AccessCustomFieldRow (CustomFieldRowFieldID, CustomFieldRowItemID)</sql>
      </CustomFieldConstraints>
    </database>
  </package>

  <package version="172" date="20-07-2007" internalversion="18.12.1.1">
    <!--<file name="MasterEdit.html" target="Files/Templates/Employee/FrontendEdit" overwrite="false"  source="Files/Templates/Employee/FrontendEdit" />-->
  </package>

  <package version="171" date="06-07-2007" internalversion="18.12.1.0">

    <folder source="Files/Templates/NewsV2" target="Files/Templates" />

    <database file="Dynamic.mdb">
      <NewsMetadata>
        <sql conditional="">CREATE TABLE NewsMetadata (MetadataID INT IDENTITY(1,1) PRIMARY KEY, MetadataNewsID INT NULL ,MetadataFieldID INT NULL ,MetadataOption MEMO NULL )</sql>
        <sql conditional="">ALTER TABLE [NewsMetadata] ADD CONSTRAINT NewsMetadata_FK00 FOREIGN KEY (MetadataNewsID) REFERENCES News (NewsID) ON DELETE CASCADE </sql>
        <sql conditional="">ALTER TABLE [NewsMetadata] ADD CONSTRAINT NewsMetadata_FK01 FOREIGN KEY (MetadataFieldID) REFERENCES MetadataField (FieldID) ON DELETE CASCADE </sql>
      </NewsMetadata>
    </database>
    <database file="Statisticsv2.mdb">
      <StatisticNewsletterReport>
        <sql conditional="SELECT * FROM [Statv2Type] WHERE [Statv2TypeID]=5">INSERT INTO [Statv2Type](Statv2TypeID, Statv2TypeName) values(5, 'Report Tree')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=60">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(60, 5, 'Modules - Newsletter recipient')</sql>
      </StatisticNewsletterReport>
    </database>
  </package>

  <package version="170" date="05-07-2007" internalversion="18.12.1.0">
    <database file="Dynamic.mdb">
      <NewsV2Update>
        <sql conditional="">UPDATE [Module] SET [ModuleDatabase]= 'Dynamic.mdb',  [ModuleTable]='NewsCategory', [ModuleFieldID]='NewsCategoryID', [ModuleFieldName] = 'NewsCategoryName' WHERE [ModuleSystemName]='NewsV2' </sql>
      </NewsV2Update>
    </database>
  </package>

  <package version="169" date="02-07-2007" internalversion="18.12.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql>ALTER TABLE [Area] ADD AreaLanguageControlLanguage VARCHAR (255) NULL</sql>
      </Module>
    </database>
  </package>

  <package version="168" date="30-06-2007" internalversion="18.12.1.0">
    <database file="Dynamic.mdb">
      <NewsV2Update>
        <sql conditional="">UPDATE [Module] SET [ModuleScript]='NewsV2/Default.aspx' WHERE [ModuleSystemName]='NewsV2' </sql>
      </NewsV2Update>
      <NewsV2Tables>
        <sql conditional="">ALTER TABLE [NewsCategory] ADD NewsCategoryDescription MEMO NULL </sql>
        <sql conditional="">CREATE TABLE NewsV2Settings (SettingsID INT IDENTITY(1,1) PRIMARY KEY, SettingsName VARCHAR(255) NOT NULL, SettingsValue MEMO NOT NULL)</sql>
      </NewsV2Tables>
      <NewsV2CreateIndexes>
        <sql conditional="">CREATE INDEX NewsV2Settings_IDX001 ON NewsV2Settings (SettingsID)</sql>
      </NewsV2CreateIndexes>
      <NewsV2Data>
        <sql conditional="SELECT * FROM [NewsV2Settings] WHERE [SettingsName]='RecordsPerPage'">INSERT INTO [NewsV2Settings](SettingsName, SettingsValue) VALUES('RecordsPerPage', '20')</sql>
      </NewsV2Data>
    </database>
  </package>

  <package version="167" date="30-06-2007" internalversion="18.12.1.0">
    <database file="Access.mdb">
      <NewsLetterV3NewsLetterItem>
        <sql conditional="">ALTER TABLE [NewsLetterV3NewsLetterItem] ADD NewsLetterItemType INT NULL </sql>
        <sql conditional="">ALTER TABLE [NewsLetterV3NewsLetterItem] ADD NewsLetterItemSubType INT NULL </sql>
      </NewsLetterV3NewsLetterItem>
    </database>
  </package>

  <package version="166" date="29-06-2007" internalversion="18.12.1.0">
    <database file="Access.mdb">
      <NewsLetterV3RelatedItem>
        <sql conditional="">ALTER TABLE NewsLetterV3RelatedItem ADD ItemType INT NOT NULL</sql>
        <sql conditional="">UPDATE NewsLetterV3RelatedItem SET ItemType=NewsLetterType</sql>
        <sql conditional="">SELECT * INTO NewsLetterV3RelatedItem_1 FROM NewsLetterV3RelatedItem</sql>
        <sql conditional="">ALTER TABLE NewsLetterV3RelatedItem_1 DROP NewsLetterType</sql>
        <sql conditional="">DROP TABLE NewsLetterV3RelatedItem</sql>
        <sql conditional="">SELECT * INTO NewsLetterV3RelatedItem FROM NewsLetterV3RelatedItem_1</sql>
        <sql conditional="">DROP TABLE NewsLetterV3RelatedItem_1</sql>
        <sql conditional="">ALTER TABLE [NewsLetterV3RelatedItem] ADD CONSTRAINT NewsLetterV3RelatedItem_PK PRIMARY KEY (NewsLetterID, ItemID, ItemType)</sql>
        <sql conditional="">ALTER TABLE [NewsLetterV3RelatedItem] ADD CONSTRAINT NewsLetterV3RelatedItem_FK00 FOREIGN KEY (NewsLetterID) REFERENCES NewsLetterV3NewsLetter (NewsletterID) ON DELETE CASCADE </sql>
        <sql conditional="">CREATE INDEX NewsLetterV3RelatedItem_IDX001 ON NewsLetterV3RelatedItem (NewsLetterID, ItemType)</sql>
      </NewsLetterV3RelatedItem>
    </database>
  </package>

  <package version="165" date="26-06-2007" internalversion="18.12.1.0">
    <database file="Statisticsv2.mdb">
      <StatisticNewsletterReport>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=59">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(59, 2, 'Modules - Newsletters')</sql>
      </StatisticNewsletterReport>
    </database>
  </package>

  <package version="164" date="13-06-2007" internalversion="18.11.1.0">
    <database file="Access.mdb">
      <Bug_Fix>
        <sql conditional="">UPDATE AccessCustomFieldType SET AccessCustomFieldTypeDBSQL='FLOAT NULL' WHERE AccessCustomFieldTypeDB='DOUBLE NULL'</sql>
      </Bug_Fix>
    </database>
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'NewsLetterV3'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleControlPanel, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess, ModuleIsBeta) VALUES ('NewsLetterV3', 'NewsLetterV3', 0, 0, 1, 0, 'NewsLetterV3/Default.aspx','', NULL, NULL, NULL, 1)</sql>
      </Module>
    </database>
    <folder source="Files/Templates/NewsLetterV3" target="Files/Templates" />
    <database file="Access.mdb">
      <NewsLetterV3Create>
        <sql conditional="">CREATE TABLE NewsLetterV3Attachment (AttachmentID INT IDENTITY(1,1) PRIMARY KEY, AttachmentPath MEMO NOT NULL, AttachmentNewsLetterID INT NOT NULL)</sql>
        <sql conditional="">CREATE TABLE NewsLetterV3Link (LinkID INT IDENTITY(1,1) PRIMARY KEY, LinkNewsLetterID INT NOT NULL, LinkUrl MEMO NOT NULL, LinkLastClicked DATETIME NULL, LinkFirstClicked DATETIME NULL, LinkClicks INT NULL)</sql>
        <sql conditional="">CREATE TABLE NewsLetterV3Log (LogID INT IDENTITY(1,1) PRIMARY KEY, LogAdminID INT NOT NULL, LogIP VARCHAR(50) NOT NULL, LogActionID INT NOT NULL, LogObjectID INT NOT NULL, LogDate DATETIME NOT NULL, LogDescription MEMO NULL,LogRelatedID INT NULL,LogObjectName VARCHAR(255) NULL)</sql>
        <sql conditional="">CREATE TABLE NewsLetterV3NewsLetter (NewsletterID INT IDENTITY(1,1) PRIMARY KEY, NewsletterName VARCHAR(255) NOT NULL, NewsletterSenderName VARCHAR(255) NOT NULL, NewsletterSenderEmail VARCHAR(255) NOT NULL, NewsletterReplyTo VARCHAR(255) NULL, NewsletterEncoding VARCHAR(255) NOT NULL, NewsletterSubject VARCHAR(255) NULL, NewsletterHTMLBody MEMO NULL, NewsletterHTMLBodyParsed MEMO NULL, NewsletterTextBody MEMO NULL, NewsletterSendDate DATETIME NULL, NewsletterCreateDate DATETIME NOT NULL, NewsletterSendMethod INT NOT NULL, NewsletterStyleSheetID INT NULL, NewsletterTemplateID INT NULL, NewsletterPageURL MEMO NULL, NewsletterStatusID INT NOT NULL, NewsletterMailFormat INT NOT NULL, NewsletterType INT NULL, NewsletterSubscriptionLink VARCHAR(255) NULL, NewsletterSubscriptionLinkText VARCHAR(255) NULL, NewsletterCancelLinkText VARCHAR(255) NULL, NewsletterServer MEMO NULL)</sql>
        <sql conditional="">CREATE TABLE NewsLetterV3NewsLetterCategory (NewsLetterCategoryID INT IDENTITY(1,1) PRIMARY KEY, NewsLetterCategoryCategoryID INT NOT NULL, NewsLetterCategoryNewsLetterID INT NOT NULL)</sql>
        <sql conditional="">CREATE TABLE NewsLetterV3NewsLetterItem (NewsLetterItemID INT IDENTITY(1,1) PRIMARY KEY, NewsLetterItemAccessUserID INT NOT NULL)</sql>
        <sql conditional="">CREATE TABLE NewsLetterV3NewsLetterRecipient (NewsLetterRecipientID INT IDENTITY(1,1) PRIMARY KEY, NewsLetterRecipientRecipientID INT NOT NULL, NewsLetterRecipientNewsLetterID INT NOT NULL, NewsLetterRecipientIsOpen BIT NOT NULL, NewsLetterRecipientMailFormat INT NOT NULL, NewsLetterRecipientOpenDate DATETIME NULL)</sql>
        <sql conditional="">CREATE TABLE NewsLetterV3Settings (SettingsID INT IDENTITY(1,1) PRIMARY KEY, SettingsName VARCHAR(255) NOT NULL, SettingsValue MEMO NOT NULL)</sql>
        <sql conditional="">CREATE TABLE NewsLetterV3Subscription (SubscriptionID INT IDENTITY(1,1) PRIMARY KEY, SubscriptionCategoryID INT NOT NULL, SubscriptionRecipientID INT NOT NULL, SubscriptionMailFormat INT NOT NULL)</sql>
        <sql conditional="">CREATE TABLE NewsLetterV3TempRecipient (TempRecipientRecipientID INT NOT NULL , TempRecipientSessionID VARCHAR(255) NOT NULL, TempRecipientDate DATETIME NOT NULL, TempRecipientIP VARCHAR(50) NOT NULL, TempRecipientObject MEMO NULL, PRIMARY KEY(TempRecipientRecipientID, TempRecipientSessionID))</sql>
        <sql conditional="">CREATE TABLE NewsLetterV3UserLink (UserLinkID INT IDENTITY(1,1) PRIMARY KEY, UserLinkLinkID INT NOT NULL, UserLinkUserID INT NOT NULL, UserLinkDate DATETIME NOT NULL)</sql>
        <sql conditional="">CREATE TABLE NewsLetterV3LogActions (ActionID INT PRIMARY KEY, ActionName VARCHAR(255))</sql>
        <sql conditional="">CREATE TABLE NewsLetterV3IntegrationRule (IntegrationRuleID INT IDENTITY(1,1) PRIMARY KEY, IntegrationRuleName VARCHAR(255) NULL, IntegrationRuleType INT NULL, IntegrationRulePeriod INT NULL, IntegrationRuleStartTime DATETIME NULL, IntegrationRuleLastTime DATETIME NULL, IntegrationRuleSenderName VARCHAR(255) NULL, IntegrationRuleSenderEmail VARCHAR(255) NULL, IntegrationRuleSubject VARCHAR(255) NULL, IntegrationRuleEncoding VARCHAR(255) NULL, IntegrationRuleStylesheetID INT NULL, IntegrationRuleTemplate VARCHAR(255) NULL, IntegrationRuleModuleLink MEMO NULL, IntegrationRuleNewsLetterLink MEMO NULL, IntegrationRuleCategories VARCHAR(255) NULL, IntegrationRuleModule INT NULL)</sql>
        <sql conditional="">CREATE TABLE NewsLetterV3NewsIntegration (NewsIntegrationID INT IDENTITY(1,1) PRIMARY KEY, NewsIntegrationRuleID INT NULL, NewsIntegrationNewsCategoryID INT NULL)</sql>
        <sql conditional="">CREATE TABLE NewsLetterV3IntegrationSendItem (RuleID INT NOT NULL, ItemID INT NOT NULL, CreatedDate DATETIME NOT NULL, PRIMARY KEY(RuleID, ItemID))</sql>
        <sql conditional="">CREATE TABLE NewsLetterV3RelatedItem (NewsLetterID INT NOT NULL, ItemID INT NOT NULL, NewsLetterType INT NOT NULL, PRIMARY KEY(NewsLetterID, ItemID, NewsLetterType))</sql>
      </NewsLetterV3Create>
      <NewsLetterV3AddConstraints>
        <sql conditional="">ALTER TABLE [NewsLetterV3Attachment] ADD CONSTRAINT NewsLetterV3Attachment_FK00 FOREIGN KEY (AttachmentNewsLetterID) REFERENCES NewsLetterV3NewsLetter (NewsletterID) ON DELETE CASCADE </sql>
        <sql conditional="">ALTER TABLE [NewsLetterV3Link] ADD CONSTRAINT NewsLetterV3Link_FK00 FOREIGN KEY (LinkNewsLetterID) REFERENCES NewsLetterV3NewsLetter (NewsletterID) ON DELETE CASCADE </sql>
        <sql conditional="">ALTER TABLE [NewsLetterV3Log] ADD CONSTRAINT NewsLetterV3Log_FK00 FOREIGN KEY (LogActionID) REFERENCES NewsLetterV3LogActions (ActionID) </sql>
        <sql conditional="">ALTER TABLE [NewsLetterV3NewsLetterCategory] ADD CONSTRAINT NewsLetterV3NewsLetterCat_FK00 FOREIGN KEY (NewsLetterCategoryCategoryID) REFERENCES AccessUser (AccessUserID) ON DELETE CASCADE </sql>
        <sql conditional="">ALTER TABLE [NewsLetterV3NewsLetterCategory] ADD CONSTRAINT NewsLetterV3NewsLetterCat_FK01 FOREIGN KEY (NewsLetterCategoryNewsLetterID) REFERENCES NewsLetterV3NewsLetter (NewsletterID) ON DELETE CASCADE </sql>
        <sql conditional="">ALTER TABLE [NewsLetterV3NewsLetterItem] ADD CONSTRAINT NewsLetterV3NewsLetterIte_FK00 FOREIGN KEY (NewsLetterItemAccessUserID) REFERENCES AccessUser (AccessUserID) ON DELETE CASCADE </sql>
        <sql conditional="">ALTER TABLE [NewsLetterV3NewsLetterRecipient] ADD CONSTRAINT NewsLetterV3NewsLetterRec_FK00 FOREIGN KEY (NewsLetterRecipientRecipientID) REFERENCES AccessUser (AccessUserID) ON DELETE CASCADE </sql>
        <sql conditional="">ALTER TABLE [NewsLetterV3NewsLetterRecipient] ADD CONSTRAINT NewsLetterV3NewsLetterRec_FK01 FOREIGN KEY (NewsLetterRecipientNewsLetterID) REFERENCES NewsLetterV3NewsLetter (NewsletterID) ON DELETE CASCADE </sql>
        <sql conditional="">ALTER TABLE [NewsLetterV3Subscription] ADD CONSTRAINT NewsLetterV3Subscription_FK01 FOREIGN KEY (SubscriptionRecipientID) REFERENCES AccessUser (AccessUserID) ON DELETE CASCADE </sql>
        <sql conditional="">ALTER TABLE [NewsLetterV3UserLink] ADD CONSTRAINT NewsLetterV3UserLink_FK00 FOREIGN KEY (UserLinkUserID) REFERENCES AccessUser (AccessUserID) ON DELETE CASCADE </sql>
        <sql conditional="">ALTER TABLE [NewsLetterV3UserLink] ADD CONSTRAINT NewsLetterV3UserLink_FK01 FOREIGN KEY (UserLinkLinkID) REFERENCES NewsLetterV3Link (LinkID) ON DELETE CASCADE </sql>
        <sql conditional="">ALTER TABLE [NewsLetterV3NewsIntegration] ADD CONSTRAINT NewsLetterV3NewsIntegration_FK00 FOREIGN KEY (NewsIntegrationRuleID) REFERENCES NewsLetterV3IntegrationRule (IntegrationRuleID) ON DELETE CASCADE </sql>
        <sql conditional="">ALTER TABLE [NewsLetterV3RelatedItem] ADD CONSTRAINT NewsLetterV3RelatedItem_FK00 FOREIGN KEY (NewsLetterID) REFERENCES NewsLetterV3NewsLetter (NewsletterID) ON DELETE CASCADE </sql>
      </NewsLetterV3AddConstraints>
      <NewsLetterV3InsertSettings>
        <sql conditional="SELECT * FROM [NewsLetterV3Settings] WHERE [SettingsName]='RecordsPerPage'">INSERT INTO [NewsLetterV3Settings](SettingsName, SettingsValue) VALUES('RecordsPerPage', '20')</sql>
        <sql conditional="SELECT * FROM [NewsLetterV3Settings] WHERE [SettingsName]='DropFolderPath'">INSERT INTO [NewsLetterV3Settings](SettingsName, SettingsValue) VALUES('DropFolderPath', '')</sql>
        <sql conditional="SELECT * FROM [NewsLetterV3Settings] WHERE [SettingsName]='SendMethod'">INSERT INTO [NewsLetterV3Settings](SettingsName, SettingsValue) VALUES('SendMethod', '1')</sql>
        <sql conditional="SELECT * FROM [NewsLetterV3Settings] WHERE [SettingsName]='CategoriesRootID'">INSERT INTO [NewsLetterV3Settings](SettingsName, SettingsValue) VALUES('CategoriesRootID', '')</sql>
        <sql conditional="SELECT * FROM [NewsLetterV3Settings] WHERE [SettingsName]='RecipientsRootID'">INSERT INTO [NewsLetterV3Settings](SettingsName, SettingsValue) VALUES('RecipientsRootID', '')</sql>
        <sql conditional="SELECT * FROM [NewsLetterV3Settings] WHERE [SettingsName]='AllowedFileTypes'">INSERT INTO [NewsLetterV3Settings](SettingsName, SettingsValue) VALUES('AllowedFileTypes', '')</sql>
        <sql conditional="SELECT * FROM [NewsLetterV3Settings] WHERE [SettingsName]='NotAllowedFileTypes'">INSERT INTO [NewsLetterV3Settings](SettingsName, SettingsValue) VALUES('NotAllowedFileTypes', '.ade .adp .app .asp .bas .bat .cer .chm .cmd .com .cpl .crt .csh .exe .fxp .hlp .hta .inf .ins .isp .its .js .jse .ksh .lnk .mad .maf .mag .mam .maq .mar .mas .mat .mau .mav .maw .mda .mdb .mde .mdt .mdw .mdz .msc .msi .msp .mst .ops .pcd .pif .prf .prg .pst .reg .scf .scr .sct .shb .shs .tmp .url .vb .vbe .vbs .vsmacros .vss .vst .vsw .ws .wsc .wsf .wsh ')</sql>
        <sql conditional="SELECT * FROM [NewsLetterV3Settings] WHERE [SettingsName]='AttachmentFileTypesAllow'">INSERT INTO [NewsLetterV3Settings](SettingsName, SettingsValue) VALUES('AttachmentFileTypesAllow', '1')</sql>
        <sql conditional="SELECT * FROM [NewsLetterV3Settings] WHERE [SettingsName]='AllExtranetUsersID'">INSERT INTO [NewsLetterV3Settings](SettingsName, SettingsValue) VALUES('AllExtranetUsersID', '')</sql>
        <sql conditional="SELECT * FROM [NewsLetterV3Settings] WHERE [SettingsName]='AllUsersID'">INSERT INTO [NewsLetterV3Settings](SettingsName, SettingsValue) VALUES('AllUsersID', '')</sql>
      </NewsLetterV3InsertSettings>
      <NewsLetterV3InsertLogActions>
        <sql conditional="SELECT * FROM [NewsLetterV3LogActions] WHERE [ActionID]=1">INSERT INTO [NewsLetterV3LogActions] (ActionID, ActionName) VALUES(1, 'Add Recipient')</sql>
        <sql conditional="SELECT * FROM [NewsLetterV3LogActions] WHERE [ActionID]=2">INSERT INTO [NewsLetterV3LogActions] (ActionID, ActionName) VALUES(2, 'Add Subscription')</sql>
        <sql conditional="SELECT * FROM [NewsLetterV3LogActions] WHERE [ActionID]=3">INSERT INTO [NewsLetterV3LogActions] (ActionID, ActionName) VALUES(3, 'Remove Recipient')</sql>
        <sql conditional="SELECT * FROM [NewsLetterV3LogActions] WHERE [ActionID]=4">INSERT INTO [NewsLetterV3LogActions] (ActionID, ActionName) VALUES(4, 'Remove Subscription')</sql>
        <sql conditional="SELECT * FROM [NewsLetterV3LogActions] WHERE [ActionID]=5">INSERT INTO [NewsLetterV3LogActions] (ActionID, ActionName) VALUES(5, 'Update Subscription')</sql>
      </NewsLetterV3InsertLogActions>
    </database>
  </package>

  <package version="163" date="25-07-2007" internalversion="18.12.1.1">
    <file name="Documentation.txt" overwrite="true" target="Files/Templates/Formmailer" source="Files/Templates/Formmailer" />
    <file name="Mail.html" overwrite="false" target="Files/Templates/Formmailer" source="Files/Templates/Formmailer" />
    <file name="MailConfirm.html" overwrite="false" target="Files/Templates/Formmailer" source="Files/Templates/Formmailer" />
    <file name="MailTemplate.html" overwrite="false" target="Files/Templates/Formmailer" source="Files/Templates/Formmailer" />
  </package>

  <package version="162" date="18-07-2007" internalversion="18.12.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Seo'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('Seo', 'Søgemaskineoptimering', 0, 0, 1, 0, NULL, NULL, NULL, NULL)</sql>
      </Module>
    </database>
    <file name="Links.html" overwrite="false" target="Files/Templates/Seo" source="Files/Templates/Seo" />
  </package>

  <package version="161" date="13-07-2007" internalversion="18.12.1.1">
    <database file="Dynamic.mdb">
      <SeoUsers>
        <sql conditional="">CREATE TABLE SeoUsers (SeoUserID int IDENTITY(1,1) PRIMARY KEY NOT NULL, SeoUserUserID INT NULL, SeoUserParentUserID INT NULL)</sql>
      </SeoUsers>
      <SeoHosts>
        <sql conditional="">CREATE TABLE SeoHosts (SeoHostID int IDENTITY(1,1) PRIMARY KEY NOT NULL, SeoHostUserID INT NULL, SeoHostName varchar(255) NOT NULL)</sql>
      </SeoHosts>
      <SeoUrls>
        <sql conditional="">CREATE TABLE SeoUrls (SeoUrlID int IDENTITY(1,1) PRIMARY KEY NOT NULL, SeoUrlHostID INT NULL, SeoUrlHref varchar(255) NOT NULL)</sql>
      </SeoUrls>
      <SeoPhrase>
        <sql conditional="">ALTER TABLE [SeoPhrase] ADD SeoPhraseUrlId INT</sql>
      </SeoPhrase>
      <!--<Module>
		-->
      <!--Not enabled by Default - only to be used by DW //NP-->
      <!--
		<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'SeoAdmin'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleControlPanel, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess, ModuleIsBeta) VALUES ('SeoAdmin', 'SEO Administration', 0, 0, 1, 0, NULL,'', NULL, NULL, NULL, 1)</sql>
	  </Module>-->
    </database>
  </package>
  <package version="160" date="11-06-2007" internalversion="18.12.1.1">
    <database file="Dynamic.mdb">
      <Module>
        <sql>UPDATE [Module] SET ModuleIsBeta = blnFalse WHERE ModuleSystemName = 'NewsV2'</sql>
        <sql>DELETE FROM [Module] WHERE ModuleSystemName = 'News2' AND NOT ModuleScript LIKE '%CustomModules%'</sql>
      </Module>
    </database>
  </package>

  <package version="158" date="05-06-2006" internalversion="18.12.1.0">
    <file name="storelocator_frontend.swf" overwrite="true" target="Files/Templates/Dealersearch" source="Files/Templates/Dealersearch" />
    <file name="storelocator_info_image_template.fla" overwrite="true" target="Files/Templates/Dealersearch" source="Files/Templates/Dealersearch" />
  </package>

  <package version="157" date="25-05-2007" internalversion="18.12.1.0">
    <database file="Ipaper.mdb">
      <Module>
        <sql>UPDATE [IpaperLanguageKeys] SET FriendlyName = 'Indeks titel' WHERE LanguageKeyID = 13</sql>
        <sql>UPDATE [IpaperLanguageKeys] SET FriendlyName = 'Arkiv titel' WHERE LanguageKeyID = 14</sql>
        <sql>UPDATE [IpaperLanguageKeys] SET FriendlyName = 'Arkiv ikon' WHERE LanguageKeyID = 17</sql>
        <sql>UPDATE [IpaperLanguageKeys] SET FriendlyName = 'Indeks ikon' WHERE LanguageKeyID = 18</sql>
      </Module>
    </database>
  </package>

  <package version="156" date="22-05-2007" internalversion="18.12.1.0">
    <database file="Ipaper.mdb">
      <Module>
        <Transaction>
          <sql>CREATE TABLE [IpaperCategories]( CategoryID [int] IDENTITY(1,1) NOT NULL, [Name] [varchar](50) NOT NULL )</sql>
          <sql>CREATE TABLE [IpaperLanguageKeys] ( LanguageKeyID [int] NOT NULL, [Name] [varchar](50) NOT NULL, DefaultValue [varchar](255) NOT NULL, Visible [bit] NOT NULL, FriendlyName [varchar](128) NOT NULL )</sql>
          <sql>CREATE TABLE [IpaperLanguageKeyValues] ( LanguageKeyValueID [int] IDENTITY(1,1) NOT NULL, LanguageID [int] NOT NULL, LanguageKeyID [int] NOT NULL, [Value] [varchar](255) NOT NULL ) </sql>
          <sql>CREATE TABLE [IpaperLanguages] ( LanguageID [int] IDENTITY(1,1) NOT NULL, [Name] [varchar](50) NOT NULL, SystemLanguage [bit] NOT NULL ) </sql>
          <sql>CREATE TABLE [IpaperPages] ( PageID [int] IDENTITY(1,1) NOT NULL, [Index] [varchar](255) NOT NULL, PaperID [int] NOT NULL, Number [int] NOT NULL ) </sql>
          <sql>CREATE TABLE [IpaperPapers] ( PaperID [int] IDENTITY(1,1) NOT NULL, [Name] [varchar](50) NOT NULL, CategoryID [int] NOT NULL, SettingSetID [int] NOT NULL, LanguageID [int] NOT NULL, LastProcessedDate [datetime] NULL, LastProcessedPDF [varchar](255) NULL, ThumbHeight [int] NULL, SmallHeight [int] NULL, LargeHeight [int] NULL, Archive [bit] NOT NULL, Logo [varchar](255) NOT NULL, LogoURL [varchar](255) NOT NULL ) </sql>
          <sql>CREATE TABLE [IpaperSettingDescriptions] ( DescriptionID [int] NOT NULL, [Name] [varchar](50) NOT NULL, ObjectSetting [bit] NOT NULL, DefaultValue [varchar](50) NOT NULL, GroupID [int] NOT NULL, TypeID [int] NOT NULL, Hidden [bit] NOT NULL, Description [varchar](128) ) </sql>
          <sql>CREATE TABLE [IpaperSettingGroups] ( GroupID [int] NOT NULL, [Name] [varchar](50) NOT NULL, Number [int] NOT NULL )</sql>
          <sql>CREATE TABLE [IpaperSettings] ( SettingID [int] IDENTITY(1,1) NOT NULL, SetID [int] NOT NULL, DescriptionID [int] NOT NULL, [Value] [varchar](255) NOT NULL ) </sql>
          <sql>CREATE TABLE [IpaperSettingSets] ( SetID [int] IDENTITY(1,1) NOT NULL, [Name] [varchar](50) NOT NULL ) </sql>
          <sql>CREATE TABLE [IpaperSettingTypes] ( TypeID [int] NOT NULL, [Name] [varchar](50) NOT NULL, FieldWidth [int] NOT NULL, FieldHeight [int] NOT NULL ) </sql>
          <sql>INSERT INTO [IpaperSettingTypes] (TypeID, [Name], FieldWidth, FieldHeight) VALUES (1, 'string', 250, 0)</sql>
          <sql>INSERT INTO [IpaperSettingTypes] (TypeID, [Name], FieldWidth, FieldHeight) VALUES (2, 'int', 50, 0)</sql>
          <sql>INSERT INTO [IpaperSettingTypes] (TypeID, [Name], FieldWidth, FieldHeight) VALUES (3, 'datetime', 100, 0)</sql>
          <sql>INSERT INTO [IpaperSettingTypes] (TypeID, [Name], FieldWidth, FieldHeight) VALUES (4, 'color', 70, 0)</sql>
          <sql>INSERT INTO [IpaperSettingTypes] (TypeID, [Name], FieldWidth, FieldHeight) VALUES (5, 'float', 50, 0)</sql>
          <sql>INSERT INTO [IpaperSettingTypes] (TypeID, [Name], FieldWidth, FieldHeight) VALUES (6, 'bool', 0, 0)</sql>
          <sql>INSERT INTO [IpaperSettingTypes] (TypeID, [Name], FieldWidth, FieldHeight) VALUES (7, 'url', 250, 0)</sql>
          <sql>INSERT INTO [IpaperSettingTypes] (TypeID, [Name], FieldWidth, FieldHeight) VALUES (8, 'transition', 0, 0)</sql>
          <sql>INSERT INTO [IpaperSettingTypes] (TypeID, [Name], FieldWidth, FieldHeight) VALUES (9, 'swf', 0, 0)</sql>
          <sql>INSERT INTO [IpaperSettingTypes] (TypeID, [Name], FieldWidth, FieldHeight) VALUES (10, 'folder', 0, 0)</sql>
          <sql>INSERT INTO [IpaperSettingTypes] (TypeID, [Name], FieldWidth, FieldHeight) VALUES (11, 'text', 350, 150)</sql>
          <sql>INSERT INTO [IpaperSettingGroups] (GroupID, [Name], Number) VALUES (3, 'Interface farver', 3)</sql>
          <sql>INSERT INTO [IpaperSettingGroups] (GroupID, [Name], Number) VALUES (9, 'Funktioner', 1)</sql>
          <sql>INSERT INTO [IpaperSettingGroups] (GroupID, [Name], Number) VALUES (10, 'Tekst farver', 2)</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (28, 'iconNavBar', 0, 'true', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (20, 'zoomPageBorderColor', 0, '0x999999', 3, 4, 0, 'Zoom page border color')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (21, 'thumbBgColor', 0, '0x111111', 3, 4, 0, 'Thumb background color')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (22, 'thumbBgHoverColor', 0, '0xEA2514', 3, 4, 0, 'Thumb background hover color')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (23, 'thumbTxtColor', 0, '0xEA2514', 10, 4, 0, 'Thumb txt color')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (24, 'thumbTxtHoverColor', 0, '0x111111', 10, 4, 0, 'Thumb txt hover color')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (25, 'thumbPutEase', 0, 'Regular.easeOut', 3, 10, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (1, 'firstPage', -1, '0', 3, 2, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (27, 'iconClose', 0, 'true', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (17, 'userPreloaderId', -1, 'DefaultLoader', 3, 1, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (29, 'iconHelp', 0, 'false', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (30, 'iconPdf', 0, 'true', 9, 6, 0, 'PDF ikon')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (31, 'iconThumb', 0, 'true', 9, 6, 0, 'Thumb ikon')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (32, 'iconArchive', 0, 'false', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (33, 'iconIndex', 0, 'false', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (34, 'iconTipAFriend', 0, 'false', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (26, 'iPaperInterfaceIcons', 0, 'default', 3, 1, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (10, 'cachePages', -1, 'true', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (2, 'alwaysOpened', -1, 'false', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (3, 'autoFlip', -1, '50', 3, 2, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (4, 'moveSpeed', -1, '3', 3, 2, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (5, 'closeSpeed', -1, '3', 3, 2, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (6, 'gotoSpeed', -1, '3', 3, 2, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (7, 'flipSound', -1, '', 3, 10, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (19, 'zoomPageBgColor', 0, '0xFFFFFF', 3, 4, 0, 'Zoom page background color')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (9, 'loadOnDemand', -1, 'true', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (18, 'zoomPaginEase', 0, 'Regular.easeOut', 3, 10, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (11, 'usePreloader', -1, 'true', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (12, 'scaleContent', -1, 'true', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (13, 'staticShadowsDepth', -1, '1.0', 3, 5, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (14, 'dynamicShadowsDepth', -1, '1.0', 3, 5, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (15, 'cacheSize', -1, '4', 3, 2, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (16, 'preloaderType', -1, 'User Defined', 3, 1, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (37, 'zoomPutEase', 0, 'Regular.easeOut', 3, 10, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (8, 'pageBack', -1, '0xFFFFFF', 3, 4, 0, 'Color on the back of the pages')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (63, 'interfaceMainBgColor2', 0, '0xF5F5F5', 3, 4, 0, 'Interface main bg color 2')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (35, 'iconSearch', 0, 'false', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (56, 'hasNewsTicker', 0, 'false', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (57, 'interfaceHasGlow', 0, 'true', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (58, 'startPage', 0, 'iPaper', 3, 1, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (59, 'GUI', 0, 'autoSize', 3, 1, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (60, 'interfaceWindowBgColor1', 0, '0xFFFFFF', 3, 4, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (54, 'interfaceSearch', 0, 'default.swf', 3, 11, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (62, 'interfaceMainBgColor1', 0, '0xF5F5F5', 3, 4, 0, 'Interface main bg color 1')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (53, 'hasZoomLinks', 0, 'false', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (64, 'interfaceElementsColor', 0, '0xFFFFFF', 3, 4, 0, 'Interface elements color')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (65, 'pageInfoColor', 0, '0x000000', 10, 4, 0, 'Page info color')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (66, 'pageInfoArrowColor', 0, '0x000000', 10, 4, 0, 'Page info arrow color')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (67, 'iconFrontendBuilder', 0, 'false', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (68, 'interfaceFrontendBuilder', 0, 'default.swf', 3, 11, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (69, 'flipCorner', 0, 'true', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (70, 'enableGoogleIndexing', 0, 'true', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (61, 'interfaceWindowBgColor2', 0, '0xFFFFFF', 3, 4, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (45, 'hoverBgColor', 0, '0x111111', 3, 4, 0, 'Hover background color')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (71, 'interfaceLoginFile', 0, 'default.swf', 3, 11, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (38, 'zoomThumbEase', 0, 'Regular.easeOut', 3, 10, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (39, 'interfaceTipAFriend', 0, 'default.swf', 3, 11, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (40, 'interfaceIndex', 0, 'default.swf', 3, 11, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (41, 'interfaceArchive', 0, 'default.swf', 3, 11, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (42, 'interfaceZoomPagingArrow', 0, 'default.swf', 3, 11, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (55, 'clientLogoAlign', 0, 'left', 3, 1, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (44, 'iPaperBgColor', 0, '0x777777', 3, 4, 0, 'iPaper background color')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (36, 'interfaceBgColor', 0, '0xFFFFFF', 3, 4, 0, 'Interface background color')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (46, 'hoverBorderColor', 0, '0x000000', 3, 4, 0, 'Hover border color')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (47, 'hoverFontColor', 0, '0xFFFFFF', 10, 4, 0, 'Hover font color')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (48, 'interfaceHelp', 0, 'default.swf', 3, 11, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (49, 'interfaceZoomIcon', 0, 'default.swf', 3, 11, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (50, 'showHelp', 0, 'false', 3, 6, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (51, 'clientCredit', 0, '', 3, 1, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (52, 'interfaceZoomHelp', 0, 'default.swf', 3, 11, -1, '-')</sql>
          <sql>INSERT INTO [IpaperSettingDescriptions] (DescriptionID, [Name], ObjectSetting, DefaultValue, GroupID, TypeID, Hidden, Description) VALUES (43, 'iconPrint', 0, 'true', 9, 6, 0, 'Print icon')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (1, 'taf_titleBarHeader', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (2, 'taf_titleThumbHeader', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (3, 'taf_yourNameHeader', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (4, 'taf_yourEmailHeader', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (5, 'taf_friendNameHeader', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (6, 'taf_friendEmailHeader', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (7, 'taf_messageHeader', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (8, 'taf_yourNameErrorReply', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (9, 'taf_yourEmailErrorReply', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (10, 'taf_friendNameErrorReply', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (11, 'taf_friendEmailErrorReply', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (12, 'taf_send', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (13, 'index_titleBarHeader', 'Index', -1, 'Indeks titel')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (14, 'archive_titleBarHeader', 'Archive', -1, 'Arkiv titel')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (15, 'hover_clientLogo', 'Visit the website', -1, 'Besøg websiden')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (16, 'hover_thumb', 'Overview', -1, 'Oversigt')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (17, 'hover_archive', 'Archive', -1, 'Arkiv ikon')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (18, 'hover_index', 'Index', -1, 'Indeks ikon')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (19, 'hover_tipAFriend', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (20, 'hover_printLeftPage', 'Print left page', -1, 'Print venstre side')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (21, 'hover_printRightPage', 'Print right page', -1, 'Print højre side')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (22, 'hover_pdf', 'Download PDF file', -1, 'Download PDF')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (23, 'help_titleBarHeader', 'Help', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (24, 'help_body', 'Hover over the dots to learn how to use iPaper.', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (25, 'help_credit', 'You can zoom in closer using the mouse wheel. You can enter a page number and jump directly to the page. Pressing space takes you back to the starting point. You can flip through the pages using the arrow keys.', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (26, 'help_logoAreaDot', 'Click the logo to visit the website.', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (27, 'help_closeAreaDot', 'Here, you can close the iPaper application. Here, you will also find the Help icon.', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (28, 'help_zoomAreaDot', 'Click to zoom in. Click again to zoom out. You can zoom further using the mouse wheel.', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (29, 'help_cornerPagedragAreaDot', 'You can drag the page.', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (30, 'help_sidePagedragAreaDot', 'You can drag the page.', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (31, 'help_iconAreaDot', 'Here, you will find a menu with shortcuts to Overview, Tell a friend etc.', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (32, 'help_navAreaDot', 'Here, you can flip through the pages.', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (33, 'help_printAreaDot', 'Here, you can print the selected pages.', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (34, 'hover_help', 'Help', -1, 'Hjælp')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (35, 'hover_showHelpZoom', 'Click the image to zoom out.', -1, 'Zoom ud tekst')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (36, 'credit', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (37, 'help_zoomOutDot', 'Click again to zoom out.', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (38, 'help_zoomPaginLeft', 'Click here to go to the previous page.', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (39, 'help_zoomPaginRight', 'Click here to go to the next page.', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (40, 'taf_mailSubject', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (41, 'taf_mailBody', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (42, 'taf_replySendOK', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (43, 'search_titleBarHeader', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (44, 'search_introText', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (45, 'search_keyWord', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (46, 'search_result', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (47, 'search_btn', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (48, 'search_hover', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (49, 'fullscreen_openFullScreen', 'Open full screen', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (50, 'fullscreen_openNormal', 'Open normal', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (51, 'hover_search', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (52, 'builder_create', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (53, 'builder_doSendMail', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (54, 'builder_yes', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (55, 'builder_no', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (56, 'builder_recipientName', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (57, 'builder_recipientEmail', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (58, 'builder_senderName', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (59, 'builder_senderEmail', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (60, 'builder_emailMessage', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (61, 'builder_iPaperFrontPageMessage', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (62, 'builder_replaceFrontPageText', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (63, 'builder_addBeforeFrontPageText', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (64, 'builder_addAfterFrontPageText', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (65, 'builder_doCreate', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (66, 'builder_directURL', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (67, 'builder_recipientNameErrorReply', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (68, 'builder_recipientEmailErrorReply', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (69, 'builder_senderNameErrorReply', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (70, 'builder_senderEmailErrorReply', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (71, 'builder_isCreating', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (72, 'builder_serverError', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (73, 'builder_mailBody', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (74, 'hover_frontendBuilder', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (75, 'taf_subjectHeader', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (76, 'taf_subjectErrorReply', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (77, 'builder_leaveFrontPageText', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (78, 'builder_pagesMustBeEvenNumber', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (79, 'builder_introText', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (80, 'builder_exit', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (81, 'builder_titleBarHeader', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (82, 'builder_recipientSubjectErrorReply', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (83, 'builder_subject', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (84, 'login_Header', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (85, 'login_text', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (86, 'login_name', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (87, 'login_password', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (88, 'login_submit', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (89, 'login_pleaseFillIn', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (90, 'login_error', '', 0, '')</sql>
          <sql>INSERT INTO [IpaperLanguageKeys] (LanguageKeyID, [Name], DefaultValue, Visible, FriendlyName) VALUES (91, 'hover_exit', 'Close', -1, 'Luk')</sql>
          <sql>INSERT INTO [IpaperLanguages] ([Name], SystemLanguage) VALUES ('English', 0)</sql>
          <sql>INSERT INTO [IpaperLanguageKeyValues] (LanguageID, LanguageKeyID, [Value]) SELECT (SELECT LanguageID FROM [IpaperLanguages] WHERE Name = 'English'), LanguageKeyID, DefaultValue FROM [IpaperLanguageKeys] WHERE Visible = 1</sql>
          <sql>INSERT INTO [IpaperSettingSets] ([Name]) VALUES ('Standard')</sql>
          <sql>INSERT INTO [IpaperSettings] (SetID, DescriptionID, [Value]) SELECT (SELECT SetID FROM [IpaperSettingSets] WHERE [Name] = 'Standard'), DescriptionID, DefaultValue FROM [IpaperSettingDescriptions]</sql>
        </Transaction>
      </Module>
    </database>
  </package>

  <package version="155" date="21-05-2007" internalversion="18.12.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql>UPDATE Template SET TemplateSettings = 'Align="right" vspace="5" hspace="5"' WHERE TemplateSettings = 'Align=right vspace=5 hspace=5'</sql>
        <sql>UPDATE Template SET TemplateSettings = 'Align="Left" vspace="5" hspace="5"' WHERE TemplateSettings = 'Align=Left vspace=5 hspace=5'</sql>
      </Module>
    </database>
  </package>

  <package version="154" date="16-05.2007" internalversion="18.12.1.0">
    <!--
    <file name="MasterEdit.html" overwrite="false" target="Files/Templates/Employee/FrontendEdit" source="Files/Templates/Employee/FrontendEdit" />
    <file name="TableEdit.html" overwrite="false" target="Files/Templates/Employee/FrontendEdit" source="Files/Templates/Employee/FrontendEdit" />
    <file name="DepartmentPresent.html" overwrite="false" target="Files/Templates/Employee/Presentation" source="Files/Templates/Employee/Presentation" />
    <file name="NormalEmployeePresentation.html" overwrite="false" target="Files/Templates/Employee/Presentation" source="Files/Templates/Employee/Presentation" />
    -->
  </package>

  <package version="153" date="25-04-2007" internalversion="18.12.1.0">
    <database file="Dynamic.mdb">
      <ScheduledTaskType>
        <sql conditional="SELECT * FROM ScheduledTaskType WHERE TypeName='DB Integration Job'">
          INSERT INTO [ScheduledTaskType](TypeName) VALUES('DB Integration Job')
        </sql>
      </ScheduledTaskType>
    </database>
  </package>

  <package version="152" date="25-04-2007" internalversion="18.11.1.0">
    <file name="Link.html" target="Files/Templates/Ipaper" source="Files/Templates/Ipaper" />
    <!--<file name="Ipaper.mdb" target="Database" source="Database" />-->
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Ipaper'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleControlPanel, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess, ModuleIsBeta) VALUES ('Ipaper', 'Ipaper', 0, 0, 1, 0, 'Ipaper/IpaperCategoryList.aspx','', NULL, NULL, NULL, 1)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'IpaperExtended'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleControlPanel, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess, ModuleIsBeta) VALUES ('IpaperExtended', 'Ipaper extended', 0, 0, 0, 0, NULL,'', NULL, NULL, NULL, 1)</sql>
        <sql conditional="">UPDATE [Module] SET ModuleControlpanel = 'News_cpl.aspx' WHERE ModuleSystemName = 'News'</sql>
      </Module>
    </database>
  </package>

  <package version="151" date="25-04-2007" internalversion="18.11.1.0">
    <database file="DBIntegration.mdb">
      <Map>
        <sql conditional="">ALTER TABLE [Map] ADD MapTargetReferenceField VARCHAR (255)</sql>
        <sql conditional="">ALTER TABLE [Map] ADD MapTargetReferenceTableID INT</sql>
      </Map>
    </database>
  </package>

  <package version="150" date="17-04-2007" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleHiddenMode = blnFalse, ModuleIsBeta = blnFalse WHERE ModuleSystemName = 'Calender' OR ModuleSystemName = 'Calendar'</sql>
      </Module>
    </database>
  </package>

  <package version="149" date="16-04-2007" internalversion="18.11.1.0">
    <database file="Access.mdb">
      <AccessWorkflow>
        <sql conditional="SELECT * FROM AccessWorkflow WHERE AccessWorkflowTitle='Kladde' OR AccessWorkflowTitle='Draft'">INSERT INTO AccessWorkflow(AccessWorkflowTitle, AccessWorkflowCreatedDate, AccessWorkflowNotifyTemplate, AccessWorkflowRequiredTemplate) VALUES('Draft', Now(), 'NotifyOnly.html', 'Required.html')</sql>
      </AccessWorkflow>
    </database>
  </package>

  <package version="148" date="04-04-2007" internalversion="18.11.1.0">
    <database file="DBIntegration.mdb">
      <Map>
        <sql conditional="">ALTER TABLE [Map] ADD MapTargetFieldType VARCHAR (255)</sql>
        <sql conditional="">ALTER TABLE [Map] ADD MapTargetFieldIsUnique BIT</sql>
      </Map>
    </database>
  </package>

  <package version="147" date="30-03-2007" internalversion="18.11.1.0">
    <!--
    <database file="NewsLetterExtended.mdb">
      <WeblogSettings>
        <sql conditional="SELECT * FROM [NewsletterExtendedRecipient] WHERE NewsletterRecipientConfirmed = -1">UPDATE [NewsletterExtendedRecipient] SET NewsletterRecipientConfirmed = -1</sql>
      </WeblogSettings>
    </database>
    -->
  </package>
  <package version="146" date="30-03-2007" internalversion="18.11.1.0">
    <!--
    <database file="NewsLetterExtended.mdb">
      <WeblogSettings>
        <sql conditional="SELECT * FROM [NewsletterExtendedRecipient] WHERE NewsletterRecipientConfirmed = -1">UPDATE [NewsletterExtendedRecipient] SET NewsletterRecipientConfirmed -1</sql>
      </WeblogSettings>
    </database>
    -->
  </package>

  <package version="145" date="28-03-2007" internalversion="18.11.1.0">
    <!--
    <database file="Dynamic.mdb">
      <Intranote>
        <sql conditional="SELECT * FROM IntranotePostType WHERE TypeName='Shortcut'">INSERT INTO IntranotePostType (TypeName) VALUES ('Shortcut')</sql>
      </Intranote>
    </database>
    -->
  </package>

  <package version="144" date="26-03-2007" internalversion="18.11.1.0">
    <!--
    <database file="NewsLetterExtended.mdb">
      <WeblogSettings>
        <sql conditional="">ALTER TABLE [NewsletterExtendedRecipient] ADD NewsletterRecipientConfirmed BIT Default -1</sql>
      </WeblogSettings>
    </database>
    -->
  </package>

  <package version="143" date="26-03-2007" internalversion="18.11.1.0">
    <!--<file name="CompetencePresent.html" target="Files/Templates/Employee/Presentation" source="Files/Templates/Employee/Presentation" />-->
  </package>
  <package version="142" date="26-03-2007" internalversion="18.11.1.0">
    <!--<file name="ForumV2EditorExtended.html" target="Files/Templates/ForumV2/ForumV2Editor" source="Files/Templates/ForumV2/ForumV2Editor" />-->
  </package>

  <package version="141" date="23-03-2007" internalversion="18.11.1.0">
    <database file="DbPub.mdb">
      <DBPubAssociate>
        <sql conditional="">CREATE TABLE DBPubAssociate (DBPubAssociateID int IDENTITY(1,1) PRIMARY KEY NOT NULL, DBPubAssociateViewID INT NULL, DBPubAssociateFieldID INT NULL, DBPubAssociateSourceViewID INT NULL, DBPubAssociateKeyFieldID INT NULL, DBPubAssociateValueFieldID INT NULL )</sql>
        <sql conditional="">ALTER TABLE DBPubAssociate ADD FOREIGN KEY (DBPubAssociateViewID) REFERENCES DBPubView (DBPubViewID)</sql>
        <sql conditional="">ALTER TABLE DBPubAssociate ADD FOREIGN KEY (DBPubAssociateFieldID) REFERENCES DBPubField (DBPubFieldID)</sql>
      </DBPubAssociate>
    </database>
  </package>

  <package version="140" date="16-03-2007" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleHiddenMode = 0 WHERE ModuleSystemName IN ('DBIntegration', 'ForumV2', 'Survey', 'Weblog', 'SitemapV2')</sql>
      </Module>
    </database>
  </package>

  <package version="139" date="14-03-2007" internalversion="18.11.1.0">
    <!--
    <database file="ForumV2.mdb">
      <AccessUser>
        <sql conditional="">ALTER TABLE ForumV2Category ADD ForumV2CategoryHtmlEditorTypeID INT DEFAULT 1</sql>
        <sql conditional="">ALTER TABLE ForumV2Category DROP ForumV2CategoryHTMLAllowed</sql>
      </AccessUser>
    </database>
    <file name="ForumV2EditorExtended.html" target="Files/Templates/ForumV2/ForumV2Editor" source="Files/Templates/ForumV2/ForumV2Editor" />
    -->
  </package>

  <package version="138" date="09-03-2007" internalversion="18.11.1.0">
    <database file="DbPub.mdb">
      <sql conditional="">CREATE TABLE DBPubSubscriber (DBPubSubscriberId int IDENTITY(1,1) PRIMARY KEY NOT NULL, DBPubSubscriberUserId INT NULL, DBPubSubscriberViewId INT NULL )</sql>
    </database>
  </package>

  <package version="137" date="28-02-2007" internalversion="18.11.1.0">
    <database file="Access.mdb">
      <AccessUser>
        <!--<sql conditional="">CREATE TABLE HRAccessUser (HRAccessUserID INT)</sql>
        <sql conditional="">INSERT INTO HRAccessUser (HRAccessUserID) SELECT AccessUserID from AccessUser WHERE AccessUserType IN (30, 31)</sql>-->
        <sql conditional="">UPDATE AccessUser SET AccessUserParentID = 255 WHERE AccessUserParentID = 0 AND AccessUserType = 31</sql>
        <sql conditional="">UPDATE AccessUser SET AccessUserType = 11 WHERE AccessUserType = 31</sql>
        <sql conditional="">UPDATE AccessUser SET AccessUserType = 15 WHERE AccessUserType = 30</sql>
        <sql conditional="">UPDATE AccessType SET AccessTypeID = 11 WHERE AccessTypeID = 31</sql>
        <sql conditional="">UPDATE AccessType SET AccessTypeID = 15 WHERE AccessTypeID = 30</sql>
        <!--<sql conditional="">ALTER TABLE HRAccessUser ADD FOREIGN KEY (HRAccessUserID) REFERENCES AccessUser(AccessUserID) ON DELETE CASCADE</sql>-->
      </AccessUser>
    </database>
  </package>

  <package version="136" date="19-01-2007" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleIsBeta = 0 WHERE ModuleSystemName IN ('DBIntegration', 'ForumV2', 'Survey', 'Weblog', 'SitemapV2')</sql>
      </Module>
    </database>
  </package>

  <package version="135" date="24-01-2007" internalversion="18.11.1.0">
    <database file="Survey.mdb">
      <Module>
        <sql conditional="">ALTER TABLE SurveyResult ALTER COLUMN SurveyResultText MEMO NULL</sql>
      </Module>
    </database>
  </package>

  <package version="134" date="24-01-2007" internalversion="18.11.1.0">
    <folder source="Files/Templates/NewsV2" target="Files/Templates" />
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">ALTER TABLE NewsCategory ALTER COLUMN NewsCategoryName VARCHAR (255) NULL</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'NewsV2'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleControlPanel, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess, ModuleIsBeta) VALUES ('NewsV2', 'NewsV2', 0, 0, 1, 0, 'NewsV2/News_Category_List.aspx','', NULL, NULL, NULL, 1)</sql>
      </Module>
    </database>
    <!--<folder source="Files/Templates/Weblog" target="Files/Templates" />-->
    <database file="DbPub.mdb">
      <Module>
        <sql conditional="">ALTER TABLE DBPubControl ALTER COLUMN DBPubControlName VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubField ALTER COLUMN DBPubFieldTable VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubField ALTER COLUMN DBPubFieldAlly VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubField ALTER COLUMN DBPubFieldName VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubField ALTER COLUMN DBPubFieldDBType VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubMail ALTER COLUMN DBPubMailAddress VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubMail ALTER COLUMN DBPubMailTitle VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewName VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewTable VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewServer VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewUser VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewPassword VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewWhereField VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewWhereCompare VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewWhereValue VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewJoinTable VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewJoinViewField VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewJoinJoinField VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewOrderByClause VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewOrderByOrder VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewFolder VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewMasterList VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewRow VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewView VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ALTER COLUMN DBPubViewEdit VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE Relation ALTER COLUMN RelationParentField VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE Relation ALTER COLUMN RelationChildField VARCHAR (255) NULL</sql>
      </Module>
    </database>
    <database file="Access.mdb">
      <Module>
        <sql conditional="">ALTER TABLE AccessCustomFieldType ADD AccessCustomFieldTypeDBSQL VARCHAR (50) NULL</sql>
        <sql conditional="">UPDATE AccessCustomFieldType SET AccessCustomFieldTypeDBSQL=AccessCustomFieldTypeDB</sql>
        <sql conditional="">UPDATE AccessCustomFieldType SET AccessCustomFieldTypeDBSQL='NTEXT NULL' WHERE AccessCustomFieldTypeDB='MEMO NULL'</sql>
        <sql conditional="">UPDATE AccessCustomFieldType SET AccessCustomFieldTypeDBSQL='INT NULL' WHERE AccessCustomFieldTypeDB='LONG NULL'</sql>
        <sql conditional="">UPDATE AccessCustomFieldType SET AccessCustomFieldTypeDBSQL='DATETIME NULL' WHERE AccessCustomFieldTypeDB='DATE NULL'</sql>
        <sql conditional="">UPDATE AccessCustomFieldType SET AccessCustomFieldTypeDBSQL='DOUBLE NULL' WHERE AccessCustomFieldTypeDB='REAL NULL'</sql>
      </Module>
    </database>
  </package>

  <package version="133" date="07-02-2007" internalversion="18.11.1.0">
    <folder source="Files/Templates/StatisticsExtended" target="Files/Templates" />
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleParagraph = 1 WHERE ModuleSystemName = 'StatisticsExtended'</sql>
      </Module>
    </database>
  </package>
  <package version="132" date="01-02-2007" internalversion="18.11.1.0">
    <file name="styles.xml" target="Files/System" source="Files/System" /> <!-- WHY DO THIS AGAIN?? -->
  </package>


  <package version="131" date="30-01-2007" internalversion="18.11.1.0">
    <!--<file name="LatestPosts.html" target="Files/Templates/Weblog/Articles" source="Files/Templates/Weblog/Articles" />-->
  </package>

  <package version="130" date="30-01-2007" internalversion="18.11.1.0">
    <file name="styles.xml" target="Files/System" source="Files/System" /> <!-- MAYBE THIS SHOULD BE REMOVED TOO? -->

    <!--
    <file name="EditArticle.html" target="Files/Templates/Weblog/Articles" source="Files/Templates/Weblog/Articles" />
    <file name="ListArchive.html" target="Files/Templates/Weblog/Articles" source="Files/Templates/Weblog/Articles" />
    <file name="ListArticle.html" target="Files/Templates/Weblog/Articles" source="Files/Templates/Weblog/Articles" />
    <file name="ShowArticle.html" target="Files/Templates/Weblog/Articles" source="Files/Templates/Weblog/Articles" />

    <file name="EditProfile.html" target="Files/Templates/Weblog/Authorized" source="Files/Templates/Weblog/Authorized" />
    <file name="EmailedPassword.html" target="Files/Templates/Weblog/Authorized" source="Files/Templates/Weblog/Authorized" />
    <file name="ForgotPassword.html" target="Files/Templates/Weblog/Authorized" source="Files/Templates/Weblog/Authorized" />
    <file name="Login.html" target="Files/Templates/Weblog/Authorized" source="Files/Templates/Weblog/Authorized" />
    <file name="Notify.html" target="Files/Templates/Weblog/Authorized" source="Files/Templates/Weblog/Authorized" />
    <file name="PasswordSent.html" target="Files/Templates/Weblog/Authorized" source="Files/Templates/Weblog/Authorized" />
    <file name="PermissionDenied.html" target="Files/Templates/Weblog/Authorized" source="Files/Templates/Weblog/Authorized" />
    <file name="UserInfo.html" target="Files/Templates/Weblog/Authorized" source="Files/Templates/Weblog/Authorized" />

    <file name="EditBlog.html" target="Files/Templates/Weblog/Blogs" source="Files/Templates/Weblog/Blogs" />
    <file name="ListBlog.html" target="Files/Templates/Weblog/Blogs" source="Files/Templates/Weblog/Blogs" />

    <file name="EditCategory.html" target="Files/Templates/Weblog/Categories" source="Files/Templates/Weblog/Categories" />
    <file name="ListCategory.html" target="Files/Templates/Weblog/Categories" source="Files/Templates/Weblog/Categories" />

    <file name="CommentingDenied.html" target="Files/Templates/Weblog/Comments" source="Files/Templates/Weblog/Comments" />
    <file name="EditComment.html" target="Files/Templates/Weblog/Comments" source="Files/Templates/Weblog/Comments" />
    <file name="ListComment.html" target="Files/Templates/Weblog/Comments" source="Files/Templates/Weblog/Comments" />

    <file name="Add.html" target="Files/Templates/Weblog/Other" source="Files/Templates/Weblog/Other" />
    <file name="EditRow.html" target="Files/Templates/Weblog/Other" source="Files/Templates/Weblog/Other" />
    <file name="MainMenu.html" target="Files/Templates/Weblog/Other" source="Files/Templates/Weblog/Other" />

    <file name="Page.html" target="Files/Templates/Weblog/Paging" source="Files/Templates/Weblog/Paging" />
    <file name="PageElement.html" target="Files/Templates/Weblog/Paging" source="Files/Templates/Weblog/Paging" />
    <file name="PageElementSelected.html" target="Files/Templates/Weblog/Paging" source="Files/Templates/Weblog/Paging" />

    <file name="Search.html" target="Files/Templates/Weblog/Search" source="Files/Templates/Weblog/Search" />
    <file name="SearchResults.html" target="Files/Templates/Weblog/Search" source="Files/Templates/Weblog/Search" />

    <file name="NewPost.html" target="Files/Templates/Weblog/Settings" source="Files/Templates/Weblog/Settings" />
    <file name="NewPostRow.html" target="Files/Templates/Weblog/Settings" source="Files/Templates/Weblog/Settings" />

    <file name="EditTeam.html" target="Files/Templates/Weblog/Shared" source="Files/Templates/Weblog/Shared" />
    <file name="ListTeam.html" target="Files/Templates/Weblog/Shared" source="Files/Templates/Weblog/Shared" />

    <file name="AddSubscriber.html" target="Files/Templates/Weblog/Subscription" source="Files/Templates/Weblog/Subscription" />
    <file name="SubscriberAdded.html" target="Files/Templates/Weblog/Subscription" source="Files/Templates/Weblog/Subscription" />
    -->
  </package>

  <package version="129" date="24-01-2007" internalversion="18.11.1.0">
    <!--
    <file name="EditTeam.html" target="Files/Templates/Weblog/Shared" source="Files/Templates/Weblog/Shared" />
    <file name="EditProfile.html" target="Files/Templates/Weblog/Authorized" source="Files/Templates/Weblog/Authorized" />
    <file name="EditCategory.html" target="Files/Templates/Weblog/Categories" source="Files/Templates/Weblog/Categories" />
    <file name="EditComment.html" target="Files/Templates/Weblog/Comments" source="Files/Templates/Weblog/Comments" />
    <file name="Login.html" target="Files/Templates/Weblog/Authorized" source="Files/Templates/Weblog/Authorized" />
    <file name="Notify.html" target="Files/Templates/Weblog/Authorized" source="Files/Templates/Weblog/Authorized" />
    <file name="PasswordSent.html" target="Files/Templates/Weblog/Authorized" source="Files/Templates/Weblog/Authorized" />
    <file name="UserInfo.html" target="Files/Templates/Weblog/Authorized" source="Files/Templates/Weblog/Authorized" />
    <file name="EditBlog.html" target="Files/Templates/Weblog/Blogs" source="Files/Templates/Weblog/Blogs" />
    <file name="EditArticle.html" target="Files/Templates/Weblog/Articles" source="Files/Templates/Weblog/Articles" />

    <database file="Weblog.mdb">
      <WeblogSettings>
        <sql conditional="">ALTER TABLE [WeblogSettings] ADD WeblogSettingsFrontendCategory BIT</sql>
      </WeblogSettings>
    </database>
    -->
  </package>

  <package version="128" date="24-01-2007" internalversion="18.11.1.0">
    <folder source="Files/Templates/DBPub" target="Files/Templates" />
    <database file="DBPub.mdb">
      <Module>
        <sql conditional="">ALTER TABLE Relation ADD RelationParentCaption VARCHAR (255) NULL</sql>
      </Module>
    </database>
  </package>

  <package version="127" date="15-01-2007" internalversion="18.11.1.0">
    <database file="DBIntegration.mdb">
      <Module>
        <sql conditional="">ALTER TABLE Job ALTER COLUMN JobName varchar(255) NULL</sql>
        <sql conditional="">ALTER TABLE Job ALTER COLUMN JobDSTable varchar(255) NULL</sql>
        <sql conditional="">ALTER TABLE Job ALTER COLUMN JobDSAccessFilename varchar(255) NULL</sql>
        <sql conditional="">ALTER TABLE Job ALTER COLUMN JobDSSQLDatabase varchar(255) NULL</sql>
        <sql conditional="">ALTER TABLE Job ALTER COLUMN JobDSSQLServer varchar(255) NULL</sql>
        <sql conditional="">ALTER TABLE Job ALTER COLUMN JobDSSQLUser varchar(255) NULL</sql>
        <sql conditional="">ALTER TABLE Job ALTER COLUMN JobDSSQLPassword varchar(255) NULL</sql>
        <sql conditional="">ALTER TABLE Job ALTER COLUMN JobDSCSVFolder varchar(255) NULL</sql>
        <sql conditional="">ALTER TABLE Job ALTER COLUMN JobDSWSUrl varchar(255) NULL</sql>
        <sql conditional="">ALTER TABLE Job ALTER COLUMN JobDSCSVFolderCharacterSet varchar(255) NULL</sql>
        <sql conditional="">ALTER TABLE Job ALTER COLUMN JobDSWSQuery varchar(255) NULL</sql>
        <sql conditional="">ALTER TABLE Job ALTER COLUMN JobDTAccessFilename varchar(255) NULL</sql>

        <sql conditional="">ALTER TABLE Map ALTER COLUMN MapSourceField varchar(255) NULL</sql>
        <sql conditional="">ALTER TABLE Map ALTER COLUMN MapTargetField varchar(255) NULL</sql>
      </Module>
    </database>
  </package>

  <package version="126" date="12-01-2007" internalversion="18.11.1.0">
    <!--
    <file name="Tree.html" target="Files/Templates/FilePublishingV2" source="Files/Templates/FilePublishingV2" />
    <file name="PageNavigator.html" target="Files/Templates/FilePublishingV2" source="Files/Templates/FilePublishingV2" />
    <file name="ResourceList.html" target="Files/Templates/FilePublishingV2" source="Files/Templates/FilePublishingV2" />
    <file name="MainForm.html" target="Files/Templates/FilePublishingV2" source="Files/Templates/FilePublishingV2" />
    <file name="NewFolder.html" target="Files/Templates/FilePublishingV2" source="Files/Templates/FilePublishingV2" />
    <file name="RenameForm.html" target="Files/Templates/FilePublishingV2" source="Files/Templates/FilePublishingV2" />
    -->
  </package>

  <package version="124" date="10-01-2007" internalversion="18.11.1.0">
    <file name="Subscription.html" target="Files/Templates/DbPub2/Base" source="Files/Templates/DBPub2/Base" />
  </package>

  <package version="123" date="08-01-2007" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">ALTER TABLE Area ADD AreaMasterAreaID INT NULL DEFAULT 0</sql>
        <sql conditional="">ALTER TABLE Page ADD PageMasterPageID INT NULL DEFAULT 0</sql>
        <sql conditional="">ALTER TABLE Paragraph ADD ParagraphMasterParagraphID INT NULL DEFAULT 0</sql>
      </Module>
    </database>
  </package>

  <package version="122" date="29-12-2006" internalversion="18.11.1.0">
    <!--<folder source="Files/Templates/FilePublishingV2" target="Files/Templates" />-->
    <!--<file name="FilePublishingV2.mdb" target="Database" source="Database" />-->
    <!--<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'FilePublishingV2'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleControlPanel, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess, ModuleIsBeta) VALUES ('FilePublishingV2', 'FilePublishingV2', 0, 0, 1, 0, '/Admin/Module/FilePublishingV2/Default.aspx','FilePublishingV2_cpl.aspx', NULL, NULL, NULL, 1)</sql>
	  </Module>
	</database>-->
	<!--database file="FilePublishingV2.mdb">
      <Module>
        <sql conditional="">CREATE TABLE FPV2Download (FPV2DownloadID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, FPV2DownloadFileID INT NULL DEFAULT (0), FPV2DownloadUserID INT NULL DEFAULT (0)) </sql>
        <sql conditional="">CREATE TABLE FPV2Field (FPV2FieldID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, FPV2FieldName nvarchar(50) NULL, FPV2FieldTitle nvarchar(50) NULL, FPV2FieldType INT NULL DEFAULT (0)) </sql>
        <sql conditional="">CREATE TABLE FPV2File (FPV2FileID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, FPV2FileName ntext NULL) </sql>
        <sql conditional="">CREATE TABLE FPV2Permission (FPV2PermissionID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, FPV2PermissionResourceID INT NULL DEFAULT (0), FPV2PermissionUserID INT NULL DEFAULT (0),	FPV2PermissionUserType INT NULL DEFAULT (0), FPV2PermissionPermissions nvarchar(255) NULL ) </sql>
        <sql conditional="">CREATE TABLE FPV2Resource (FPV2ResourceID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, FPV2ResourceParentID INT NOT NULL DEFAULT (0), FPV2ResourceName ntext NULL, FPV2ResourceAllowInheritPermissions bit NOT NULL DEFAULT (0)) </sql>
        <sql conditional="">CREATE TABLE FPV2Subscription (	FPV2SubscriptionId INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 	FPV2SubscriptionResourceID INT NULL DEFAULT (0), FPV2SubscriptionUserID INT NULL DEFAULT (0))</sql>
        <sql conditional="">CREATE TABLE FPV2SubscritionMessage (FPV2SubscritionMessageID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 	FPV2SubscritionMessageEmail nvarchar(255) NULL, FPV2SubscritionMessageMessage ntext NULL,	FPV2SubscritionMessageState INT NULL DEFAULT (0), FPV2SubscritionMessageDate datetime NULL )</sql>
        <sql conditional="">CREATE TABLE FPV2Upload (FPV2UploadID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, FPV2UploadFileID INT NULL DEFAULT (0), FPV2UploadUserID INT NULL DEFAULT (0),	FPV2UploadDate datetime NULL)</sql>

        <sql conditional="">ALTER TABLE FPV2Download ADD CONSTRAINT FPV2Download_FK00 FOREIGN KEY (FPV2DownloadFileID) REFERENCES FPV2File (FPV2FileID)</sql>
        <sql conditional="">ALTER TABLE FPV2Upload ADD CONSTRAINT FPV2Upload_FK00 FOREIGN KEY (FPV2UploadFileID) REFERENCES FPV2File (FPV2FileID)</sql>
        <sql conditional="">ALTER TABLE FPV2Subscription ADD CONSTRAINT FPV2Subscription_FK00 FOREIGN KEY (FPV2SubscriptionResourceID) REFERENCES FPV2Resource (FPV2ResourceID)</sql>
        <sql conditional="">ALTER TABLE FPV2Permission ADD CONSTRAINT FPV2Permission_FK00 FOREIGN KEY (FPV2PermissionResourceID) REFERENCES FPV2Resource (FPV2ResourceID)</sql>

        <sql conditional="">CREATE INDEX FPV2Download_IDX001 ON FPV2Download (FPV2DownloadID)</sql>
        <sql conditional="">CREATE INDEX FPV2Download_IDX002 ON FPV2Download (FPV2DownloadFileID)</sql>
        <sql conditional="">CREATE INDEX FPV2Download_IDX003 ON FPV2Download (FPV2DownloadUserID)</sql>
        <sql conditional="">CREATE INDEX FPV2File_IDX001 ON FPV2File (FPV2FileID)</sql>
        <sql conditional="">CREATE INDEX FPV2Permission_IDX001 ON FPV2Permission (FPV2PermissionUserID)</sql>
        <sql conditional="">CREATE INDEX FPV2Permission_IDX002 ON FPV2Permission (FPV2PermissionID)</sql>
        <sql conditional="">CREATE INDEX FPV2Permission_IDX003 ON FPV2Permission (FPV2PermissionResourceID)</sql>
        <sql conditional="">CREATE INDEX FPV2Resource_IDX001 ON FPV2Resource (FPV2ResourceID)</sql>
        <sql conditional="">CREATE INDEX FPV2Resource_IDX002 ON FPV2Resource (FPV2ResourceParentID)</sql>
        <sql conditional="">CREATE INDEX FPV2Subscription_IDX001 ON FPV2Subscription (FPV2SubscriptionUserID)</sql>
        <sql conditional="">CREATE INDEX FPV2Subscription_IDX002 ON FPV2Subscription (FPV2SubscriptionResourceID)</sql>
        <sql conditional="">CREATE INDEX FPV2Subscription_IDX003 ON FPV2Subscription (FPV2SubscriptionId)</sql>
        <sql conditional="">CREATE INDEX FPV2SubscritionMessage_IDX001 ON FPV2SubscritionMessage (FPV2SubscritionMessageID)</sql>
        <sql conditional="">CREATE INDEX FPV2Upload_IDX001 ON FPV2Upload (FPV2UploadFileID)</sql>
        <sql conditional="">CREATE INDEX FPV2Upload_IDX002 ON FPV2Upload (FPV2UploadID)</sql>
        <sql conditional="">CREATE INDEX FPV2Upload_IDX003 ON FPV2Upload (FPV2UploadUserID)</sql>

        <sql conditional="SELECT * FROM FPV2Field WHERE FPV2FieldName='Name'">INSERT INTO FPV2Field (FPV2FieldName, FPV2FieldTitle, FPV2FieldType) VALUES ('Name', 'Name', 1)</sql>
        <sql conditional="SELECT * FROM FPV2Field WHERE FPV2FieldName='Created'">INSERT INTO FPV2Field (FPV2FieldName, FPV2FieldTitle, FPV2FieldType) VALUES ('Created', 'Created', 2)</sql>
        <sql conditional="SELECT * FROM FPV2Field WHERE FPV2FieldName='Modified'">INSERT INTO FPV2Field (FPV2FieldName, FPV2FieldTitle, FPV2FieldType) VALUES ('Modified', 'Modified', 3)</sql>
        <sql conditional="SELECT * FROM FPV2Field WHERE FPV2FieldName='Size'">INSERT INTO FPV2Field (FPV2FieldName, FPV2FieldTitle, FPV2FieldType) VALUES ('Size', 'Size', 4)</sql>

      </Module>
    </database-->
  </package>

  <package version="121" date="11-12-2006" internalversion="18.11.1.0">
    <file name="Subscription.html" target="Files/Templates/DbPub2/Base" source="Files/Templates/DBPub2/Base" />
    <file name="SubscriptionResult.html" target="Files/Templates/DbPub2/Base" source="Files/Templates/DBPub2/Base" />
    <file name="ValidationAllowLength.html" target="Files/Templates/DbPub2/Base" source="Files/Templates/DBPub2/Base" />
  </package>
  <!--package version="120" date="11-12-2006" internalversion="18.11.1.0">
    <folder source="Files/Templates/Calendar/Booking" target="Files/Templates/Calendar" />
    <folder source="Files/Templates/Calendar/ReservationList" target="Files/Templates/Calendar" />
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">update [Module] set ModuleIsBeta=1 where ModuleSystemName='Calendar'</sql>
        <sql conditional="">CREATE TABLE [Booking] (BookingID INT IDENTITY(1,1) PRIMARY KEY, BookingItemID INT NOT NULL, BookingTitel VARCHAR(255) NOT NULL, BookingName VARCHAR(50) NULL, BookingExtranetUserID INT NULL, BookingSelectedNotificationIDs VARCHAR(255) NULL, BookingNotifyNumberOfPersons INT NULL, BookingNotifyDeliveryTime VARCHAR(6) NULL, BookingNotifyPayment VARCHAR(255) NULL, BookingInternal BIT NULL, BookingComment TEXT)</sql>
        <sql conditional="">CREATE INDEX BookingExtranetUserID on [Booking] (BookingExtranetUserID)</sql>
        <sql conditional="">CREATE INDEX BookingRessourceID on [Booking](BookingItemID)</sql>
        <sql conditional="">CREATE TABLE BookingBookingEquipment (BookingBookingEquipmentBookingID INT NOT NULL,BookingBookingEquipmentEquipmentID INT NOT NULL, PRIMARY KEY(BookingBookingEquipmentBookingID, BookingBookingEquipmentEquipmentID))</sql>
        <sql conditional="">CREATE TABLE [BookingBookingProvision] (BookingBookingProvisionBookingID INT NOT NULL,BookingBookingProvisionProvisionID INT NOT NULL,PRIMARY KEY (BookingBookingProvisionBookingID, BookingBookingProvisionProvisionID))</sql>
        <sql conditional="">CREATE TABLE BookingCustomField (BookingCustomFieldID INT IDENTITY(1,1) PRIMARY KEY,BookingCustomFieldName VARCHAR(50) NOT NULL,BookingCustomFieldSystemName VARCHAR(50) NOT NULL,BookingCustomFieldType INT NOT NULL,BookingCustomFieldDropDown BIT NULL)</sql>
        <sql conditional="">CREATE INDEX CustomFieldsTypeID on [BookingCustomField](BookingCustomFieldType)</sql>
        <sql conditional="">CREATE TABLE BookingCustomFieldType (BookingCustomFieldTypeID INT IDENTITY(1,1) PRIMARY KEY,BookingCustomFieldTypeName VARCHAR(50) NOT NULL,BookingCustomFieldTypeDB VARCHAR(50) NOT NULL)</sql>
        <sql conditional="">CREATE TABLE BookingCustomFieldValue (BookingCustomFieldValueID INT IDENTITY(1,1) PRIMARY KEY, BookingCustomFieldValueFieldID INT NOT NULL,BookingCustomFieldValueKey VARCHAR(50) NOT NULL,BookingCustomFieldValueValue VARCHAR(50) NOT NULL)</sql>
        <sql conditional="">CREATE INDEX FieldID on [BookingCustomFieldValue](BookingCustomFieldValueFieldID)</sql>
        <sql conditional="">CREATE TABLE BookingDate (DateID INT IDENTITY(1,1) PRIMARY KEY, DateBookingID INT NOT NULL,DateStart DATETIME NOT NULL,DateEnd DATETIME NOT NULL)</sql>
        <sql conditional="">CREATE INDEX BookingID on [BookingDate](DateBookingID)</sql>
        <sql conditional="">CREATE TABLE BookingEquipment (BookingEquipmentID INT IDENTITY(1,1) PRIMARY KEY,BookingEquipmentName VARCHAR(50) NOT NULL,BookingEquipmentDesc VARCHAR(50) NOT NULL,BookingEquipmentEmail VARCHAR(50) NOT NULL)</sql>
        <sql conditional="">CREATE TABLE BookingItem (BookingItemID INT NOT NULL PRIMARY KEY,BookingItemAvailableMonday BIT NULL,BookingItemAvailableMondayFrom INT NULL,BookingItemAvailableMondayTo INT NULL,BookingItemAvailableTuesday BIT NULL,BookingItemAvailableTuesdayFrom INT NULL,BookingItemAvailableTuesdayTo INT NULL,BookingItemAvailableWednesday BIT NULL,BookingItemAvailableWednesdayFrom INT NULL,BookingItemAvailableWednesdayTo INT NULL,BookingItemAvailableThursday BIT NULL,BookingItemAvailableThursdayFrom INT NULL,BookingItemAvailableThursdayTo INT NULL,BookingItemAvailableFriday BIT NULL,BookingItemAvailableFridayFrom INT NULL,BookingItemAvailableFridayTo INT NULL,BookingItemAvailableSaturday BIT NULL,BookingItemAvailableSaturdayFrom INT NULL,BookingItemAvailableSaturdayTo INT NULL,BookingItemAvailableSunday BIT NULL,BookingItemAvailableSundayFrom INT NULL,BookingItemAvailableSundayTo INT NULL,BookingItemNotify VARCHAR(255) NULL,BookingItemNotifyUser BIT NULL,BookingItemUserNotificationTemplate VARCHAR(50) NOT NULL,BookingItemProvisionNotificationTemplate VARCHAR(50) NOT NULL,BookingItemEquipmentNotificationTemplate VARCHAR(50) NOT NULL,BookingItemSelectInternal BIT NULL,BookingItemSelectMeal BIT NULL,BookingItemShowUserName BIT NULL,BookingItemMaxPersons INT NULL,BookingItemMaxUserBooking INT NULL,BookingItemBookingColor VARCHAR(50) NULL,BookingItemUnavailableColor VARCHAR(50) NULL,BookingItemAvailableColor VARCHAR(50) NULL,BookingItemDescriptionPage VARCHAR(100) NULL,BookingItemFixedLength INT NULL)</sql>
        <sql conditional="">CREATE TABLE BookingItemCustomField (BookingItemCustomFieldItemID INT NOT NULL,BookingItemCustomFieldFieldID INT NOT NULL,PRIMARY KEY (BookingItemCustomFieldItemID, BookingItemCustomFieldFieldID))</sql>
        <sql conditional="">CREATE TABLE BookingItemEquipment (BookingItemEquipmentItemID INT NOT NULL,BookingItemEquipmentEquipmentID INT NOT NULL,PRIMARY KEY (BookingItemEquipmentItemID, BookingItemEquipmentEquipmentID))</sql>
        <sql conditional="">CREATE TABLE BookingItemProvision (BookingItemProvisionItemID INT NOT NULL,BookingItemProvisionProvisionID INT NOT NULL,PRIMARY KEY (BookingItemProvisionItemID, BookingItemProvisionProvisionID))</sql>
        <sql conditional="">CREATE TABLE BookingProvision (BookingProvisionID INT IDENTITY(1,1) PRIMARY KEY,BookingProvisionName VARCHAR(50) NOT NULL,BookingProvisionDesc VARCHAR(50) NOT NULL,BookingProvisionEmail VARCHAR(50) NOT NULL)</sql>
        <sql conditional="">ALTER TABLE [CalenderCategory] ADD CalenderCategoryReservation INT NULL</sql>
        <sql conditional="select * from BookingCustomFieldType where BookingCustomFieldTypeName='Text (255)'">insert into BookingCustomFieldType (BookingCustomFieldTypeName, BookingCustomFieldTypeDB) values ('Text (255)', 'VARCHAR(255) NULL')</sql>
        <sql conditional="select * from BookingCustomFieldType where BookingCustomFieldTypeName='Text (100)'">insert into BookingCustomFieldType (BookingCustomFieldTypeName, BookingCustomFieldTypeDB) values ('Text (100)', 'VARCHAR(100) NULL')</sql>
        <sql conditional="select * from BookingCustomFieldType where BookingCustomFieldTypeName='Text (50)'">insert into BookingCustomFieldType (BookingCustomFieldTypeName, BookingCustomFieldTypeDB) values ('Text (50)', 'VARCHAR(50) NULL')</sql>
        <sql conditional="select * from BookingCustomFieldType where BookingCustomFieldTypeName='Text (20)'">insert into BookingCustomFieldType (BookingCustomFieldTypeName, BookingCustomFieldTypeDB) values ('Text (20)', 'VARCHAR(20) NULL')</sql>
        <sql conditional="select * from BookingCustomFieldType where BookingCustomFieldTypeName='Text (5)'">insert into BookingCustomFieldType (BookingCustomFieldTypeName, BookingCustomFieldTypeDB) values ('Text (5)', 'VARCHAR(5) NULL')</sql>
        <sql conditional="select * from BookingCustomFieldType where BookingCustomFieldTypeName='Long Text'">insert into BookingCustomFieldType (BookingCustomFieldTypeName, BookingCustomFieldTypeDB) values ('Long Text', 'MEMO NULL')</sql>
        <sql conditional="select * from BookingCustomFieldType where BookingCustomFieldTypeName='Checkbox'">insert into BookingCustomFieldType (BookingCustomFieldTypeName, BookingCustomFieldTypeDB) values ('Checkbox', 'BIT')</sql>
        <sql conditional="select * from BookingCustomFieldType where BookingCustomFieldTypeName='Date'">insert into BookingCustomFieldType (BookingCustomFieldTypeName, BookingCustomFieldTypeDB) values ('Date', 'DATE NULL')</sql>
        <sql conditional="select * from BookingCustomFieldType where BookingCustomFieldTypeName='Date/Time'">insert into BookingCustomFieldType (BookingCustomFieldTypeName, BookingCustomFieldTypeDB) values ('Date/Time', 'DATE NULL')</sql>
        <sql conditional="select * from BookingCustomFieldType where BookingCustomFieldTypeName='Decimal'">insert into BookingCustomFieldType (BookingCustomFieldTypeName, BookingCustomFieldTypeDB) values ('Decimal', 'DOUBLE NULL')</sql>
        <sql conditional="select * from BookingCustomFieldType where BookingCustomFieldTypeName='Integer'">insert into BookingCustomFieldType (BookingCustomFieldTypeName, BookingCustomFieldTypeDB) values ('Integer', 'LONG NULL')</sql>
      </Module>
    </database>
  </package-->
  <package version="119" date="11-12-2006" internalversion="18.11.1.0">
    <file name="ActionAdd.html" target="Files/Templates/DbPub2/Base" source="Files/Templates/DBPub2/Base" />
    <file name="Edit.html" target="Files/Templates/DbPub2/Base" source="Files/Templates/DBPub2/Base" />
    <file name="MasterList.html" target="Files/Templates/DbPub2/Base" source="Files/Templates/DBPub2/Base" />
    <file name="Subscription.html" target="Files/Templates/DbPub2/Base" source="Files/Templates/DBPub2/Base" />
    <database file="DBPub.mdb">
      <DBPubTableCreate>
        <sql conditional="">CREATE TABLE DBPubControl (DBPubControlID INT PRIMARY KEY NOT NULL DEFAULT 0, DBPubControlName VARCHAR (50) NULL)</sql>
        <sql conditional="">CREATE TABLE DBPubMail (DBPubMailID int IDENTITY(1,1) PRIMARY KEY NOT NULL, DBPubMailMessage ntext NULL, DBPubMailAddress VARCHAR (50) NULL, DBPubMailTitle VARCHAR (50) NULL, DBPubMailDate datetime NULL )</sql>
        <sql conditional="">CREATE TABLE DBPubSubscriber (DBPubSubscriberId int IDENTITY(1,1) PRIMARY KEY NOT NULL, DBPubSubscriberUserId INT NULL, DBPubSubscriberViewId INT NULL )</sql>
      </DBPubTableCreate>
      <DBPubAlterTable>
        <sql conditional="">ALTER TABLE DBPubField ADD DBPubFieldControlID INT NULL DEFAULT 0</sql>
        <sql conditional="">ALTER TABLE DBPubField ADD DBPubFieldPattern ntext NULL</sql>
        <sql conditional="">ALTER TABLE DBPubField ADD DBPubFieldHidden BIT NULL</sql>
        <sql conditional="">ALTER TABLE DBPubField ADD DBPubFieldMaxLength INT NULL DEFAULT 0</sql>
        <sql conditional="">ALTER TABLE DBPubView ADD DBPubUploadFolder ntext NULL</sql>
        <sql conditional="">ALTER TABLE DBPubView ADD DBPubViewExportFolder VARCHAR (255) NULL</sql>
      </DBPubAlterTable>
      <DBPubConstrains>
        <sql conditional="">ALTER TABLE DBPubSubscriber ADD CONSTRAINT DBPubSubscriber_FK00 FOREIGN KEY (DBPubSubscriberViewId) REFERENCES DBPubView (DBPubViewID)</sql>
        <sql conditional="">ALTER TABLE DBPubField ADD CONSTRAINT DBPubField_FK01 FOREIGN KEY (DBPubFieldControlID) REFERENCES DBPubControl (DBPubControlID)</sql>
      </DBPubConstrains>
      <DBPubIndexes>
        <sql conditional="">CREATE INDEX DBPubSubscriber_IDX001 ON DBPubSubscriber (DBPubSubscriberId)</sql>
        <sql conditional="">CREATE INDEX DBPubSubscriber_IDX002 ON DBPubSubscriber (DBPubSubscriberUserId)</sql>
        <sql conditional="">CREATE INDEX DBPubSubscriber_IDX003 ON DBPubSubscriber (DBPubSubscriberViewId)</sql>
        <sql conditional="">CREATE INDEX DBPubMail_IDX001 ON DBPubMail (DBPubMailID)</sql>
        <sql conditional="">CREATE INDEX DBPubField_IDX001 ON DBPubField (DBPubFieldControlID)</sql>
      </DBPubIndexes>
      <DBPubInsertControls>
        <sql conditional="SELECT * FROM [DBPubControl] WHERE [DBPubControlID]=0">INSERT INTO [DBPubControl](DBPubControlID, DBPubControlName) values(0, 'Default')</sql>
        <sql conditional="SELECT * FROM [DBPubControl] WHERE [DBPubControlID]=1">INSERT INTO [DBPubControl](DBPubControlID, DBPubControlName) values(1, 'Text')</sql>
        <sql conditional="SELECT * FROM [DBPubControl] WHERE [DBPubControlID]=2">INSERT INTO [DBPubControl](DBPubControlID, DBPubControlName) values(2, 'Check box')</sql>
        <sql conditional="SELECT * FROM [DBPubControl] WHERE [DBPubControlID]=3">INSERT INTO [DBPubControl](DBPubControlID, DBPubControlName) values(3, 'Radio buttons')</sql>
        <sql conditional="SELECT * FROM [DBPubControl] WHERE [DBPubControlID]=4">INSERT INTO [DBPubControl](DBPubControlID, DBPubControlName) values(4, 'Text area')</sql>
        <sql conditional="SELECT * FROM [DBPubControl] WHERE [DBPubControlID]=5">INSERT INTO [DBPubControl](DBPubControlID, DBPubControlName) values(5, 'File manager')</sql>
        <sql conditional="SELECT * FROM [DBPubControl] WHERE [DBPubControlID]=6">INSERT INTO [DBPubControl](DBPubControlID, DBPubControlName) values(6, 'Html editor')</sql>
        <sql conditional="SELECT * FROM [DBPubControl] WHERE [DBPubControlID]=7">INSERT INTO [DBPubControl](DBPubControlID, DBPubControlName) values(7, 'SelectBox')</sql>
        <sql conditional="SELECT * FROM [DBPubControl] WHERE [DBPubControlID]=8">INSERT INTO [DBPubControl](DBPubControlID, DBPubControlName) values(8, 'Upload manager')</sql>
        <sql conditional="SELECT * FROM [DBPubControl] WHERE [DBPubControlID]=9">INSERT INTO [DBPubControl](DBPubControlID, DBPubControlName) values(9, 'Date select')</sql>
      </DBPubInsertControls>
    </database>
  </package>
  <package version="118" date="12-01-2007" internalversion="18.11.1.0">
    <!--
    <database file="Weblog.mdb">
      <Modify>
        <sql conditional="">ALTER TABLE WeblogArticle ALTER COLUMN WeblogArticleDescription varchar(255) NULL</sql>
      </Modify>
    </database>
    <file name="EditArticle.html" overwrite="false" target="Files/Templates/Weblog/Articles" source="Files/Templates/Weblog/Articles"/>
    <file name="SubscriberAdded.html" overwrite="false" target="Files/Templates/Weblog/Subscription" source="Files/Templates/Weblog/Subscription"/>
    -->
  </package>

  <package version="117" date="11-01-2007" internalversion="18.11.1.0">
    <!--<file name="ListBlog.html" overwrite="false" target="Files/Templates/Weblog/Blogs" source="Files/Templates/Weblog/Blogs"/>-->
  </package>

  <package version="116" date="09-01-2007" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">ALTER TABLE Template ADD TemplateImageHeight INT NULL</sql>
      </Module>
    </database>
  </package>

  <package version="115" date="26-12-2006" internalversion="18.11.1.0">
    <!--
    <file name="EditThread.html" overwrite="false" target="Files/Templates/Forumv2/Thread" source="Files/Templates/Forumv2/Thread"/>
    <file name="Login.html" overwrite="false" target="Files/Templates/Forumv2/Other" source="Files/Templates/Forumv2/Other"/>
    <file name="EditProfile.html" overwrite="false" target="Files/Templates/Forumv2/Other" source="Files/Templates/Forumv2/Other"/>
    <file name="Search.html" overwrite="false" target="Files/Templates/Weblog/Search" source="Files/Templates/Weblog/Search"/>
    <file name="AddSubscriber.html" overwrite="false" target="Files/Templates/Weblog/Subscription" source="Files/Templates/Weblog/Subscription"/>
    <file name="EditArticle.html" overwrite="false" target="Files/Templates/Weblog/Articles" source="Files/Templates/Weblog/Articles"/>
    <file name="ForgotPassword.html" overwrite="false" target="Files/Templates/Weblog/Authorized" source="Files/Templates/Weblog/Authorized"/>
    <file name="EditTeam.html" overwrite="false" target="Files/Templates/Weblog/Shared" source="Files/Templates/Weblog/Shared"/>
    -->
  </package>

  <package version="114" date="10-01-2007" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Seo'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('Seo', 'Sogemaskineoptimering', 0, 0, 1, 0, NULL, NULL, NULL, NULL)</sql>
      </Module>
    </database>
    <file name="Links.html" overwrite="false" target="Files/Templates/Seo" source="Files/Templates/Seo" />
  </package>

  <package version="113" date="15-12-2006" internalversion="18.11.1.0">
    <file name="RSS_External.html" overwrite="false" target="Files/Templates/RSSfeed" source="Files/Templates/RSSfeed" />
    <file name="RSS_Page.html" overwrite="false" target="Files/Templates/RSSfeed" source="Files/Templates/RSSfeed" />
    <file name="RSSExt_Page.html" overwrite="false" target="Files/Templates/RSSfeed/RSSList" source="Files/Templates/RSSfeed/RSSList" />
  </package>

  <package version="112" date="11-12-2006" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE ModuleAccess = True AND ModuleSystemName = 'Light'">UPDATE [Module] SET ModuleAccess = True WHERE ModuleSystemName = 'Update'</sql>
        <sql conditional="SELECT * FROM [Module] WHERE ModuleAccess = 1 AND ModuleSystemName = 'Light'">UPDATE [Module] SET ModuleAccess = 1 WHERE ModuleSystemName = 'Update'</sql>
      </Module>
    </database>
  </package>

  <package version="111" date="04-12-2006" internalversion="18.11.1.0">
    <database file="DBIntegration.mdb">
      <Map>
        <sql conditional="">ALTER TABLE [Map] ADD MapTargetTableID INT NULL</sql>
      </Map>
      <Target>
        <sql conditional="">CREATE TABLE TargetTable (TargetTableID IDENTITY PRIMARY KEY NOT NULL, TargetTableJobID INT NOT NULL, TargetTableName VARCHAR (255) NULL)</sql>
        <sql conditional="">ALTER TABLE [Map] ADD CONSTRAINT Map_Table_FK FOREIGN KEY ( MapTargetTableID ) REFERENCES TargetTable (TargetTableID)</sql>
        <sql conditional="">ALTER TABLE [TargetTable] ADD CONSTRAINT Job_Target_FK FOREIGN KEY (TargetTableJobID) REFERENCES Job (JobID)</sql>
      </Target>
      <Modify>
        <sql conditional="">INSERT INTO TargetTable (TargetTableJobID, TargetTableName)  SELECT Job.JobID, Job.JobDTTable FROM Job</sql>
        <sql conditional="">ALTER TABLE Job DROP JobDTTable</sql>
      </Modify>
    </database>
  </package>

  <package version="110" date="08-12-2006" internalversion="18.11.1.0">
    <!--<folder source="Files/Templates/IntranoteIntegration" target="Files/Templates" />-->
  </package>

  <package version="109" date="08-12-2006" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <Page>
        <sql conditional="">ALTER TABLE [Page] ADD PageRotationType INT NULL</sql>
      </Page>
    </database>
  </package>
  <package version="108" date="04-12-2006" internalversion="18.11.1.0">
    <database file="Survey.mdb">
      <Module>
        <!--
			What the fuck is this? //NP 20-12-2006
			-->
        <!--sql conditional="">CREATE TABLE IntranoteFile (FileIntranoteID INT PRIMARY KEY NOT NULL, FileType NVARCHAR(64) NULL, FileName NVARCHAR(255) NOT NULL, FileDwFolder NVARCHAR(255) NULL)</sql-->
      </Module>
    </database>
  </package>
  <package version="107" date="04-12-2006" internalversion="18.11.1.0">
    <!--
    <database file="ForumV2.mdb">
      <Module>
        <sql conditional="">CREATE TABLE [ForumV2Ban] ( [ForumV2BanID] IDENTITY PRIMARY KEY NOT NULL, [ForumV2BanAddress] NVARCHAR (100) NULL, [ForumV2BanActive] BIT NULL )</sql>
        <sql conditional="">CREATE TABLE [ForumV2Category] ( [ForumV2CategoryID] IDENTITY PRIMARY KEY NOT NULL, [ForumV2CategoryName] NVARCHAR (100) NULL, [ForumV2CategoryDescription] NVARCHAR (200) NULL, [ForumV2CategoryHTMLAllowed] BIT NULL )</sql>
        <sql conditional="">CREATE TABLE [ForumV2Censoring] ( [ForumV2CensoringID] IDENTITY PRIMARY KEY NOT NULL, [ForumV2CensoringWord] NVARCHAR (255) NULL )</sql>
        <sql conditional="">CREATE TABLE [ForumV2Emoticon] ( [ForumV2EmoticonID] IDENTITY PRIMARY KEY NOT NULL, [ForumV2EmoticonCombination] NVARCHAR (30) NULL, [ForumV2EmoticonIcon] NVARCHAR (255) NULL )</sql>
        <sql conditional="">CREATE TABLE [ForumV2Moderator] ( [ForumV2ModeratorID] IDENTITY PRIMARY KEY NOT NULL, [ForumV2ModeratorUserID] INT NULL, [ForumV2ModeratorCategoryID] INT NULL )</sql>
        <sql conditional="">CREATE TABLE [ForumV2Post] ( [ForumV2PostID] IDENTITY PRIMARY KEY NOT NULL, [ForumV2PostThreadID] INT NULL, [ForumV2PostUserID] INT NULL, [ForumV2PostHeadline] NVARCHAR (150) NULL, [ForumV2PostText] MEMO NULL, [ForumV2PostDate] DATETIME NULL )</sql>
        <sql conditional="">CREATE TABLE [ForumV2Rank] ( [ForumV2RankID] IDENTITY PRIMARY KEY NOT NULL, [ForumV2RankName] NVARCHAR (100) NULL, [ForumV2RankCount] INT NULL )</sql>
        <sql conditional="">CREATE TABLE [ForumV2Settings] ( [ForumV2SettingsID] IDENTITY PRIMARY KEY NOT NULL, [ForumV2SettingsHotStatusCount] INT NULL, [ForumV2SettingsHotStatusHours] INT NULL, [ForumV2SettingsHotStatusImage] NVARCHAR (255) NULL, [ForumV2SettingsHotStatusText] NVARCHAR (200) NULL, [ForumV2SettingsHotStatusUseMark] NVARCHAR (150) NULL, [ForumV2SettingsAutoPruneOld] INT NULL, [ForumV2SettingsAutoPruneUnanswered] INT NULL, [ForumV2SettingsManualPrune] INT NULL, [ForumV2SettingsManualPruneOld] BIT NULL, [ForumV2SettingsManualPruneUnanswered] BIT NULL, [ForumV2SettingsSubscribeLinkPage] NVARCHAR (255) NULL, [ForumV2SettingsSubscribeSubject] NVARCHAR (255) NULL, [ForumV2SettingsSubscribeFromEmail] NVARCHAR (255) NULL, [ForumV2SettingsSubscribeTemplate] NVARCHAR (255) NULL )</sql>
        <sql conditional="">CREATE TABLE [ForumV2Subscribe] ( [ForumV2SubscribeID] IDENTITY PRIMARY KEY NOT NULL, [ForumV2SubscribeUserID] INT NULL, [ForumV2SubscribeThreadID] INT NULL, [ForumV2SubscribeCategoryID] INT NULL, [ForumV2SubscribeAddress] NVARCHAR (100) NULL )</sql>
        <sql conditional="">CREATE TABLE [ForumV2Thread] ( [ForumV2ThreadID] IDENTITY PRIMARY KEY NOT NULL, [ForumV2ThreadCategoryID] INT NULL, [ForumV2ThreadVoteID] INT NULL, [ForumV2ThreadUserID] INT NULL, [ForumV2ThreadHeadline] NVARCHAR (100) NULL, [ForumV2ThreadDescription] NVARCHAR (150) NULL, [ForumV2ThreadText] MEMO NULL, [ForumV2ThreadDate] DATETIME NULL, [ForumV2ThreadClosed] BIT NULL, [ForumV2ThreadSticky] BIT NULL )</sql>
        <sql conditional="">CREATE TABLE [ForumV2Vote] ( [ForumV2VoteID] IDENTITY PRIMARY KEY NOT NULL, [ForumV2VoteText] NVARCHAR (255) NULL )</sql>
        <sql conditional="">CREATE TABLE [ForumV2VoteVariant] ( [ForumV2VoteVariantID] IDENTITY PRIMARY KEY NOT NULL, [ForumV2VoteVariantVoteID] INT NULL, [ForumV2VoteVariantText] NVARCHAR (100) NULL, [ForumV2VoteVariantCount] INT NULL )</sql>
      </Module>
    </database>
    -->
  </package>
  <package version="106" date="04-12-2006" internalversion="18.11.1.0">
    <database file="Survey.mdb">
      <Module>
        <sql conditional="">ALTER TABLE SurveyQuestion ADD SurveyQuestionText_tmp MEMO NULL</sql>
        <sql conditional="">UPDATE SurveyQuestion SET SurveyQuestionText_tmp = SurveyQuestionText</sql>
        <sql conditional="">ALTER TABLE SurveyQuestion DROP SurveyQuestionText</sql>
        <sql conditional="">ALTER TABLE SurveyQuestion ADD SurveyQuestionText MEMO NULL</sql>
        <sql conditional="">UPDATE SurveyQuestion SET SurveyQuestionText = SurveyQuestionText_tmp</sql>
        <sql conditional="">ALTER TABLE SurveyQuestion DROP SurveyQuestionText_tmp</sql>
        <sql conditional="">ALTER TABLE SurveyAnswerOption ADD SurveyAnswerOptionText_tmp MEMO NULL</sql>
        <sql conditional="">UPDATE SurveyAnswerOption SET SurveyAnswerOptionText_tmp = SurveyAnswerOptionText</sql>
        <sql conditional="">ALTER TABLE SurveyAnswerOption DROP SurveyAnswerOptionText</sql>
        <sql conditional="">ALTER TABLE SurveyAnswerOption ADD SurveyAnswerOptionText MEMO NULL</sql>
        <sql conditional="">UPDATE SurveyAnswerOption SET SurveyAnswerOptionText = SurveyAnswerOptionText_tmp</sql>
        <sql conditional="">ALTER TABLE SurveyAnswerOption DROP SurveyAnswerOptionText_tmp</sql>
      </Module>
    </database>
  </package>
  <package version="105" date="04-12-2006" internalversion="18.11.1.0">
    <database file="StatisticsV2.mdb">
      <module>
        <!--sql conditional="">CREATE INDEX STATV2Session_IDX001 ON Statv2Session (StatV2SessionTimestamp)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX002 ON Statv2Session (StatV2SessionTimestampEnd)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX003 ON Statv2Session (StatV2SessionAreaID)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX004 ON Statv2Session (StatV2SessionAdminUserID)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX005 ON Statv2Session (StatV2SessionPageviews)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX006 ON Statv2Session (StatV2SessionExtranetUserID)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX007 ON Statv2Session (StatV2SessionGwIPDbl)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX008 ON Statv2Session (StatV2SessionLastVisitDate)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX009 ON Statv2Session (StatV2SessionGwIP)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX010 ON Statv2Session (StatV2SessionYear)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX011 ON Statv2Session (StatV2SessionWeek)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX012 ON Statv2Session (StatV2SessionMonth)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX013 ON Statv2Session (StatV2SessionDay)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX014 ON Statv2Session (StatV2SessionUserLanguage)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX015 ON Statv2Session (StatV2SessionHour)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX016 ON Statv2Session (StatV2SessionResolution)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX017 ON Statv2Session (StatV2SessionConnectionType)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX018 ON Statv2Session (StatV2SessionColorDepth)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX019 ON Statv2Session (StatV2SessionRefererDomain)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX020 ON Statv2Session (StatV2SessionRefererSearchWord)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX021 ON Statv2Session (StatV2SessionUserAgentID)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX022 ON Statv2Session (StatV2SessionFirstPage)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX023 ON Statv2Session (StatV2SessionTimePrPage)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX024 ON Statv2Session (StatV2SessionLastPage)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX025 ON Statv2Session (StatV2SessionGwCountry)</sql>
				<sql conditional="">CREATE INDEX STATV2Session_IDX026 ON Statv2Session (StatV2SessionBot)</sql>
				<sql conditional="">CREATE INDEX STATV2Object_IDX001 ON Statv2Object (StatV2ObjectType)</sql>
				<sql conditional="">CREATE INDEX STATV2Object_IDX002 ON Statv2Object (StatV2ObjectElement)</sql>
				<sql conditional="">CREATE INDEX STATV2Object_IDX003 ON Statv2Object (StatV2ObjectSessionID)</sql>
				<sql conditional="">CREATE INDEX STATSV2TriggerStep_IDX001 ON Statsv2TriggerStep (StatsV2TriggerStepTriggerID)</sql>
				<sql conditional="">CREATE INDEX STATV2UserAgents_IDX001 ON StatV2UserAgents(StatV2UserAgentsBrowser)</sql>
				<sql conditional="">CREATE INDEX STATV2UserAgents_IDX002 ON StatV2UserAgents(StatV2UserAgentsOS)</sql>
				<sql conditional="">CREATE INDEX STATV2UserAgents_IDX003 ON StatV2UserAgents(StatV2UserAgentsOSType)</sql>
				<sql conditional="">CREATE INDEX STATV2UserAgents_IDX004 ON StatV2UserAgents(StatV2UserAgentsUA)</sql-->
      </module>
    </database>
  </package>
  <package version="104" date="22-11-2006" internalversion="18.11.1.0">
    <database file="DBIntegration.mdb">
      <Map>
        <sql>ALTER TABLE [Map] ADD MapSourceIsText BIT NOT NULL</sql>
        <sql>ALTER TABLE [Map] ADD MapSourceIsText BIT NOT NULL DEFAULT 0</sql>
      </Map>
    </database>
  </package>
  <package version="103" date="22-11-2006" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <!--<sql>UPDATE [Module] SET ModuleHiddenMode = 0 WHERE ModuleSystemName = 'ForumV2'</sql>-->
        <sql>UPDATE [Module] SET ModuleAccess = 1 WHERE ModuleSystemName = 'SitemapV2' AND ((SELECT ModuleAccess FROM [Module] WHERE ModuleSystemName = 'Sitemap') = 1)</sql>
        <sql>UPDATE [Module] SET ModuleAccess = 1 WHERE ModuleSystemName = 'SitemapV2' AND ((SELECT ModuleAccess FROM [Module] WHERE ModuleSystemName = 'Sitemap') = True)</sql>
      </Module>
    </database>
  </package>
  <package version="100" date="14-11-2006" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'RSSFeed'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('RSSFeed', 'RSS', 0, 0, 1, 0, NULL, NULL, NULL, NULL)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'MetaData'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('MetaData', 'Metadata', 0, 0, 0, 0, 'Metadata/Metadata_module.aspx', NULL, NULL, NULL)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'ContentLinks'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('ContentLinks', 'Relaterede links', 0, 0, 0, 0, 'ContentLink/ContentGroups_cpl.aspx', NULL, NULL, NULL)</sql>
        <sql conditional="SELECT ModuleSystemName FROM [Module] WHERE (ModuleSystemName IN ('Corporate', 'Business')) AND (ModuleAccess = 0)">UPDATE [Module] SET ModuleAccess = 1 WHERE ModuleSystemName = 'RSSFeed'</sql>
        <sql conditional="SELECT ModuleSystemName FROM [Module] WHERE (ModuleSystemName IN ('Corporate', 'Business')) AND (ModuleAccess = 0)">UPDATE [Module] SET ModuleAccess = 1 WHERE ModuleSystemName = 'Metadata'</sql>
        <sql conditional="SELECT ModuleSystemName FROM [Module] WHERE (ModuleSystemName IN ('Corporate', 'Business')) AND (ModuleAccess = 0)">UPDATE [Module] SET ModuleAccess = 1 WHERE ModuleSystemName = 'ContentLinks'</sql>
      </Module>
    </database>
  </package>
  <package version="99" date="13-11-2006" internalversion="18.11.1.0">
    <!--
    <database file="Dynamic.mdb">
      <module>
        <sql conditional="">UPDATE [Module] SET ModuleScript = 'IntranoteIntegration/IntranoteIntegration_Module.aspx' WHERE ModuleSystemName = 'IntranoteIntegration'</sql>
        <sql conditional="">UPDATE [Module] SET ModuleScript = 'ForumV2/Menu.aspx' WHERE ModuleSystemName = 'ForumV2'</sql>
      </module>
    </database>
    -->
  </package>

  <package version="98" date="13-11-2006" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <module>
        <sql conditional="">UPDATE [Module] SET ModuleIsBeta=blnTrue WHERE ModuleSystemName IN ('ForumV2', 'DBIntegration', 'SitemapV2', 'Survey', 'Weblog')</sql>
      </module>
    </database>
  </package>

  <package version="97" date="13-11-2006" internalversion="18.10.1.0">
    <database file="Ecom.mdb">
      <EcomProductGroupField>
        <sql conditional="">CREATE TABLE EcomProductGroupField (ProductGroupFieldID VARCHAR (50) PRIMARY KEY NOT NULL, ProductGroupFieldName VARCHAR (255) NOT NULL, ProductGroupFieldSystemName VARCHAR (255) NOT NULL, ProductGroupFieldTemplateName VARCHAR (255) NOT NULL, ProductGroupFieldTypeID INT NOT NULL DEFAULT 0, ProductGroupFieldTypeName VARCHAR (255) NOT NULL, ProductGroupFieldLocked BIT NOT NULL DEFAULT 0, ProductGroupFieldSort INT NOT NULL DEFAULT 0)</sql>
        <sql conditional="">CREATE INDEX [ProductGroupFieldTypeID] ON EcomProductGroupField (ProductGroupFieldTypeID)</sql>
        <sql conditional="">CREATE INDEX [ProductGroupFieldID] ON EcomProductGroupField (ProductGroupFieldID)</sql>
      </EcomProductGroupField>
      <EcomTree>
        <sql conditional="SELECT * FROM [EcomTree] WHERE [Text] = 'Varegruppe felter'">INSERT INTO EcomTree (parentId, [Text], Alt, TreeIcon, TreeIconOpen, TreeUrl, TreeChildPopulate, TreeSort, TreeHasAccessModuleSystemName) VALUES (13, 'Varegruppe felter', 7, 'tree/btn_groupfield.png', '', 'Lists/EcomList.aspx?type=GROUPFIELD', 'ROOT', 16, 'eCom_Catalog')</sql>
        <sql conditional="">UPDATE [EcomTree] SET [TreeSort]=17 WHERE id=45</sql>
        <sql conditional="">UPDATE [EcomTree] SET [TreeSort]=18 WHERE id=46</sql>
      </EcomTree>
      <EcomNumbers>
        <sql conditional="SELECT * FROM [EcomNumbers] WHERE [NumberID] = 35">INSERT INTO EcomNumbers (NumberID, NumberType, NumberDescription, NumberCounter, NumberPrefix, NumberPostFix, NumberAdd, NumberEditable) VALUES (35, 'GROUPFIELD', 'Varegruppe felter', 0, 'GROUPFIELD', '', 1, blnFalse)</sql>
      </EcomNumbers>
    </database>
  </package>

  <package version="96" date="13-11-2006" internalversion="18.10.1.0">
    <database file="Ecom.mdb">
      <EcomOrderLines>
        <sql conditional="">ALTER TABLE [EcomOrderLines] ADD OrderLinePageId INT NULL</sql>
      </EcomOrderLines>
    </database>
  </package>

  <package version="95" date="13-11-2006" internalversion="18.10.1.0">
    <database file="Ecom.mdb">
      <EcomFieldType>
        <sql conditional="">UPDATE EcomFieldType SET FieldTypeDBSQL = 'DATETIME NULL' WHERE FieldTypeID = 4</sql>
        <sql conditional="">UPDATE EcomFieldType SET FieldTypeDBSQL = 'DATETIME NULL' WHERE FieldTypeID = 5</sql>
      </EcomFieldType>
    </database>
  </package>

  <package version="94" date="13-11-2006" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <module>
        <sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName IN('FormV2', 'News2', 'RSSFeedExt')</sql>
      </module>
    </database>
  </package>

  <package version="93" date="13-11-2006" internalversion="18.11.1.0">
    <database file="Survey.mdb">
      <module>
        <sql conditional="">CREATE TABLE SurveyAnswerOption(SurveyAnswerOptionID int IDENTITY(1,1) PRIMARY KEY NOT NULL, SurveyAnswerOptionQuestionID int NULL DEFAULT (0), SurveyAnswerOptionActive bit NOT NULL DEFAULT (0), SurveyAnswerOptionText nvarchar(255) NULL, SurveyAnswerOptionSortOrder int NULL DEFAULT (0), SurveyAnswerOptionCorrectAnswer bit NOT NULL DEFAULT (0), SurveyAnswerOptionNextQuestionID int NULL DEFAULT (0))</sql>
        <sql conditional="SELECT * FROM SurveyQuestionType WHERE SurveyQuestionTypeName='CheckBox'">INSERT INTO SurveyQuestionType (SurveyQuestionTypeName) VALUES ('CheckBox')</sql>
        <sql conditional="SELECT * FROM SurveyQuestionType WHERE SurveyQuestionTypeName='DropDown'">INSERT INTO SurveyQuestionType (SurveyQuestionTypeName) VALUES ('DropDown')</sql>
        <sql conditional="SELECT * FROM SurveyQuestionType WHERE SurveyQuestionTypeName='RadioButton'">INSERT INTO SurveyQuestionType (SurveyQuestionTypeName) VALUES ('RadioButton')</sql>
        <sql conditional="SELECT * FROM SurveyQuestionType WHERE SurveyQuestionTypeName='TextArea'">INSERT INTO SurveyQuestionType (SurveyQuestionTypeName) VALUES ('TextArea')</sql>
        <sql conditional="SELECT * FROM SurveyResultStatus WHERE StatusName='Passed'">INSERT INTO SurveyResultStatus (StatusName) VALUES ('Passed')</sql>
        <sql conditional="SELECT * FROM SurveyResultStatus WHERE StatusName='Failed'">INSERT INTO SurveyResultStatus (StatusName) VALUES ('Failed')</sql>
        <sql conditional="SELECT * FROM SurveyResultStatus WHERE StatusName='Timed Out'">INSERT INTO SurveyResultStatus (StatusName) VALUES ('Timed Out')</sql>
      </module>
    </database>
  </package>
  <package version="92" date="13-11-2006" internalversion="18.11.1.0">
    <database file="Statisticsv2.mdb">
      <module>
        <sql conditional="">CREATE TABLE [StatsV2Trigger] (StatsV2TriggerID IDENTITY PRIMARY KEY NOT NULL, StatsV2TriggerName nvarchar (255) NULL ,StatsV2TriggerType int NOT NULL ,StatsV2TriggerAdminUser INT NOT NULL ,StatsV2TriggerPageClicks int NULL )</sql>
        <sql conditional="">CREATE TABLE [StatsV2TriggerMail] (StatsV2TriggerMailID IDENTITY PRIMARY KEY NOT NULL, StatsV2TriggerMailMessage ntext NULL, StatsV2TriggerMailAddress nvarchar (255) NOT NULL, StatsV2TriggerMailTitle nvarchar (255) NOT NULL, StatsV2TriggerMailDate datetime NOT NULL )</sql>
        <sql conditional="">CREATE TABLE [StatsV2TriggerSession] (StatsV2TriggerSessionID IDENTITY PRIMARY KEY NOT NULL ,StatsV2TriggerSessionFrom datetime NULL ,StatsV2TriggerSessionTo datetime NULL )</sql>
        <sql conditional="">CREATE TABLE [StatsV2TriggerStep] (StatsV2TriggerStepID IDENTITY PRIMARY KEY NOT NULL ,StatsV2TriggerStepTriggerID INT NOT NULL ,StatsV2TriggerStepType int NOT NULL ,StatsV2TriggerStepValue nvarchar (255) NULL ,StatsV2TriggerStepModuleID INT NULL ,StatsV2TriggerStepSortOrder int NULL )</sql>
        <sql conditional="">CREATE TABLE [Statv2Page] (Statv2PageID IDENTITY PRIMARY KEY NOT NULL ,Statv2PagePageID INT NULL ,Statv2PageSessionID INT NOT NULL ,Statv2PageObjectID INT NULL )</sql>
        <sql conditional="">CREATE TABLE [Statv2Report] (Statv2ReportID int PRIMARY KEY NOT NULL ,Statv2ReportType int NOT NULL ,Statv2ReportName nvarchar (255) NULL )</sql>
        <sql conditional="">CREATE TABLE [Statv2Summary] ( Statv2SummaryID IDENTITY PRIMARY KEY NOT NULL ,Statv2SummaryName nvarchar (255) NULL )</sql>
        <sql conditional="">CREATE TABLE [Statv2Type] (Statv2TypeID int PRIMARY KEY NOT NULL ,Statv2TypeName nvarchar (50) NULL )</sql>
        <sql conditional="">CREATE TABLE [Statv2s] (Statv2sID IDENTITY PRIMARY KEY NOT NULL ,Statv2sSummaryID INT NOT NULL ,Statv2sReportID int NOT NULL ,Statv2sSort int NULL )</sql>
      </module>
    </database>
  </package>
  <package version="91" date="10-11-2006" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">CREATE TABLE ScheduledTask (TaskID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, TaskName VARCHAR(255) NOT NULL, TaskBegin DATETIME NOT NULL, TaskEnd DATETIME NOT NULL, TaskLastRun DATETIME NOT NULL, TaskNextRun DATETIME NOT NULL, TaskEnabled BIT NOT NULL, TaskType INT NOT NULL, TaskMinute int NOT NULL DEFAULT -1, TaskHour int NOT NULL DEFAULT -1, TaskDay int NOT NULL DEFAULT -1, TaskWday int NOT NULL DEFAULT -1, TaskTarget VARCHAR(255) NOT NULL, TaskAssembly VARCHAR(255) NULL, TaskNamespace VARCHAR(255) NULL, TaskClass VARCHAR(255) NULL, TaskParam0 VARCHAR(255) NULL, TaskParam1 VARCHAR(255) NULL, TaskParam2 VARCHAR(255) NULL, TaskParam3 VARCHAR(255) NULL, TaskParam4 VARCHAR(255) NULL)</sql>
        <sql conditional="">CREATE TABLE ScheduledTaskType (TypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, TypeName VARCHAR(255) NOT NULL)</sql>
      </Module>
    </database>
  </package>
  <package version="89" date="10-11-2006" internalversion="18.11.1.0">
    <database file="Survey.mdb">
      <Module>
        <sql conditional="">CREATE TABLE Survey(SurveyID int IDENTITY(1,1) PRIMARY KEY NOT NULL, SurveyName nvarchar(255) NULL, SurveyDesc ntext NULL, SurveyIntro ntext NULL, SurveyActive bit NOT NULL DEFAULT (0), SurveyActiveFrom datetime NULL, SurveyActiveTo datetime NULL, SurveyFinishText ntext NULL, SurveyOutOfTimeText ntext NULL, SurveyCreatedBy int NULL DEFAULT (0), SurveyCreatedOn datetime NULL, SurveyModifiedBy int NULL DEFAULT (0), SurveyModifiedOn datetime NULL, SurveyMaxAmountTime int NULL DEFAULT (0), SurveyMinAmountCorrect int NULL DEFAULT (0), SurveyScore int NULL DEFAULT (0), SurveyAuthorizationType int NULL DEFAULT (0), SurveyCheckCookie bit NOT NULL DEFAULT (0), SurveyCheckIp bit NOT NULL DEFAULT (0), SurveyDisplayResultsImmediately bit NOT NULL DEFAULT (0), SurveyDisplayResultsAtCompletion bit NOT NULL DEFAULT (0), SurveyAllowRetry bit NOT NULL DEFAULT (0), SurveyDisplayResultsSeparate bit NOT NULL DEFAULT ((0)))</sql>
        <sql conditional="">CREATE TABLE SurveyParticipant(SurveyParticipantID int IDENTITY(1,1) PRIMARY KEY NOT NULL, SurveyParticipantExtranetUser int NULL DEFAULT (0), SurveyParticipantName nvarchar(50) NULL, SurveyParticipantEmail nvarchar(50) NULL, SurveyParticipantAddress nvarchar(50) NULL, SurveyParticipantIp nvarchar(255) NOT NULL)</sql>
        <sql conditional="">CREATE TABLE SurveyQuestion(SurveyQuestionID int IDENTITY(1,1) PRIMARY KEY NOT NULL, SurveyQuestionSurveyID int NULL DEFAULT (0), SurveyQuestionActive bit NOT NULL DEFAULT (0), SurveyQuestionText nvarchar(255) NULL, SurveyQuestionSortOrder int NULL DEFAULT (0), SurveyQuestionType int NULL DEFAULT (0), SurveyQuestionTextAreaEnabled bit NOT NULL DEFAULT (0), SurveyQuestionTextIsCorrect bit NOT NULL DEFAULT (0), SurveyQuestionDefaultValue nvarchar(255) NULL, SurveyQuestionMediaFile nvarchar(255) NULL, SurveyQuestionPageInstruction nvarchar(255) NULL)</sql>
        <sql conditional="">CREATE TABLE SurveyQuestionType(SurveyQuestionTypeID int IDENTITY(1,1) PRIMARY KEY NOT NULL, SurveyQuestionTypeName nvarchar(50) NULL)</sql>
        <sql conditional="">CREATE TABLE SurveyResult(SurveyResultID int IDENTITY(1,1) PRIMARY KEY NOT NULL, SurveyResultQuestionID int NULL DEFAULT (0), SurveyResultAnswerOptionID int NULL DEFAULT (0), SurveyResultParticipantID int NULL DEFAULT (0), SurveyResultCreatedOn datetime NULL, SurveyResultText nvarchar(255) NULL, SurveyResultStatus int NOT NULL DEFAULT (0))</sql>
        <sql conditional="">CREATE TABLE SurveyResultStatus(StatusID int IDENTITY(1,1) PRIMARY KEY NOT NULL, StatusName nvarchar(50) NOT NULL)</sql>
      </Module>
    </database>
    <!--
    <database file="ForumV2.mdb">
      <Module>
        <sql conditional="">CREATE TABLE ForumV2Ban(ForumV2BanID int IDENTITY(1,1) PRIMARY KEY NOT NULL, ForumV2BanAddress nvarchar(100) NOT NULL, ForumV2BanActive bit NOT NULL DEFAULT (0))</sql>
        <sql conditional="">CREATE TABLE ForumV2Category(ForumV2CategoryID int PRIMARY KEY IDENTITY(1,1) NOT NULL, ForumV2CategoryName nvarchar(100) NOT NULL, ForumV2CategoryDescription nvarchar(200) NOT NULL, ForumV2CategoryHTMLAllowed bit NOT NULL DEFAULT (0))</sql>
        <sql conditional="">CREATE TABLE ForumV2Censoring(ForumV2CensoringID int PRIMARY KEY IDENTITY(1,1) NOT NULL, ForumV2CensoringWord nvarchar(255) NOT NULL)</sql>
        <sql conditional="">CREATE TABLE ForumV2Emoticon(ForumV2EmoticonID int PRIMARY KEY IDENTITY(1,1) NOT NULL, ForumV2EmoticonCombination nvarchar(30) NULL, ForumV2EmoticonIcon nvarchar(255) NULL)</sql>
        <sql conditional="">CREATE TABLE ForumV2Moderator(ForumV2ModeratorID int PRIMARY KEY IDENTITY(1,1) NOT NULL, ForumV2ModeratorUserID int NOT NULL DEFAULT (0), ForumV2ModeratorCategoryID int NOT NULL DEFAULT (0))</sql>
        <sql conditional="">CREATE TABLE ForumV2Post(ForumV2PostID int PRIMARY KEY IDENTITY(1,1) NOT NULL, ForumV2PostThreadID int NOT NULL DEFAULT (0), ForumV2PostUserID int NULL DEFAULT (0), ForumV2PostHeadline nvarchar(150) NOT NULL, ForumV2PostText ntext NULL, ForumV2PostDate datetime NOT NULL)</sql>
        <sql conditional="">CREATE TABLE ForumV2Rank(ForumV2RankID int PRIMARY KEY IDENTITY(1,1) NOT NULL, ForumV2RankName nvarchar(100) NOT NULL, ForumV2RankCount int NOT NULL DEFAULT (0))</sql>
        <sql conditional="">CREATE TABLE ForumV2Settings(ForumV2SettingsID int PRIMARY KEY IDENTITY(1,1) NOT NULL, ForumV2SettingsHotStatusCount int NULL DEFAULT (0), ForumV2SettingsHotStatusHours int NULL DEFAULT (0), ForumV2SettingsHotStatusImage nvarchar(255) NULL, ForumV2SettingsHotStatusText nvarchar(200) NULL, ForumV2SettingsHotStatusUseMark nvarchar(150) NULL, ForumV2SettingsAutoPruneOld int NULL DEFAULT (0), ForumV2SettingsAutoPruneUnanswered int NULL DEFAULT (0), ForumV2SettingsManualPrune int NULL DEFAULT (0), ForumV2SettingsManualPruneOld bit NOT NULL DEFAULT (0), ForumV2SettingsManualPruneUnanswered bit NOT NULL DEFAULT (0), ForumV2SettingsSubscribeLinkPage nvarchar(255) NULL, ForumV2SettingsSubscribeSubject nvarchar(255) NULL, ForumV2SettingsSubscribeFromEmail nvarchar(255) NULL, ForumV2SettingsSubscribeTemplate nvarchar(255) NULL)</sql>
        <sql conditional="">CREATE TABLE ForumV2Subscribe(ForumV2SubscribeID int PRIMARY KEY IDENTITY(1,1) NOT NULL, ForumV2SubscribeUserID int NOT NULL DEFAULT (0), ForumV2SubscribeThreadID int NOT NULL DEFAULT (0), ForumV2SubscribeCategoryID int NOT NULL DEFAULT (0), ForumV2SubscribeAddress nvarchar(100) NOT NULL)</sql>
        <sql conditional="">CREATE TABLE ForumV2Thread(ForumV2ThreadID int PRIMARY KEY IDENTITY(1,1) NOT NULL, ForumV2ThreadCategoryID int NOT NULL DEFAULT (0), ForumV2ThreadVoteID int NULL DEFAULT (0), ForumV2ThreadUserID int NULL DEFAULT (0), ForumV2ThreadHeadline nvarchar(100) NOT NULL, ForumV2ThreadDescription nvarchar(150) NOT NULL, ForumV2ThreadText ntext NULL, ForumV2ThreadDate datetime NOT NULL, ForumV2ThreadClosed bit NOT NULL DEFAULT (0), ForumV2ThreadSticky bit NOT NULL DEFAULT (0))</sql>
        <sql conditional="">CREATE TABLE ForumV2Vote(ForumV2VoteID int PRIMARY KEY IDENTITY(1,1) NOT NULL, ForumV2VoteText nvarchar(255) NOT NULL)</sql>
        <sql conditional="">CREATE TABLE ForumV2VoteVariant(ForumV2VoteVariantID int PRIMARY KEY IDENTITY(1,1) NOT NULL, ForumV2VoteVariantVoteID int NOT NULL DEFAULT (0), ForumV2VoteVariantText nvarchar(100) NOT NULL, ForumV2VoteVariantCount int NOT NULL DEFAULT (0))</sql>
      </Module>
    </database>
    <database file="Weblog.mdb">
      <Module>
        <sql conditional="">CREATE TABLE WeblogArticle(WeblogArticleID int IDENTITY(1,1) PRIMARY KEY NOT NULL, WeblogArticleBlogID int NOT NULL DEFAULT (0), WeblogArticleUserID int NOT NULL DEFAULT (0), WeblogArticleCategoryID int NOT NULL DEFAULT (0), WeblogArticleHeadline nvarchar(100) NOT NULL, WeblogArticleDescription nvarchar(100) NULL, WeblogArticleText ntext NULL, WeblogArticlePublicationDate datetime NOT NULL, WeblogArticleDate datetime NOT NULL, WeblogArticleDraft bit NOT NULL DEFAULT (0))</sql>
        <sql conditional="">CREATE TABLE WeblogBan(WeblogBanID int IDENTITY(1,1) PRIMARY KEY NOT NULL, WeblogBanAddress nvarchar(100) NOT NULL, WeblogBanActive bit NOT NULL DEFAULT (0))</sql>
        <sql conditional="">CREATE TABLE WeblogBlog(WeblogBlogID int IDENTITY(1,1) PRIMARY KEY NOT NULL, WeblogBlogName nvarchar(50) NOT NULL, WeblogBlogUserID int NOT NULL DEFAULT (0), WeblogBlogDescription nvarchar(255) NULL,	WeblogBlogDate datetime NOT NULL)</sql>
        <sql conditional="">CREATE TABLE WeblogCategory(WeblogCategoryID int IDENTITY(1,1) PRIMARY KEY NOT NULL, WeblogCategoryName nvarchar(100) NOT NULL)</sql>
        <sql conditional="">CREATE TABLE WeblogComment(WeblogCommentID int IDENTITY(1,1) PRIMARY KEY NOT NULL, WeblogCommentArticleID int NOT NULL DEFAULT (0), WeblogCommentUserName nvarchar(50) NOT NULL, WeblogCommentEmail nvarchar(50) NOT NULL, WeblogCommentHeadline nvarchar(100) NOT NULL, WeblogCommentText ntext NULL, WeblogCommentDate datetime NOT NULL)</sql>
        <sql conditional="">CREATE TABLE WeblogFile(WeblogFileID int IDENTITY(1,1) PRIMARY KEY NOT NULL, WeblogFileUserID int NOT NULL DEFAULT (0), WeblogFileArticleID int NOT NULL DEFAULT (0), WeblogFileName nvarchar(200) NOT NULL)</sql>
        <sql conditional="">CREATE TABLE WeblogSettings(WeblogSettingsID int IDENTITY(1,1) PRIMARY KEY NOT NULL, WeblogSettingsSubscribed bit NOT NULL DEFAULT ((0)), WeblogSettingsMailTask bit NOT NULL DEFAULT ((0)), WeblogSettingsPage nvarchar(50) NULL, WeblogSettingsEmail nvarchar(50) NULL, WeblogSettingsLPSubject nvarchar(50) NULL, WeblogSettingsBUSubject nvarchar(50) NULL, WeblogSettingsNewPostTemplate nvarchar(50) NULL, WeblogSettingsNewPostRowTemplate nvarchar(50) NULL, WeblogSettingsAllowDrafts bit NOT NULL DEFAULT ((0)), WeblogSettingsAllowPostpone bit NOT NULL DEFAULT ((0)))</sql>
        <sql conditional="">CREATE TABLE WeblogSubscribe(WeblogSubscribeID int IDENTITY(1,1) PRIMARY KEY NOT NULL, WeblogSubscribeBlogID int NOT NULL DEFAULT ((0)), WeblogSubscribeAddress nvarchar(100) NOT NULL, WeblogSubscribeKey nvarchar(100) NOT NULL, WeblogSubscribeLastUpdated datetime NOT NULL)</sql>
        <sql conditional="">CREATE TABLE WeblogTeam(WeblogTeamID int IDENTITY(1,1) PRIMARY KEY NOT NULL, WeblogTeamUserID int NOT NULL DEFAULT ((0)), WeblogTeamBlogID int NOT NULL DEFAULT ((0)), WeblogTeamCreator bit NOT NULL DEFAULT ((0)), WeblogTeamAdministrator bit NOT NULL DEFAULT ((0)))</sql>
      </Module>
    </database>
    -->
    <database file="DBPub.mdb">
      <Module>
        <sql conditional="">CREATE TABLE DBPubField(DBPubFieldID int IDENTITY(1,1) PRIMARY KEY NOT NULL, DBPubFieldTable nvarchar(50) NULL, DBPubFieldAlly nvarchar(50) NULL, DBPubFieldName nvarchar(50) NULL, DBPubFieldTypeCode int NULL DEFAULT ((0)), DBPubFieldDBType nvarchar(50) NULL, DBPubFieldAllowDBNull bit NOT NULL DEFAULT ((0)), DBPubFieldUnique bit NOT NULL DEFAULT ((0)), DBPubFieldListView bit NOT NULL DEFAULT ((0)), DBPubFieldEditView bit NOT NULL DEFAULT ((0)), DBPubFieldDetailView bit NOT NULL DEFAULT ((0)), DBPubFieldSearch bit NOT NULL DEFAULT ((0)), DBPubFieldSort int NULL DEFAULT ((0)), DBPubFieldViewID int NULL DEFAULT ((0)), DBPubFieldReadOnly bit NOT NULL DEFAULT ((0)), DBPubFieldDefaultValue ntext NULL)</sql>
        <sql conditional="">CREATE TABLE DBPubView(DBPubViewID int IDENTITY(1,1) PRIMARY KEY NOT NULL, DBPubViewName nvarchar(50) NULL, DBPubViewType int NULL DEFAULT ((1)), DBPubViewDB ntext NULL, DBPubViewTable nvarchar(50) NULL, DBPubViewServer nvarchar(50) NULL, DBPubViewUser nvarchar(50) NULL, DBPubViewPassword nvarchar(50) NULL, DBPubViewLock int NULL DEFAULT ((0)), DBPubViewJoinID int NULL DEFAULT ((0)), DBPubViewWhereField nvarchar(50) NULL, DBPubViewWhereCompare nvarchar(50) NULL, DBPubViewWhereValue nvarchar(50) NULL, DBPubViewWhereIsObject bit NOT NULL DEFAULT ((0)), DBPubViewJoinTable nvarchar(50) NULL, DBPubViewJoinViewField nvarchar(50) NULL, DBPubViewJoinJoinField nvarchar(50) NULL, DBPubViewJoinType int NULL DEFAULT ((-1)), DBPubViewOrderByClause nvarchar(50) NULL, DBPubViewOrderByOrder nvarchar(50) NULL, DBPubViewFolder nvarchar(50) NULL, DBPubViewMasterList nvarchar(50) NULL, DBPubViewRow nvarchar(50) NULL, DBPubViewView nvarchar(50) NULL, DBPubViewEdit nvarchar(50) NULL, DBPubViewDelimiter nvarchar(50) NULL, DBPubViewPaging bit NOT NULL DEFAULT ((1)), DBPubViewSorting bit NOT NULL DEFAULT ((1)), DBPubViewAlter bit NOT NULL DEFAULT ((1)), DBPubViewDetailView bit NOT NULL DEFAULT ((1)), DBPubViewDetailEdit bit NOT NULL DEFAULT ((0)), DBPubViewDelete bit NOT NULL DEFAULT ((0)), DBPubViewSearch bit NOT NULL DEFAULT ((0)), DBPubViewAdd bit NOT NULL DEFAULT ((0)), DBPubViewCsvDelimiter nvarchar(50) NULL, DBPubViewCharacterSet nvarchar(50) NULL, DBPubViewDecimalSymbol nvarchar(50) NULL, DBPubViewIsFirstLineColumns bit NOT NULL DEFAULT ((0)), DBPubViewIsChild bit NOT NULL DEFAULT ((0)), DBPubViewRelationParentViewID int NULL DEFAULT ((0)), DBPubShowParentDetail bit NOT NULL DEFAULT ((0)), DBPubCustomSQL bit NOT NULL DEFAULT ((0)), DBPubSQL ntext NULL, DBPubHTMLEncode bit NOT NULL DEFAULT ((0)))</sql>
        <sql conditional="">CREATE TABLE Relation(RelationID int IDENTITY(1,1) PRIMARY KEY NOT NULL, RelationViewID int NULL DEFAULT ((0)), RelationParentField nvarchar(50) NULL, RelationParentType int NULL DEFAULT ((0)), RelationChildField nvarchar(50) NULL)</sql>
      </Module>
    </database>
    <database file="DBIntegration.mdb">
      <Module>
        <sql conditional="">CREATE TABLE Job(JobID int IDENTITY(1,1) PRIMARY KEY NOT NULL, JobName nvarchar(50) NULL, JobDSType int NULL DEFAULT ((0)), JobDTType int NULL DEFAULT ((0)), JobDSTable nvarchar(50) NULL, JobDTTable nvarchar(50) NULL, JobDSAccessFilename nvarchar(50) NULL, JobDSSQLDatabase nvarchar(50) NULL, JobDSSQLServer nvarchar(50) NULL, JobDSSQLUser nvarchar(50) NULL, JobDSSQLPassword nvarchar(50) NULL, JobDSCSVFolder nvarchar(50) NULL, JobDSCSVFolderDelimiter nvarchar(50) NULL, JobDSCSVFolderCharacterSet nvarchar(50) NULL, JobDSCSVFolderDecimalSymbol nvarchar(50) NULL, JobDSCSVFolderisFirstLineColumns bit NOT NULL DEFAULT ((0)), JobDSWSUrl nvarchar(50) NULL, JobDSWSQuery nvarchar(50) NULL, JobDTAccessFilename nvarchar(50) NULL, JobDeleteAllWhichIsNotUpdated bit NOT NULL DEFAULT ((0)))</sql>
        <sql conditional="">CREATE TABLE Map(MapID int IDENTITY(1,1) PRIMARY KEY NOT NULL, MapJobID int NULL DEFAULT ((0)), MapSourceField nvarchar(50) NULL, MapTargetField nvarchar(50) NULL)</sql>
      </Module>
    </database>
  </package>
  <package version="88" date="06-11-2006" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">ALTER TABLE [Module] ADD ModuleIsBeta BIT NULL</sql>
      </Module>
    </database>
  </package>
  <package version="87" date="07-11-2006" internalversion="18.11.1.0">
    <database file="Stylesheet.mdb">
      <BugFix>
        <sql conditional="">UPDATE SendFriendLayout SET SendFriendLayoutTemplate='SendToFriend.html' WHERE SendFriendLayoutTemplate='TipEnVen.html' OR SendFriendLayoutTemplate='' OR SendFriendLayoutTemplate IS NULL</sql>
      </BugFix>
    </database>
  </package>

  <package version="86" date="02-11-2006" internalversion="18.11.1.0">
    <!--<file name="Log.mdb"  target="Database" source="Database" />-->
    <database file="Log.mdb">
      <StatisticsCreate>
        <sql conditional="">CREATE TABLE ActionLog (LogID IDENTITY PRIMARY KEY NOT NULL, LogAction VARCHAR (255) NULL, LogEntityType VARCHAR (255) NULL, LogEntity VARCHAR (255) NULL, LogEntityID VARCHAR (255) NULL, LogLocationType VARCHAR (255) NULL, LogLocation VARCHAR (255) NULL, LogLocationID VARCHAR (255) NULL, LogDestinationType VARCHAR (255) NULL, LogDestination VARCHAR (255) NULL, LogDestinationID VARCHAR (255) NULL, LogUserName VARCHAR (255) NULL, LogDate datetime NOT NULL )</sql>
        <sql conditional="">CREATE TABLE GeneralLog (LogID IDENTITY PRIMARY KEY NOT NULL, LogAction VARCHAR (255) NULL, LogDate datetime NOT NULL, LogUserName VARCHAR (255) NULL, LogDescription ntext NULL)</sql>
        <sql conditional="">CREATE TABLE MailLog (MailLogID IDENTITY PRIMARY KEY NOT NULL, MailLogFromAddress VARCHAR (255) NULL, MailLogDate datetime NOT NULL, MailLogToAddress VARCHAR (255) NULL, MailLogCcAddress VARCHAR (255) NULL, MailLogBccAddress VARCHAR (255) NULL, MailLogServer VARCHAR (255) NULL, MailLogErrorException ntext NULL)</sql>
      </StatisticsCreate>
    </database>
  </package>

  <package version="85" date="02-11-2006" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <SeoPhrase>
        <sql conditional="">CREATE TABLE SeoPhrase (SeoPhraseID IDENTITY PRIMARY KEY NOT NULL, SeoPhrasePageId INT NOT NULL, SeoPhraseText VARCHAR (255) NULL)</sql>
      </SeoPhrase>
    </database>
  </package>

  <package version="84" date="06-11-2006" internalversion="18.11.1.0">
    <database file="Access.mdb">
      <Module>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserHideStat BIT NULL</sql>
      </Module>
    </database>
  </package>

  <package version="83" date="02-11-2006" internalversion="18.11.1.0">
    <file name="UserList.html"  target="Files/Templates/Dealersearch" source="Files/Templates/Dealersearch" />
    <file name="UserListElement.html"  target="Files/Templates/Dealersearch" source="Files/Templates/Dealersearch" />
    <file name="storelocator_info_image_template.swf"  target="Files/Templates/Dealersearch" source="Files/Templates/Dealersearch" />
    <file name="storelocator_info_image_template.fla"  target="Files/Templates/Dealersearch" source="Files/Templates/Dealersearch" />
    <database file="Dynamic.mdb">
      <module>
        <sql conditional="">ALTER TABLE DealerSearchDealer ADD DealerSearchDealerImage VARCHAR (255) NULL</sql>
      </module>
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleScript = 'ContentLink/ContentGroups_cpl.aspx' WHERE ModuleSystemName = 'ContentLinks'</sql>
      </Module>
    </database>
  </package>

  <package version="82" date="02-11-2006" internalversion="18.11.1.0">
    <folder source="Files/Templates/Survey" target="Files/Templates" />
    <!--<folder source="Files/Templates/ForumV2" target="Files/Templates" />
    <folder source="Files/ForumV2" target="Files" />-->
    <!--<file name="Survey.mdb"  target="Database" source="Database" />-->
    <!--<file name="ForumV2.mdb"  target="Database" source="Database" />-->
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Survey'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('Survey', 'Survey', 0, 0, 1, 0, 'Survey/Default.aspx', NULL, NULL, NULL)</sql>
        <!--<sql conditional="">DELETE FROM [Module] WHERE [ModuleSystemName] = 'ForumV2' AND NOT ModuleScript = 'ForumV2/Menu.aspx'</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'ForumV2'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('ForumV2', 'ForumV2', 0, 0, 1, 1, 'ForumV2/Menu.aspx', NULL, NULL, NULL)</sql>-->
      </Module>
    </database>
  </package>

  <package version="81" date="01-11-2006" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'ContentLinks'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('ContentLinks', 'Relaterede links', 0, 0, 0, 0, 'ContentLink/ContentLinks_cpl.aspx', NULL, NULL, NULL)</sql>
      </Module>
    </database>
  </package>

  <package version="80" date="01-11-2006" internalversion="18.11.1.0">
    <folder source="Files/Templates/StatisticsV3" target="Files/Templates" />
    <folder source="Files/Templates/News/SubmitNews" target="Files/Templates/News" />
    <!--
    <folder source="Files/Templates/Weblog" target="Files/Templates" />
    <file name="Weblog.mdb"  target="Database" source="Database" />
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Weblog'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('Weblog', 'Weblog', 0, 0, 1, 0, 'Weblog/Blog_List.aspx', NULL, NULL, NULL)</sql>
      </Module>
    </database>
    -->
    <database file="StatisticsV2.mdb">
      <StatisticsCreate>
        <sql conditional="">CREATE TABLE [StatsV2Trigger] (StatsV2TriggerID IDENTITY PRIMARY KEY NOT NULL, StatsV2TriggerName nvarchar (255) NULL ,StatsV2TriggerType int NOT NULL ,StatsV2TriggerAdminUser INT NOT NULL ,StatsV2TriggerPageClicks int NULL )</sql>
        <sql conditional="">CREATE TABLE [StatsV2TriggerMail] (StatsV2TriggerMailID IDENTITY PRIMARY KEY NOT NULL, StatsV2TriggerMailMessage ntext NULL, StatsV2TriggerMailAddress nvarchar (255) NOT NULL, StatsV2TriggerMailTitle nvarchar (255) NOT NULL, StatsV2TriggerMailDate datetime NOT NULL )</sql>
        <sql conditional="">CREATE TABLE [StatsV2TriggerSession] (StatsV2TriggerSessionID IDENTITY PRIMARY KEY NOT NULL ,StatsV2TriggerSessionFrom datetime NULL ,StatsV2TriggerSessionTo datetime NULL )</sql>
        <sql conditional="">CREATE TABLE [StatsV2TriggerStep] (StatsV2TriggerStepID IDENTITY PRIMARY KEY NOT NULL ,StatsV2TriggerStepTriggerID INT NOT NULL ,StatsV2TriggerStepType int NOT NULL ,StatsV2TriggerStepValue nvarchar (255) NULL ,StatsV2TriggerStepModuleID INT NULL ,StatsV2TriggerStepSortOrder int NULL )</sql>
        <sql conditional="">CREATE TABLE [Statv2Page] (Statv2PageID IDENTITY PRIMARY KEY NOT NULL ,Statv2PagePageID INT NULL ,Statv2PageSessionID INT NOT NULL ,Statv2PageObjectID INT NULL )</sql>
        <sql conditional="">CREATE TABLE [Statv2Report] (Statv2ReportID int PRIMARY KEY NOT NULL ,Statv2ReportType int NOT NULL ,Statv2ReportName nvarchar (255) NULL )</sql>
        <sql conditional="">CREATE TABLE [Statv2Summary] ( Statv2SummaryID IDENTITY PRIMARY KEY NOT NULL ,Statv2SummaryName nvarchar (255) NULL )</sql>
        <sql conditional="">CREATE TABLE [Statv2Type] (Statv2TypeID int PRIMARY KEY NOT NULL ,Statv2TypeName nvarchar (50) NULL )</sql>
        <sql conditional="">CREATE TABLE [Statv2s] (Statv2sID IDENTITY PRIMARY KEY NOT NULL ,Statv2sSummaryID INT NOT NULL ,Statv2sReportID int NOT NULL ,Statv2sSort int NULL )</sql>
      </StatisticsCreate>
      <StatisticsAddConstraints>
        <sql conditional="">ALTER TABLE [StatsV2TriggerStep] ADD CONSTRAINT StatsV2TriggerStep_FK00 FOREIGN KEY (StatsV2TriggerStepTriggerID) REFERENCES StatsV2Trigger (StatsV2TriggerID)</sql>
        <sql conditional="">ALTER TABLE [Statv2Report] ADD CONSTRAINT Statv2Report_FK00wwww FOREIGN KEY (Statv2ReportType) REFERENCES Statv2Type (Statv2TypeID)</sql>
        <sql conditional="">ALTER TABLE [Statv2s] ADD CONSTRAINT Statv2s_FK00 FOREIGN KEY (	Statv2sReportID	) REFERENCES Statv2Report (Statv2ReportID)</sql>
        <sql conditional="">ALTER TABLE [Statv2s] ADD CONSTRAINT Statv2s_FK01 FOREIGN KEY (	Statv2sSummaryID) REFERENCES Statv2Summary (Statv2SummaryID)</sql>
        <sql conditional="">ALTER TABLE [Statv2Page] ADD CONSTRAINT Statv2Page_FK01 FOREIGN KEY (Statv2PageObjectID) REFERENCES Statv2Object (Statv2ObjectID)</sql>
      </StatisticsAddConstraints>
      <StatisticsCreateIndexes>
        <sql conditional="">CREATE INDEX STATV2_PAGE_IDX001 ON Statv2Page (Statv2PageObjectID)</sql>
        <sql conditional="">CREATE INDEX STATV2_PAGE_IDX002 ON Statv2Page (Statv2PageSessionID)</sql>
        <sql conditional="">CREATE INDEX STATV2_PAGE_IDX003 ON Statv2Page (Statv2PagePageID)</sql>
      </StatisticsCreateIndexes>
      <StatisticsInsertTypes>
        <sql conditional="SELECT * FROM [Statv2Type] WHERE [Statv2TypeName]='Graph'">INSERT INTO [Statv2Type](Statv2TypeID, Statv2TypeName) values(1, 'Graph')</sql>
        <sql conditional="SELECT * FROM [Statv2Type] WHERE [Statv2TypeName]='Summary'">INSERT INTO [Statv2Type](Statv2TypeID, Statv2TypeName) values(2, 'Summary')</sql>
        <sql conditional="SELECT * FROM [Statv2Type] WHERE [Statv2TypeName]='Sitemap'">INSERT INTO [Statv2Type](Statv2TypeID, Statv2TypeName) values(3, 'Sitemap')</sql>
      </StatisticsInsertTypes>
      <StatisticsInsertReports>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=2">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(2, 1, 'Visitors - Day')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=3">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(3, 1, 'Visitors - Week')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=4">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(4, 1, 'Visitors - Month')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=5">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(5, 1, 'Visitors - Year')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=6">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(6, 1, 'Visitors - Weekdays')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=7">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(7, 1, 'Visitors - Hour')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=8">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(8, 1, 'Visitors - UniqueVisitor')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=9">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(9, 1, 'Visitors - Averege time per visit')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=10">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(10, 1, 'Visitors - New visits')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=11">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(11, 2, 'Visitors - Last # visitors')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=12">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(12, 1, 'Visitors - Language')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=13">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(13, 1, 'PageViews - Most visited pages')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=14">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(14, 1, 'PageViews - Day')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=15">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(15, 1, 'PageViews - Week')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=16">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(16, 1, 'PageViews - Month')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=17">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(17, 1, 'PageViews - Year')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=18">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(18, 1, 'PageViews - Entry pages')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=19">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(19, 1, 'PageViews - Exit pages') </sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=20">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(20, 1, 'PageViews - Per visit')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=21">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(21, 1, 'PageViews - Pages with one visit')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=22">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(22, 1, 'PageViews - Time per page')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=23">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(23, 3, 'PageViews - Sitemap')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=24">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(24, 1, 'Files-Download')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=25">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(25, 1, 'Referrals - URL')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=26">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(26, 1, 'Referrals - Domain')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=27">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(27, 1, 'Referrals - Entry pages')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=28">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(28, 1, 'System - Browser')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=29">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(29, 1, 'System - OS') </sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=30">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(30, 1, 'System - Browser by operating system (OS)')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=31">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(31, 1, 'System - Browser by platform')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=32">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(32, 1, 'System - Operating system (OS) by browsers')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=33">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(33, 1, 'System - Resolution')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=34">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(34, 1, 'System - Resolution, ordered')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=35">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(35, 1, 'System - Colors')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=36">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(36, 1, 'System - Connection speed')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=37">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(37, 1, 'Search - Indexing')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=38">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(38, 1, 'Search - Indexing per week') </sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=39">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(39, 1, 'Search - Pages')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=40">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(40, 1, 'Search - Engines')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=41">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(41, 1, 'Search - Engines per week') </sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=42">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(42, 1, 'Search - Keyword')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=43">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(43, 1, 'Search -  Keywords by search engine')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=44">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(44, 1, 'Modules-Search v1') </sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=45">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(45, 1, 'Modules-Extranet')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=46">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(46, 1, 'Modules-Extranet, per week')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=47">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(47, 2, 'Modules-Extranet, latest')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=48">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(48, 1, 'Modules-News')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=49">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(49, 1, 'Modules-Poll')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=50">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(50, 1, 'Modules-Forms')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=51">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(51, 1, 'Unique Ips - Day')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=52">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(52, 1, 'Unique Ips - Week')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=53">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(53, 1, 'Unique Ips - Month')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=54">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(54, 1, 'Unique Ips - Year')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=55">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(55, 1, 'Unique Ips - WeekDay')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=56">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(56, 1, 'Unique Ips - Hour')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=57">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(57, 2, 'Summary - Last # visitors')</sql>
        <sql conditional="SELECT * FROM [Statv2Report] WHERE [Statv2ReportID]=58">INSERT INTO [Statv2Report](Statv2ReportID, Statv2ReportType, Statv2ReportName) values(58, 1, 'Summary - Per day')</sql>
      </StatisticsInsertReports>
      <StatisticsInsertSummary>
        <sql conditional="SELECT * FROM [Statv2Summary] WHERE [Statv2SummaryName]='Default'">INSERT INTO [Statv2Summary](Statv2SummaryName) values('Default')</sql>
      </StatisticsInsertSummary>
      <StatisticsInsertDefaultReport>
        <sql conditional="SELECT * FROM [Statv2s] WHERE [Statv2sReportID]=57 AND [Statv2sSummaryID]=1">INSERT INTO [Statv2s](Statv2sSummaryID, Statv2sReportID, Statv2sSort) values(1, 57, 0)</sql>
        <sql conditional="SELECT * FROM [Statv2s] WHERE [Statv2sReportID]=58 AND [Statv2sSummaryID]=1">INSERT INTO [Statv2s](Statv2sSummaryID, Statv2sReportID, Statv2sSort) values(1, 58, 1)</sql>
      </StatisticsInsertDefaultReport>
    </database>
  </package>

  <package version="79" date="30-10-2006" internalversion="18.11.1.0">
    <!--<file name="DBIntegration.mdb"  target="Database" source="Database" />
    <file name="DBPub.mdb"  target="Database" source="Database" />-->
    <folder source="Files/Templates/DBPub2" target="Files/Templates" />
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'DBIntegration'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('DBIntegration', 'Database Integration', 0, 0, 0, 0, 'DBIntegration/DBIntegration_List.aspx', NULL, NULL, NULL)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'DbPub'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('DbPub', 'Database Publishing', 0, 0, 1, 0, 'DbPub/DbPub_List.aspx', NULL, NULL, NULL)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Metadata'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph,ModuleControlPanel) values ('Metadata', 'Metadata', 0, 1, 'Metadata/Metadata_module.aspx', 0, 'Metadata_cpl.aspx' )</sql>
        <!--<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'IntranoteIntegration'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('IntranoteIntegration', 'Intranote Integration', 0, 0, 1, 0, NULL, NULL, NULL)</sql>-->
      </Module>
      <NewTable>
        <sql conditional="">CREATE TABLE Metadata (MetadataID IDENTITY PRIMARY KEY NOT NULL,MetadataPageID int NULL ,MetadataFieldID int NULL ,MetadataOption ntext NULL )</sql>
        <sql conditional="">CREATE TABLE MetadataCategory (CategoryID IDENTITY PRIMARY KEY NOT NULL,CategoryFieldID int NULL ,CategoryName nvarchar(255) NULL )</sql>
        <sql conditional="">CREATE TABLE MetadataField (FieldID IDENTITY PRIMARY KEY NOT NULL,FieldTypeID int NULL ,FieldName nvarchar(255)  NULL ,FieldDefault BIT NOT NULL  DEFAULT 0, FieldMandatory BIT NOT NULL  DEFAULT 0)</sql>
        <sql conditional="">CREATE TABLE MetadataOption (OptionID IDENTITY PRIMARY KEY NOT NULL,OptionCategoryID int NULL ,OptionValue nvarchar(255) NULL )</sql>
        <sql conditional="">CREATE TABLE MetadataType (TypeID IDENTITY PRIMARY KEY NOT NULL,TypeName nvarchar(255) NULL)</sql>
        <sql conditional="">ALTER TABLE Metadata ADD CONSTRAINT Metadata_FK00 FOREIGN KEY (MetadataFieldID) REFERENCES MetadataField (FieldID)</sql>
        <sql conditional="">ALTER TABLE MetadataCategory ADD CONSTRAINT MetadataCategory_FK00 FOREIGN KEY (CategoryFieldID) REFERENCES MetadataField (FieldID)</sql>
        <sql conditional="">ALTER TABLE MetadataField ADD CONSTRAINT MetadataField_FK00 FOREIGN KEY (FieldTypeID) REFERENCES MetadataType (TypeID)</sql>
        <sql conditional="">ALTER TABLE MetadataOption ADD CONSTRAINT MetadataOption_FK00 FOREIGN KEY (OptionCategoryID) REFERENCES MetadataCategory (CategoryID)</sql>
        <sql conditional="SELECT * FROM [MetadataType] WHERE [TypeName] = 'Text'">INSERT INTO [MetadataType] (TypeName) values ('Text')</sql>
        <sql conditional="SELECT * FROM [MetadataType] WHERE [TypeName] = 'Fill in'">INSERT INTO [MetadataType] (TypeName) values ('Fill in')</sql>
        <sql conditional="SELECT * FROM [MetadataType] WHERE [TypeName] = 'Dropdown'">INSERT INTO [MetadataType] (TypeName) values ('Dropdown')</sql>
        <sql conditional="SELECT * FROM [MetadataType] WHERE [TypeName] = 'Multi dropdown'">INSERT INTO [MetadataType] (TypeName) values ('Multi dropdown')</sql>
        <sql conditional="SELECT * FROM [MetadataField] WHERE [FieldName] = 'Title'">INSERT INTO [MetadataField] (FieldTypeID, FieldName, FieldDefault) values (1, 'Title', 1)</sql>
        <sql conditional="SELECT * FROM [MetadataField] WHERE [FieldName] = 'Description'">INSERT INTO [MetadataField] (FieldTypeID, FieldName, FieldDefault) values (1, 'Description', 1)</sql>
        <sql conditional="SELECT * FROM [MetadataField] WHERE [FieldName] = 'Keywords'">INSERT INTO [MetadataField] (FieldTypeID, FieldName, FieldDefault) values (1, 'Keywords', 1)</sql>
      </NewTable>
      <IntranoteIntegration>
        <sql conditional="">ALTER TABLE Page ADD PageTopLevelIntegration BIT NOT NULL DEFAULT 0</sql>
        <sql conditional="">ALTER TABLE Page ADD PageForIntegration BIT NOT NULL DEFAULT 0</sql>
        <!--<sql conditional="">CREATE TABLE IntranotePostType (TypeID IDENTITY PRIMARY KEY NOT NULL, TypeName NVARCHAR(64) NOT NULL)</sql>
        <sql conditional="">CREATE TABLE IntranoteOptions (Id IDENTITY PRIMARY KEY NOT NULL, Salt NVARCHAR(64) NOT NULL)</sql>
        <sql conditional="">CREATE TABLE IntranoteHtml (HtmlID IDENTITY PRIMARY KEY NOT NULL, HtmlOriginal MEMO NULL, HtmlStripped MEMO NULL)</sql>
        <sql conditional="">CREATE TABLE IntranotePost (PostPageID INT PRIMARY KEY NOT NULL, PostType INT NOT NULL, PostIntranoteID INT NOT NULL, PostLanguageID INT NOT NULL, PostDefault BIT NOT NULL DEFAULT 0, PostHtml INT NOT NULL, PostUrl NVARCHAR(255) NULL, FOREIGN KEY (PostPageID) REFERENCES Page(PageID) ON DELETE CASCADE, FOREIGN KEY (PostType) REFERENCES IntranotePostType(TypeID), FOREIGN KEY (PostHtml) REFERENCES IntranoteHtml(HtmlID))</sql>
        <sql conditional="">CREATE TABLE IntranoteFile (FileIntranoteID INT PRIMARY KEY NOT NULL, FileType NTEXT(64) NULL, FileName NTEXT(255) NOT NULL, FileDwFolder NTEXT(255) NULL)</sql>
        <sql conditional="">CREATE TABLE IntranoteEventMap (EventMapDwID INT NOT NULL, EventMapIntraID INT NOT NULL, PRIMARY KEY (EventMapDwID, EventMapIntraID))</sql>
        <sql conditional="">CREATE TABLE IntranoteCalendarMap (CalendarMapDwID INT NOT NULL, CalendarMapIntraID INT NOT NULL, PRIMARY KEY (CalendarMapDwID, CalendarMapIntraID))</sql>
        <sql conditional="">CREATE TABLE IntranoteBrokenLink (LinkID IDENTITY PRIMARY KEY NOT NULL, LinkHtml INT NOT NULL, LinkIntraID INT NOT NULL, FOREIGN KEY (LinkHtml) REFERENCES IntranoteHtml(HtmlID) ON DELETE CASCADE)</sql>
        <sql conditional="SELECT * FROM [IntranotePostType] WHERE [TypeName] = 'Normal Post'">INSERT INTO IntranotePostType (TypeName) VALUES ('Normal Post')</sql>
        <sql conditional="SELECT * FROM [IntranotePostType] WHERE [TypeName] = 'Posts List'">INSERT INTO IntranotePostType (TypeName) VALUES ('Posts List')</sql>
        <sql conditional="SELECT * FROM [IntranotePostType] WHERE [TypeName] = 'Post Item'">INSERT INTO IntranotePostType (TypeName) VALUES ('Post Item')</sql>
        <sql conditional="SELECT * FROM [IntranotePostType] WHERE [TypeName] = 'External Link'">INSERT INTO IntranotePostType (TypeName) VALUES ('External Link')</sql>
        <sql conditional="SELECT * FROM [IntranoteOptions] WHERE [Salt] = '2B37536A665271434B4C704A416957524E58677872773D3D'">INSERT INTO IntranoteOptions (Salt) VALUES ('2B37536A665271434B4C704A416957524E58677872773D3D')</sql>-->
      </IntranoteIntegration>
    </database>
  </package>
  <package version="78" date="30-10-2006" internalversion="18.11.1.0">
    <database file="Access.mdb">
      <Module>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserEditorConfigurationID INT NULL</sql>
      </Module>
    </database>
  </package>

  <package version="77" date="30-10-2006" internalversion="18.11.1.0">
    <!--
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'FormV2'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('FormV2', 'Form V2', 0, 0, 1, 0, 'FormV2/Form_Module_List.aspx', NULL, NULL, NULL)</sql>
      </Module>
    </database>
    -->
  </package>

  <package version="76" date="30-10-2006" internalversion="18.11.1.0">
    <database file="Access.mdb">
      <Module>
        <sql conditional="">CREATE TABLE EditorConfiguration (EditorConfigurationID IDENTITY PRIMARY KEY NOT NULL, EditorConfigurationName VARCHAR(255) NOT NULL, EditorConfigurationXML MEMO NULL)</sql>
      </Module>
    </database>
  </package>

  <package version="75" date="30-10-2006" internalversion="18.11.1.0">
    <folder source="Files/Templates/SitemapV2" target="Files/Templates" />
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'SitemapV2'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('SitemapV2', 'SitemapV2', 0, 0, 1, 0, NULL, NULL, NULL)</sql>
      </Module>
    </database>
  </package>

  <package version="74" date="30-10-2006" internalversion="18.11.1.0">
    <folder source="Files/Templates/RSSFeed/RSSElement" target="Files/Templates/RSSFeed" />
    <folder source="Files/Templates/RSSFeed/RSSList" target="Files/Templates/RSSFeed" />
    <database file="Dynamic.mdb">
      <ScheduledTask>
        <sql conditional="">CREATE TABLE ScheduledTaskType (TypeID IDENTITY PRIMARY KEY NOT NULL, TypeName VARCHAR(255) NOT NULL)</sql>
        <sql conditional="SELECT * FROM [ScheduledTaskType] WHERE [TypeName] = 'Dynamicweb page'">INSERT INTO ScheduledTaskType (TypeName) VALUES ('Dynamicweb page')</sql>
        <sql conditional="SELECT * FROM [ScheduledTaskType] WHERE [TypeName] = 'File from DW file archive'">INSERT INTO ScheduledTaskType (TypeName) VALUES ('File from DW file archive')</sql>
        <sql conditional="SELECT * FROM [ScheduledTaskType] WHERE [TypeName] = 'URL'">INSERT INTO ScheduledTaskType (TypeName) VALUES ('URL')</sql>
        <sql conditional="SELECT * FROM [ScheduledTaskType] WHERE [TypeName] = 'Method in a class'">INSERT INTO ScheduledTaskType (TypeName) VALUES ('Method in a class')</sql>
        <sql conditional="">CREATE TABLE ScheduledTask (TaskID IDENTITY PRIMARY KEY NOT NULL, TaskName VARCHAR(255) NOT NULL, TaskBegin DATETIME NOT NULL, TaskEnd DATETIME NOT NULL, TaskLastRun DATETIME NOT NULL, TaskNextRun DATETIME NOT NULL,  TaskEnabled BIT NOT NULL, TaskType INT NOT NULL, TaskMinute SHORT NOT NULL DEFAULT -1, TaskHour SHORT NOT NULL DEFAULT -1, TaskDay SHORT NOT NULL DEFAULT -1, TaskWday SHORT NOT NULL DEFAULT -1, TaskTarget VARCHAR(255) NOT NULL, TaskAssembly VARCHAR(255) NULL, TaskNamespace VARCHAR(255) NULL, TaskClass VARCHAR(255) NULL, TaskParam0 VARCHAR(255) NULL, TaskParam1 VARCHAR(255) NULL, TaskParam2 VARCHAR(255) NULL, TaskParam3 VARCHAR(255) NULL, TaskParam4 VARCHAR(255) NULL, FOREIGN KEY (TaskType) REFERENCES ScheduledTaskType(TypeID))</sql>
      </ScheduledTask>
    </database>
  </package>

  <package version="73" date="30-10-2006" internalversion="18.11.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">ALTER TABLE [Area] ADD AreaActive BIT NULL</sql>
        <sql conditional="">ALTER TABLE [Area] ADD AreaSort INT NULL</sql>
        <sql conditional="SELECT * FROM Area WHERE AreaActive=1">UPDATE [Area] SET AreaActive=1</sql>
        <sql conditional="">UPDATE [Area] SET AreaSort=AreaID WHERE AreaSort=0 OR AreaSort IS NULL</sql>
      </Module>
    </database>
  </package>

  <package version="72" date="30-10-2006" internalversion="18.11.1.0">
    <!--<file name="Log.mdb"  target="Database" source="Database" />-->
  </package>

  <package version="71" date="30-10-2006" internalversion="18.11.1.0">
    <!--
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">CREATE TABLE ContentGroup (ContentGroupID IDENTITY PRIMARY KEY NOT NULL, ContentGroupName VARCHAR (255) NULL, ContentGroupLoopName VARCHAR (255) NULL)</sql>
        <sql conditional="">CREATE TABLE ContentGroupRelation (ContentRelationID IDENTITY PRIMARY KEY NOT NULL, PageID INT NULL, ContentGroupID INT NULL, AreaID INT NULL)</sql>
        <sql conditional="">CREATE TABLE ContentLink (ContentLinkID IDENTITY PRIMARY KEY NOT NULL, ContentLinkURL NTEXT NULL, ContentLinkText VARCHAR (255) NULL, ContentLinkImage VARCHAR (255) NULL, ContentLinkTemplateTag VARCHAR (255) NULL, ContentLinkInLoop BIT NULL, ContentLinkSort INT NULL, ContentLinkRelationID INT NOT NULL, FOREIGN KEY (ContentLinkRelationID) REFERENCES ContentGroupRelation(ContentRelationID))</sql>
      </Module>
    </database>
    -->
  </package>

  <package version="70" date="24-10-2006" internalversion="18.10.1.0">
    <database file="Dynamic.mdb">
      <DealerSearchUserField>
        <sql conditional="">UPDATE DealerSearchUserField SET DealerSearchUserFieldSort = DealerSearchUserFieldID WHERE DealerSearchUserFieldSort = 0 OR DealerSearchUserFieldSort IS NULL</sql>
      </DealerSearchUserField>
    </database>
  </package>

  <package version="69" date="23-10-2006" internalversion="18.10.1.0">
    <database file="Dynamic.mdb">
      <TemplateMenu>
        <sql conditional="">ALTER TABLE TemplateMenu ADD TemplateMenuEcomTreeType INT NULL DEFAULT 0</sql>
        <sql conditional="">ALTER TABLE TemplateMenu ADD TemplateMenuEcomShopID VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE TemplateMenu ADD TemplateMenuEcomGroupID VARCHAR (255) NULL</sql>
        <sql conditional="">ALTER TABLE TemplateMenu ADD TemplateMenuEcomMaxLevel INT NULL DEFAULT 0</sql>
        <sql conditional="">ALTER TABLE TemplateMenu ADD TemplateMenuEcomProductPage VARCHAR (255) NULL</sql>
      </TemplateMenu>
      <TemplateMenuType>
        <sql conditional="SELECT * FROM [TemplateMenuType] WHERE [TemplateMenuTypeName] = 'Ecom varegrupper'">INSERT INTO TemplateMenuType (TemplateMenuTypeName) VALUES ('Ecom varegrupper')</sql>
      </TemplateMenuType>
    </database>
  </package>

  <package version="68" date="04-10-2006" internalversion="18.10.1.0">
    <folder source="Files/Templates/eCom" target="Files/Templates/" />
  </package>

  <package version="67" date="24-08-2006" internalversion="18.10.1.0">
    <database file="Dynamic.mdb">
      <Area>
        <sql conditional="">ALTER TABLE [Area] ADD AreaEcomLanguageID  VARCHAR (50)</sql>
        <sql conditional="">ALTER TABLE [Area] ADD AreaEcomCurrencyID  VARCHAR (50)</sql>
      </Area>
    </database>
  </package>

  <package version="66" date="15-09-2006" internalversion="18.10.1.0">
    <database file="Ecom.mdb">
      <EcomOrders>
        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderPriceBeforeFeesWithVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderPriceBeforeFeesWithoutVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderPriceBeforeFeesVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderPriceBeforeFeesVATPercent DOUBLE</sql>
      </EcomOrders>
    </database>
  </package>

  <package version="65" date="14-09-2006" internalversion="18.10.1.0">
    <database file="Ecom.mdb">
      <EcomOrders>
        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderPriceWithVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderPriceWithoutVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderPriceVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderPriceVATPercent DOUBLE</sql>

        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderShippingFeeWithVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderShippingFeeWithoutVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderShippingFeeVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderShippingFeeVATPercent DOUBLE</sql>

        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderPaymentFeeWithVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderPaymentFeeWithoutVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderPaymentFeeVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderPaymentFeeVATPercent DOUBLE</sql>
      </EcomOrders>
      <EcomOrderLines>
        <sql conditional="">ALTER TABLE [EcomOrderLines] ADD OrderLinePriceWithVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrderLines] ADD OrderLinePriceWithoutVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrderLines] ADD OrderLinePriceVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrderLines] ADD OrderLinePriceVATPercent DOUBLE</sql>

        <sql conditional="">ALTER TABLE [EcomOrderLines] ADD OrderLineUnitPriceWithVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrderLines] ADD OrderLineUnitPriceWithoutVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrderLines] ADD OrderLineUnitPriceVAT DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrderLines] ADD OrderLineUnitPriceVATPercent DOUBLE</sql>
      </EcomOrderLines>
    </database>
  </package>
  <package version="64" date="13-09-2006" internalversion="18.10.1.0">
    <database file="Ecom.mdb">
      <EcomOrderLines>
        <sql conditional="">ALTER TABLE [EcomOrderLines] ADD OrderLineUnitID VARCHAR (50)</sql>
        <sql conditional="">ALTER TABLE [EcomOrderLines] ADD OrderLineWeight DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrderLines] ADD OrderLineVolume DOUBLE</sql>
      </EcomOrderLines>
      <EcomOrders>
        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderWeight DOUBLE</sql>
        <sql conditional="">ALTER TABLE [EcomOrders] ADD OrderVolume DOUBLE</sql>
      </EcomOrders>
    </database>
  </package>

  <package version="63" date="13-09-2006" internalversion="18.10.1.0">
    <database file="Ecom.mdb">
      <EcomTree>
        <sql conditional="">UPDATE [EcomTree] SET [Text]='Dynamicweb eCommerce', TreeIcon='tree/Home_small.gif' WHERE id=1</sql>
        <sql conditional="">UPDATE [EcomTree] SET [Text]='Varekatalog', TreeIcon='tree/Module_eCom_Catalog_small.gif', Alt=9 WHERE id=3</sql>
        <sql conditional="">UPDATE [EcomTree] SET [Text]='Indstillinger', TreeIcon='tree/Settings_small.gif' WHERE id=13</sql>
        <sql conditional="">UPDATE [EcomTree] SET [Text]='Opsætning', TreeIcon='tree/ControlPanel_small.gif' WHERE id=15</sql>
      </EcomTree>
    </database>
  </package>

  <package version="62" date="03-10-2006" internalversion="18.10.1.0">
    <!--<file name="Ecom.mdb" overwrite="false" target="Database" source="Database" />-->
  </package>

  <package version="61" date="20-08-2006" internalversion="18.10.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">ALTER TABLE [Module] ADD ModuleEcomNotInstalledAccess INT NULL</sql>
        <sql conditional="">ALTER TABLE [Module] ADD ModuleEcomStandardAccess INT NULL</sql>
        <sql conditional="">ALTER TABLE [Module] ADD ModuleEcomExtendedAccess INT NULL</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_NotInstalled'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_NotInstalled', 'eCom ikke installeret', 0, 1, Null, 0, 0, NULL, NULL, NULL)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_Standard'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_Standard', 'eCom standard', 0, 0, Null, 0, 0, NULL, NULL, NULL)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_Extended'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_Extended', 'eCom udvidet', 0, 0, Null, 0, 0, NULL, NULL, NULL)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_Search'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_Search', 'eCom sogning', 0, 0, Null, 0, 0, 0, 1, 1)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_Units'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_Units', 'eCom enheder', 0, 0, Null, 0, 0, 0, 1, 1)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_Related'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_Related', 'eCom relaterede varer', 0, 0, Null, 0, 0, 0, 2, 1)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_Assortments'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_Assortments', 'eCom sortimenter', 0, 0, Null, 0, 0, 0, 2, 1)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_Statistics'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_Statistics', 'eCom statistik', 0, 0, Null, 0, 0, 0, 2, 1)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_Reports'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_Reports', 'eCom rapporter', 0, 0, Null, 0, 0, 0, 2, 1)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_CustomerArea'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_CustomerArea', 'eCom kundecenter', 0, 0, Null, 0, 0, 0, 0, 0)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_Payment'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_Payment', 'eCom betalingsinterface', 0, 0, Null, 0, 0, 0, 2, 2)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_International'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_International', 'eCom internationalisering', 0, 0, Null, 0, 0, 0, 2, 2)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_Center'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_Center', 'eCom shoppingcenter', 0, 0, Null, 0, 0, 0, 0, 2)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_Pricing'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_Pricing', 'eCom priser', 0, 0, Null, 0, 0, 0, 1, 1)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_PricingExtended'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_PricingExtended', 'eCom udvidet priser', 0, 0, Null, 0, 0, 0, 0, 2)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_Variants'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_Variants', 'eCom varianter', 0, 0, Null, 0, 0, 0, 1, 1)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_VariantsExtended'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_VariantsExtended', 'eCom udvidet varianter', 0, 0, Null, 0, 0, 0, 0, 2)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_PartsLists'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_PartsLists', 'eCom styklister', 0, 0, Null, 0, 0, 0, 0, 2)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_PartsListsExtended'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_PartsListsExtended', 'eCom udvidet styklister', 0, 0, Null, 0, 0, 0, 0, 2)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_Catalog'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_Catalog', 'eCom varekatalog', 0, 0, 'eCom_Catalog/EcomFrame.aspx', 1, 0, 0, 1, 1)</sql>
        <!--<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_Cart'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_Cart', 'eCom indkobskurv', 0, 0, 'eCom_Catalog/Lists/EcomList.aspx?type=ORDER', 1, 0, 0, 2, 2)</sql>-->
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_ImportExport'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_ImportExport', 'eCom import/eksport', 0, 0, 'eCom_Catalog/Lists/EcomList.aspx?type=IMPEXP', 0, 0, 0, 1, 1)</sql>
      </Module>
    </database>
  </package>


  <!---->


  <package version="60" date="19-09-2006" internalversion="18.10.1.0">
    <file name="storelocator_info_template.swf" target="Files/Templates/Dealersearch" source="Files/Templates/Dealersearch" />
    <file name="storelocator_hover_template_silver.swf" target="Files/Templates/Dealersearch" source="Files/Templates/Dealersearch" />
    <file name="storelocator_hover_template_default.swf" target="Files/Templates/Dealersearch" source="Files/Templates/Dealersearch" />
    <database file="Dynamic.mdb">
      <DealerSearchCategory>
        <sql conditional="">ALTER TABLE DealerSearchCategory ADD DealerSearchCategoryMouseOverImage VARCHAR(255) NULL</sql>
        <sql conditional="">ALTER TABLE DealerSearchCategory ADD DealerSearchCategoryOnClickImage VARCHAR(255) NULL</sql>
      </DealerSearchCategory>
      <DealerSearchDealer>
        <sql conditional="">ALTER TABLE DealerSearchDealer ADD DealerSearchDealerActionClickTarget VARCHAR(50) NULL</sql>
        <sql conditional="">UPDATE DealerSearchDealer SET DealerSearchDealerActionClickID = 2 WHERE DealerSearchDealerActionClickID = 3</sql>
      </DealerSearchDealer>
    </database>
  </package>
  <package version="59" date="29-08-2006" internalversion="18.10.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <!--<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Employee'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph) VALUES ('Employee', 'HR', 0, 0, 'Employee/Menu.aspx', 1)</sql>-->
        <!--<sql conditional="SELECT ModuleSystemName, (SELECT ModuleSystemName FROM [Module] WHERE ModuleSystemName='Corporate' AND ModuleAccess=blnTrue) As Corp FROM [Module] WHERE (((ModuleSystemName)='Update') AND ((ModuleAccess)=blnTrue)) and (SELECT ModuleSystemName FROM [Module] WHERE ModuleSystemName='Corporate' AND ModuleAccess=blnTrue)='Corporate' ">UPDATE [Module] SET ModuleAccess = 1 WHERE ModuleSystemName = 'EmployeeDatabase'</sql>-->
      </Module>
    </database>
    <database file="Access.mdb">
      <AccessCompetenceCategory>
        <sql conditional="">CREATE TABLE AccessCompetenceCategory (AccessCompetenceCategoryID IDENTITY PRIMARY KEY NOT NULL, AccessCompetenceCategoryName VARCHAR (255) NOT NULL, AccessCompetenceCategoryActive BIT NOT NULL DEFAULT 0)</sql>
      </AccessCompetenceCategory>
      <AccessCustomField>
        <sql conditional="">CREATE TABLE AccessCustomField (AccessCustomFieldID IDENTITY PRIMARY KEY NOT NULL, AccessCustomFieldName VARCHAR (128) NOT NULL, AccessCustomFieldSystemName VARCHAR (128) NOT NULL, AccessCustomFieldTypeID INT NULL DEFAULT 0, AccessCustomFieldContext VARCHAR(255) NULL, AccessCustomFieldDropDown BIT NOT NULL DEFAULT 0)</sql>
      </AccessCustomField>
      <AccessCustomFieldDepartment>
        <sql conditional="">CREATE TABLE AccessCustomFieldDepartment (AccessCustomFieldDepartmentID INT PRIMARY KEY NOT NULL DEFAULT 0)</sql>
      </AccessCustomFieldDepartment>
      <AccessCustomFieldType>
        <sql conditional="">CREATE TABLE AccessCustomFieldType (AccessCustomFieldTypeID IDENTITY PRIMARY KEY NOT NULL, AccessCustomFieldTypeName VARCHAR(50) NOT NULL, AccessCustomFieldTypeDB VARCHAR(50) NULL)</sql>
        <sql conditional="SELECT * FROM AccessCustomFieldType WHERE AccessCustomFieldTypeName='Text (255)'">INSERT INTO AccessCustomFieldType (AccessCustomFieldTypeName, AccessCustomFieldTypeDB) VALUES ('Text (255)', 'VARCHAR(255) NULL')</sql>
        <sql conditional="SELECT * FROM AccessCustomFieldType WHERE AccessCustomFieldTypeName='Text (100)'">INSERT INTO AccessCustomFieldType (AccessCustomFieldTypeName, AccessCustomFieldTypeDB) VALUES ('Text (100)', 'VARCHAR(100) NULL')</sql>
        <sql conditional="SELECT * FROM AccessCustomFieldType WHERE AccessCustomFieldTypeName='Text (50)'">INSERT INTO AccessCustomFieldType (AccessCustomFieldTypeName, AccessCustomFieldTypeDB) VALUES ('Text (50)', 'VARCHAR(50) NULL')</sql>
        <sql conditional="SELECT * FROM AccessCustomFieldType WHERE AccessCustomFieldTypeName='Text (20)'">INSERT INTO AccessCustomFieldType (AccessCustomFieldTypeName, AccessCustomFieldTypeDB) VALUES ('Text (20)', 'VARCHAR(20) NULL')</sql>
        <sql conditional="SELECT * FROM AccessCustomFieldType WHERE AccessCustomFieldTypeName='Text (5)'">INSERT INTO AccessCustomFieldType (AccessCustomFieldTypeName, AccessCustomFieldTypeDB) VALUES ('Text (5)', 'VARCHAR(5) NULL')</sql>
        <sql conditional="SELECT * FROM AccessCustomFieldType WHERE AccessCustomFieldTypeName='Long Text'">INSERT INTO AccessCustomFieldType (AccessCustomFieldTypeName, AccessCustomFieldTypeDB) VALUES ('Long Text', 'MEMO NULL')</sql>
        <sql conditional="SELECT * FROM AccessCustomFieldType WHERE AccessCustomFieldTypeName='Checkbox'">INSERT INTO AccessCustomFieldType (AccessCustomFieldTypeName, AccessCustomFieldTypeDB) VALUES ('Checkbox', 'BIT')</sql>
        <sql conditional="SELECT * FROM AccessCustomFieldType WHERE AccessCustomFieldTypeName='Date'">INSERT INTO AccessCustomFieldType (AccessCustomFieldTypeName, AccessCustomFieldTypeDB) VALUES ('Date', 'DATE NULL')</sql>
        <sql conditional="SELECT * FROM AccessCustomFieldType WHERE AccessCustomFieldTypeName='Date/Time'">INSERT INTO AccessCustomFieldType (AccessCustomFieldTypeName, AccessCustomFieldTypeDB) VALUES ('Date/Time', 'DATE NULL')</sql>
        <sql conditional="SELECT * FROM AccessCustomFieldType WHERE AccessCustomFieldTypeName='Decimal'">INSERT INTO AccessCustomFieldType (AccessCustomFieldTypeName, AccessCustomFieldTypeDB) VALUES ('Decimal', 'DOUBLE NULL')</sql>
        <sql conditional="SELECT * FROM AccessCustomFieldType WHERE AccessCustomFieldTypeName='Link'">INSERT INTO AccessCustomFieldType (AccessCustomFieldTypeName, AccessCustomFieldTypeDB) VALUES ('Link', 'VARCHAR(255) NULL')</sql>
        <sql conditional="SELECT * FROM AccessCustomFieldType WHERE AccessCustomFieldTypeName='File Manager'">INSERT INTO AccessCustomFieldType (AccessCustomFieldTypeName, AccessCustomFieldTypeDB) VALUES ('File Manager', 'VARCHAR(255) NULL')</sql>
        <sql conditional="SELECT * FROM AccessCustomFieldType WHERE AccessCustomFieldTypeName='Integer'">INSERT INTO AccessCustomFieldType (AccessCustomFieldTypeName, AccessCustomFieldTypeDB) VALUES ('Integer', 'LONG NULL')</sql>
      </AccessCustomFieldType>
      <AccessCustomFieldValue>
        <sql conditional="">CREATE TABLE AccessCustomFieldValue (AccessCustomFieldValueID IDENTITY PRIMARY KEY NOT NULL, AccessCustomFieldValueFieldID INT NULL DEFAULT 0, AccessCustomFieldValueKey VARCHAR(50) NOT NULL, AccessCustomFieldValueValue VARCHAR(50) NOT NULL)</sql>
      </AccessCustomFieldValue>
      <!--
      <AccessEmployeeOptions>
        <sql conditional="">CREATE TABLE AccessEmployeeOptions (AccessEmployeeOptionsName VARCHAR(50) PRIMARY KEY NOT NULL, AccessEmployeeOptionsValue VARCHAR(50) NULL)</sql>
        <sql conditional="SELECT * FROM AccessEmployeeOptions WHERE AccessEmployeeOptionsName='EncryptionKey'">INSERT INTO AccessEmployeeOptions (AccessEmployeeOptionsName, AccessEmployeeOptionsValue) VALUES ('EncryptionKey', 'key234')</sql>
        <sql conditional="SELECT * FROM AccessEmployeeOptions WHERE AccessEmployeeOptionsName='RequiredFName'">INSERT INTO AccessEmployeeOptions (AccessEmployeeOptionsName, AccessEmployeeOptionsValue) VALUES ('RequiredFName', '1')</sql>
        <sql conditional="SELECT * FROM AccessEmployeeOptions WHERE AccessEmployeeOptionsName='RequiredInitials'">INSERT INTO AccessEmployeeOptions (AccessEmployeeOptionsName, AccessEmployeeOptionsValue) VALUES ('RequiredInitials', '0')</sql>
        <sql conditional="SELECT * FROM AccessEmployeeOptions WHERE AccessEmployeeOptionsName='RequiredJTitle'">INSERT INTO AccessEmployeeOptions (AccessEmployeeOptionsName, AccessEmployeeOptionsValue) VALUES ('RequiredJTitle', '1')</sql>
        <sql conditional="SELECT * FROM AccessEmployeeOptions WHERE AccessEmployeeOptionsName='RequiredLName'">INSERT INTO AccessEmployeeOptions (AccessEmployeeOptionsName, AccessEmployeeOptionsValue) VALUES ('RequiredLName', '1')</sql>
        <sql conditional="SELECT * FROM AccessEmployeeOptions WHERE AccessEmployeeOptionsName='RequiredPassword'">INSERT INTO AccessEmployeeOptions (AccessEmployeeOptionsName, AccessEmployeeOptionsValue) VALUES ('RequiredPassword', '1')</sql>
        <sql conditional="SELECT * FROM AccessEmployeeOptions WHERE AccessEmployeeOptionsName='RequiredUserName'">INSERT INTO AccessEmployeeOptions (AccessEmployeeOptionsName, AccessEmployeeOptionsValue) VALUES ('RequiredUserName', '1')</sql>
      </AccessEmployeeOptions>
      -->
      <AccessStatus>
        <sql conditional="">CREATE TABLE AccessStatus (AccessStatusID IDENTITY PRIMARY KEY NOT NULL, AccessStatusName VARCHAR(50) NOT NULL, AccessStatusOrder SMALLINT NOT NULL DEFAULT 0, AccessStatusDefault BIT NOT NULL DEFAULT 0)</sql>
        <sql conditional="SELECT * FROM AccessStatus WHERE AccessStatusName='Available'">INSERT INTO AccessStatus (AccessStatusName, AccessStatusOrder, AccessStatusDefault) values ('Available', 0, 1)</sql>
      </AccessStatus>
      <AccessCompetence>
        <sql conditional="">CREATE TABLE AccessCompetence (AccessCompetenceID IDENTITY PRIMARY KEY NOT NULL, AccessCompetenceName VARCHAR(255) NOT NULL, AccessCompetenceCategoryID INT NOT NULL DEFAULT 0, AccessCompetenceActive BIT NOT NULL DEFAULT 0)</sql>
      </AccessCompetence>
      <!--
      <AccessEmployeeCompetence>
        <sql conditional="">CREATE TABLE AccessEmployeeCompetence (AccessECEmployeeID INT NOT NULL DEFAULT 0, AccessECCompetenceID INT NOT NULL DEFAULT 0, AccessECCompetenceCategoryID INT NULL DEFAULT 0)</sql>
      </AccessEmployeeCompetence>
      <AccessEmployeeDepartment>
        <sql conditional="">CREATE TABLE AccessEmployeeDepartment (AccessEDEmployeeID INT NOT NULL DEFAULT 0, AccessEDDepartmentID INT NOT NULL DEFAULT 0, AccessEDIsManager BIT NOT NULL DEFAULT 0)</sql>
      </AccessEmployeeDepartment>
      -->
      <AccessCompetence>
        <sql conditional="">ALTER TABLE AccessCompetence ADD CONSTRAINT AccessCompetence_FK00 FOREIGN KEY (AccessCompetenceCategoryID) REFERENCES AccessCompetenceCategory (AccessCompetenceCategoryID)</sql>
      </AccessCompetence>
      <!--
      <AccessEmployeeCompetence>
        <sql conditional="">ALTER TABLE AccessEmployeeCompetence ADD CONSTRAINT AccessEmployeeCompetence_FK00 FOREIGN KEY (AccessECCompetenceID) REFERENCES AccessCompetence (AccessCompetenceID), CONSTRAINT AccessEmployeeCompetence_FK01 FOREIGN KEY (AccessECEmployeeID) REFERENCES AccessUser (AccessUserID)</sql>
      </AccessEmployeeCompetence>
      <AccessEmployeeDepartment>
        <sql conditional="">ALTER TABLE AccessEmployeeDepartment ADD CONSTRAINT AccessEmployeeDepartment_FK00 FOREIGN KEY (AccessEDDepartmentID) REFERENCES AccessCustomFieldDepartment (AccessCustomFieldDepartmentID), CONSTRAINT AccessEmployeeDepartment_FK01 FOREIGN KEY (AccessEDEmployeeID) REFERENCES AccessUser (AccessUserID)</sql>
      </AccessEmployeeDepartment>
      -->
      <AccessUser>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserLastName VARCHAR(255) NULL</sql>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserMiddleName VARCHAR(255) NULL</sql>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserActive BIT NOT NULL DEFAULT 1</sql>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserImage VARCHAR(255) NULL</sql>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserBusiness VARCHAR(255) NULL</sql>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserInitials VARCHAR(255) NULL</sql>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserComment NTEXT NULL</sql>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserLevel INT NULL DEFAULT 0</sql>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserInheritAddress BIT NOT NULL DEFAULT 1</sql>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserWeb VARCHAR(255) NULL</sql>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserSort INT NULL DEFAULT 0</sql>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserStatus INT NULL DEFAULT 0</sql>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserStatusBegin DATETIME NULL</sql>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserStatusEnd DATETIME NULL</sql>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserStatusComment VARCHAR(255) NULL</sql>
      </AccessUser>
      <AccessType>
        <sql conditional="">INSERT INTO AccessType(AccessTypeID, AccessTypeDesc) values (30, 'Employee')</sql>
        <sql conditional="">INSERT INTO AccessType(AccessTypeID, AccessTypeDesc) values (31, 'Department')</sql>
      </AccessType>
    </database>
    <!--<folder source="Files/Templates/Employee" target="Files/Templates/" />-->
    <!--folder source="Files/Templates/Filemanager" target="Files/Templates/" /-->
  </package>

  <package version="58" date="16-03-2006" internalversion="18.10.1.0">
    <file name="Element.html"  target="Files/Templates/Dealersearch" source="Files/Templates/Dealersearch" />
    <file name="List.html"  target="Files/Templates/Dealersearch" source="Files/Templates/Dealersearch" />
    <file name="ListElement.html"  target="Files/Templates/Dealersearch" source="Files/Templates/Dealersearch" />
    <file name="Search.html"  target="Files/Templates/Dealersearch" source="Files/Templates/Dealersearch" />
  </package>
  <package version="57" date="01-03-2006" internalversion="18.10.1.0">
    <file name="styles.xml" overwrite="false" target="Files/System" source="Files/System" />
    <folder source="Files/Templates/Editor" target="Files/Templates/" />
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleDatabase = 'Stylesheet.mdb', ModuleTable = 'StylesheetStylesheet', ModuleFieldID = 'StylesheetStylesheetID', ModuleFieldName = 'StylesheetStylesheetNodename', ModuleWhere = 'WHERE StylesheetStylesheetParentID = 0 ' WHERE ModuleSystemName = 'Stylesheet'</sql>
        <!--<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'Registration'</sql>
        <sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'Searchv2'</sql>
        <sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'Streaming'</sql>-->
        <sql conditional="SELECT ModuleSystemName, (SELECT ModuleSystemName FROM [Module] WHERE ModuleSystemName='Business' AND ModuleAccess=blnTrue) As Corp FROM [Module] WHERE (((ModuleSystemName)='Update') AND ((ModuleAccess)=blnTrue)) and (SELECT ModuleSystemName FROM [Module] WHERE ModuleSystemName='Business' AND ModuleAccess=blnTrue)='Business' ">UPDATE [Module] SET ModuleAccess = 1 WHERE ModuleSystemName = 'Publish'</sql>
        <sql conditional="SELECT ModuleSystemName, (SELECT ModuleSystemName FROM [Module] WHERE ModuleSystemName='Corporate' AND ModuleAccess=blnTrue) As Corp FROM [Module] WHERE (((ModuleSystemName)='Update') AND ((ModuleAccess)=blnTrue)) and (SELECT ModuleSystemName FROM [Module] WHERE ModuleSystemName='Corporate' AND ModuleAccess=blnTrue)='Corporate' ">UPDATE [Module] SET ModuleAccess = 1 WHERE ModuleSystemName = 'Publish'</sql>
        <sql conditional="SELECT * FROM [Module] WHERE ModuleSystemName = 'Update' AND ModuleAccess = blnTrue">UPDATE [Module] SET ModuleAccess = 1 WHERE ModuleSystemName = 'FilearchiveExtended'</sql>
      </Module>
      <GlobalElement>
        <sql conditional="">ALTER TABLE Paragraph ADD ParagraphGlobalID INT NULL</sql>
        <sql conditional="">CREATE INDEX ParagraphGlobalID ON Paragraph (ParagraphGlobalID)</sql>
      </GlobalElement>
    </database>
  </package>
  <package version="56" date="01-03-2006" internalversion="18.10.1.0">
    <database file="Dynamic.mdb">
      <TemplateMenu>
        <sql conditional="">UPDATE TemplateMenu SET TemplateMenuThread = 1 WHERE TemplateMenuType = 2</sql>
      </TemplateMenu>
      <CalenderEvent>
        <sql conditional="">ALTER TABLE  CalenderEvent ADD CalenderEventTempDescription NTEXT NULL</sql>
        <sql conditional="">UPDATE CalenderEvent SET CalenderEventTempDescription = CalenderEventDescription</sql>
        <sql conditional="">ALTER TABLE CalenderEvent DROP CalenderEventDescription</sql>
        <sql conditional="">ALTER TABLE  CalenderEvent ADD CalenderEventDescription  NTEXT NULL</sql>
        <sql conditional="">UPDATE CalenderEvent SET CalenderEventDescription = CalenderEventTempDescription</sql>
        <sql conditional="">ALTER TABLE CalenderEvent DROP CalenderEventTempDescription</sql>
      </CalenderEvent>
    </database>
  </package>
  <package version="55" date="01-03-2006" internalversion="18.10.1.0">
    <file name="ShopOrder.html"  target="Files/Templates/Dealersearch" source="Files/Templates/Dealersearch" />
    <folder source="Files/Templates/Calendar" target="Files/Templates/" />
    <folder source="Files/Templates/Dealersearch" target="Files/Templates/" />
    <database file="Dynamic.mdb">
      <TrashBin>
        <sql conditional="">CREATE TABLE TrashBin (TrashBinTrashId IDENTITY PRIMARY KEY NOT NULL, TrashBinUnitOfWork INT NULL, TrashBinType INT NULL, TrashBinId INT NULL, TrashBinDescription VARCHAR (255) NULL, TrashBinData VARCHAR (255) NULL, TrashBinUserid VARCHAR (255) NULL, TrashBinTrashDate DATETIME, TrashBinXMLData MEMO NULL)</sql>
      </TrashBin>
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'News_cpl.aspx' WHERE ModuleSystemName = 'News'</sql>
        <sql conditional="SELECT * FROM [Module] WHERE ModuleSystemName = 'DealerSearch'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph) VALUES ('DealerSearch', 'Forhandlersogning', 0, 0, 'DealerSearch/CategoryList.aspx', 1)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE ModuleSystemName = 'Calendar'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph) VALUES ('Calendar', 'Akvtivitetskalender V2', 0, 0, 'Calendar/Calendar_List.aspx', 1)</sql>
        <sql conditional="SELECT * FROM [Module] WHERE ModuleSystemName = 'Calender' AND ModuleAccess = blnFalse">UPDATE [Module] SET ModuleAccess = 1 WHERE ModuleSystemName = 'Calendar'</sql>
        <sql conditional="SELECT * FROM [Module] WHERE ModuleSystemName = 'Update' AND ModuleAccess = blnTrue">UPDATE [Module] SET ModuleAccess = 0 WHERE ModuleSystemName = 'Calendar'</sql>
      </Module>
      <DealerSearch>
        <sql conditional="">CREATE TABLE DealerSearchCategory (DealerSearchCategoryID IDENTITY PRIMARY KEY NOT NULL, DealerSearchCategoryName VARCHAR (255) NULL, DealerSearchCategoryImage VARCHAR (255) NULL, DealerSearchCategoryHeight VARCHAR (255) NULL, DealerSearchCategoryWidth VARCHAR (255) NULL)</sql>
        <sql conditional="">CREATE TABLE DealerSearchDealerType (DealerSearchDealerTypeID IDENTITY PRIMARY KEY NOT NULL, DealerSearchDealerTypeName VARCHAR (255) NULL, DealerSearchDealerTypeDot VARCHAR (255) NULL, DealerSearchDealerTypeDotRollover VARCHAR (255) NULL, DealerSearchDealerTypeActionRollover VARCHAR (255) NULL, DealerSearchDealerTypeActionRolloverText VARCHAR (255) NULL, DealerSearchDealerTypeActionClick VARCHAR (255) NULL, DealerSearchDealerTypeActionClickFile VARCHAR (255) NULL)</sql>
        <sql conditional="">CREATE TABLE DealerSearchUserField (DealerSearchUserFieldID IDENTITY PRIMARY KEY NOT NULL, DealerSearchUserFieldSort INT NULL, DealerSearchUserFieldDisplayName VARCHAR (255) NULL, DealerSearchUserFieldSystemName VARCHAR (255) NULL)</sql>
        <sql conditional="">CREATE TABLE DealerSearchView (DealerSearchViewID IDENTITY PRIMARY KEY NOT NULL, DealerSearchViewName VARCHAR (255) NULL, DealerSearchViewSort NTEXT NULL)</sql>
        <sql conditional="">CREATE TABLE DealerSearchDealer (DealerSearchDealerID IDENTITY PRIMARY KEY NOT NULL, DealerSearchDealerCategoryID INT NULL, DealerSearchDealerTypeID INT NULL, DealerSearchDealerActionRolloverID INT NULL, DealerSearchDealerActionRolloverText VARCHAR (255) NULL, DealerSearchDealerActionClickID INT NULL, DealerSearchDealerActionClickFile VARCHAR (255) NULL, DealerSearchDealerName VARCHAR (255) NULL, DealerSearchDealerAdress VARCHAR (255) NULL, DealerSearchDealerAdress2 VARCHAR (255) NULL, DealerSearchDealerZip VARCHAR (255) NULL, DealerSearchDealerCity VARCHAR (255) NULL, DealerSearchDealerCountry VARCHAR (255) NULL, DealerSearchDealerPhone1 VARCHAR (255) NULL, DealerSearchDealerPhone2 VARCHAR (255) NULL, DealerSearchDealerFax1 VARCHAR (255) NULL, DealerSearchDealerFax2 VARCHAR (255) NULL, DealerSearchDealerEmail VARCHAR (255) NULL, DealerSearchDealerWebsite VARCHAR (255) NULL, DealerSearchDealerCoordinateX VARCHAR (255) NULL, DealerSearchDealerCoordinateY VARCHAR (255) NULL, DealerSearchDealerActive BIT DEFAULT 0, DealerSearchDealerView INT NULL)</sql>
      </DealerSearch>
      <Calender>
        <sql conditional="">ALTER TABLE  CalenderEvent ADD CalenderEventLocationID INT NULL DEFAULT 0</sql>
        <sql conditional="">ALTER TABLE  CalenderCategory ADD CalenderCategoryImage VARCHAR (255)</sql>
        <sql conditional="">ALTER TABLE  CalenderCategory ADD CalenderCategoryDescription NTEXT NULL</sql>
        <sql conditional="">CREATE TABLE CalenderLocation (CalenderLocationID IDENTITY PRIMARY KEY NOT NULL, CalenderLocationImage VARCHAR (255) NULL, CalenderLocation VARCHAR (255) NULL, CalenderLocationDescription NTEXT NULL)</sql>
        <sql conditional="">ALTER TABLE  CalenderEvent ADD CalenderEventTempPlace VARCHAR (255)</sql>
        <sql conditional="">UPDATE CalenderEvent SET CalenderEventTempPlace = CalenderEventPlace</sql>
        <sql conditional="">ALTER TABLE CalenderEvent DROP CalenderEventPlace</sql>
        <sql conditional="">ALTER TABLE  CalenderEvent ADD CalenderEventPlace VARCHAR (255)</sql>
        <sql conditional="">UPDATE CalenderEvent SET CalenderEventPlace = CalenderEventTempPlace</sql>
        <sql conditional="">ALTER TABLE CalenderEvent DROP CalenderEventTempPlace</sql>
      </Calender>
      <TemplateMenu>
        <sql conditional="">ALTER TABLE TemplateMenu ADD TemplateMenuXSLTTemplate VARCHAR (255) NULL</sql>
      </TemplateMenu>
      <TemplateMenuType>
        <sql conditional="">INSERT INTO TemplateMenuType (TemplateMenuTypeName) VALUES ('XML')</sql>
      </TemplateMenuType>
    </database>
    <!--<folder source="Files/Templates/Navigation" target="Files/Templates/" />-->
  </package>
  <package version="54" date="25-11-2005" internalversion="18.9.1.0">
    <database file="Dynamic.mdb">
      <News>
        <sql conditional="">ALTER TABLE News ADD NewsImageText VARCHAR (255) NULL</sql>
      </News>
    </database>
  </package>
  <package version="53" date="16-11-2005" internalversion="18.9.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleHiddenMode = 0 WHERE ModuleSystemName = 'VersionControl' OR ModuleSystemName = 'Workflow'</sql>
        <sql conditional="">UPDATE [Module] SET ModuleControlPanel = '' WHERE ModuleSystemName = 'VersionControl'</sql>
      </Module>
    </database>
  </package>
  <package version="52" date="28-09-2005" internalversion="18.9.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'Statisticsv2_Cpl.aspx' WHERE ModuleSystemName = 'Statisticsv2'</sql>
        <!--<sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'Extranet_cpl.aspx' WHERE ModuleSystemName = 'Extranet'</sql>-->
      </Module>
    </database>
    <database file="Stylesheet.mdb">
      <LegendLayout>
        <sql conditional="">ALTER TABLE LegendLayout ADD LegendLayoutIncludeAreaFrontpage INT NULL DEFAULT 0</sql>
      </LegendLayout>
    </database>
  </package>
  <package version="51" date="13-09-2005" internalversion="18.9.1.0">
    <database file="Dynamic.mdb">
      <VersionData>
        <sql conditional="">CREATE TABLE VersionData (VersionDataID IDENTITY PRIMARY KEY NOT NULL, VersionDataType VARCHAR (25) NULL, VersionDataTypeID INT NULL DEFAULT 0, VersionDataCreated DATETIME, VersionDataEdit DATETIME, VersionDataPublishedTime DATETIME, VersionDataPublished BIT DEFAULT 0, VersionDataXML NTEXT)</sql>
      </VersionData>
      <!--
      <ShopProductFieldValues>
        <sql conditional="">CREATE TABLE ShopProductFieldValues (ShopProductFieldValuesID IDENTITY PRIMARY KEY NOT NULL, ShopProductFieldValuesFieldID INT NULL DEFAULT 0, ShopProductFieldValuesKey VARCHAR (255) NULL, ShopProductFieldValuesValue VARCHAR (255) NULL)</sql>
      </ShopProductFieldValues>
      <ShopProductField>
        <sql conditional="">ALTER TABLE ShopProductField ADD ShopProductFieldSelectvalues BIT DEFAULT 0</sql>
      </ShopProductField>
      <ShopProductField>
        <sql conditional="">UPDATE ShopProductField SET ShopProductFieldSelectvalues = 0</sql>
      </ShopProductField>
      -->
    </database>
  </package>
  <package version="50" date="31-08-2005" internalversion="18.9.1.0">
    <!--
    <database file="DWShop.mdb">
      <ShopProductField>
        <sql conditional="">ALTER TABLE ShopProductField ADD ShopProductFieldSelectvalues BIT DEFAULT 0</sql>
      </ShopProductField>
      <ShopProductFieldValues>
        <sql conditional="">CREATE TABLE ShopProductFieldValues (ShopProductFieldValuesID IDENTITY PRIMARY KEY NOT NULL, ShopProductFieldValuesFieldID INT NULL DEFAULT 0, ShopProductFieldValuesKey VARCHAR (255) NULL, ShopProductFieldValuesValue VARCHAR (255) NULL)</sql>
      </ShopProductFieldValues>
    </database>
    -->
  </package>
  <package version="49" date="16-08-2005" internalversion="18.9.1.0">
    <database file="Dynamic.mdb">
      <VersionData>
        <sql conditional="">CREATE TABLE VersionData (VersionDataID INT IDENTITY PRIMARY KEY NOT NULL, VersionDataType VARCHAR (25) NULL, VersionDataTypeID INT NULL DEFAULT 0, VersionDataCreated DATETIME, VersionDataEdit DATETIME, VersionDataPublishedTime DATETIME, VersionDataPublished BIT DEFAULT 0, VersionDataXML NTEXT)</sql>
      </VersionData>
    </database>
  </package>
  <package version="48" date="09-08-2005" internalversion="18.9.1.0">
    <!--<file name="EPAYGateway.html" overwrite="false" target="Files/Templates/Shop" source="Files/Templates/Shop" />-->
  </package>
  <package version="47" date="09-08-2005" internalversion="18.9.1.0">
    <!--<file name="EPAYGateway.html" overwrite="false" target="Files/Templates/Shop" source="Files/Templates/Shop" />-->
  </package>
  <package version="46" date="08-08-2005" internalversion="18.9.1.0">
    <database file="Dynamic.mdb">
      <Page>
        <sql conditional="">ALTER TABLE Page ADD PageApprovalStep INT NULL</sql>
      </Page>
      <Area>
        <sql conditional="">ALTER TABLE Area ADD AreaApprovalType INT NULL</sql>
      </Area>
      <VersionData>
        <sql conditional="">CREATE TABLE VersionData (VersionDataID INT IDENTITY PRIMARY KEY NOT NULL, VersionDataType VARCHAR (25) NULL, VersionDataTypeID INT NULL DEFAULT 0, VersionDataCreated DATETIME, VersionDataEdit DATETIME, VersionDataPublishedTime DATETIME, VersionDataPublished BIT DEFAULT 0, VersionDataXML NTEXT)</sql>
      </VersionData>
    </database>
    <database file="Access.mdb">
      <Page>
        <sql conditional="">ALTER TABLE AccessWorkflow ADD AccessWorkflowNotifyTemplate VARCHAR (255) NULL, AccessWorkflowRequiredTemplate VARCHAR (255) NULL</sql>
      </Page>
    </database>
    <file name="NotifyOnly.html" overwrite="false" target="Files/Templates/Workflow" source="Files/Templates/Workflow" />
    <file name="Required.html" overwrite="false" target="Files/Templates/Workflow" source="Files/Templates/Workflow" />
  </package>
  <package version="45" date="30-06-2005" internalversion="18.9.1.0">
    <database file="Dynamic.mdb">
      <Form>
        <sql conditional="">ALTER TABLE Form ADD FormAttenoDependencyFieldID INT NULL, FormAttenoEmailFieldID INT NULL, FormAttenoSettings VARCHAR (255) NULL</sql>
      </Form>
      <FormField>
        <sql conditional="">ALTER TABLE FormField ADD FormFieldAttenoFieldName VARCHAR (255) NULL</sql>
      </FormField>
    </database>
  </package>
  <package version="44" date="07-06-2005" internalversion="18.9.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <!--<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'ContextSubscription'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleControlPanel) VALUES ('ContextSubscription', 'Indholdsabonnement', 0, 0, 'NewsletterSubscription/Subscription_Mail_Edit.aspx', 0, 0, 'ContextSubscription_cpl.aspx')</sql>-->
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'SearchFriendlyUrls'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleControlPanel) VALUES ('SearchFriendlyUrls', 'Brugerdefinerede URLer', 1, 1, 0, 0, 'SearchfriendlyUrls_cpl.aspx')</sql>
      </Module>
    </database>
    <Module>
      <sql conditional="">UPDATE [Module] SET ModuleName = 'Link Management' WHERE ModuleName = 'Linkvalidator'</sql>
    </Module>
    <file name="MailDefault.html" overwrite="false" target="Files/Templates/NewsletterSubscription" source="Files/Templates/NewsletterSubscription" />
    <file name="NewsElementDefault.html" overwrite="false" target="Files/Templates/NewsletterSubscription" source="Files/Templates/NewsletterSubscription" />
    <file name="PageElementDefault.html" overwrite="false" target="Files/Templates/NewsletterSubscription" source="Files/Templates/NewsletterSubscription" />
    <file name="SendToFriendMaster.html" overwrite="false" target="Files/Templates/PageFeatures" source="Files/Templates/PageFeatures" />
    <file name="SendToFriendForm.html" overwrite="false" target="Files/Templates/PageFeatures" source="Files/Templates/PageFeatures" />
  </package>
  <package version="43" date="31-05-2005" internalversion="18.9.1.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'LinkSearch'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode) VALUES ('LinkSearch', 'Link Management', 0, 0, 'LinkSearch/Default.aspx', 0, 0)</sql>
      </Module>
    </database>
  </package>
  <package version="42" date="20-05-2005" internalversion="18.8.2.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'DatabaseReplacer'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleScript) VALUES ('DatabaseReplacer', 'Søg og erstat', 0, 0, 0, 0, 'DatabaseReplacer/DatabaseReplacer.aspx')</sql>
      </Module>
      <Template>
        <sql conditional="">ALTER TABLE Template ADD TemplateAutoResize BIT DEFAULT 0</sql>
      </Template>
    </database>
  </package>
  <package version="40" date="17-05-2005" internalversion="18.8.2.0">
    <database file="Dynamic.mdb">
      <Module>
        <!--<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'ImageGallery'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode) VALUES ('ImageGallery', 'Billedgalleri', 0, 0, 1, 0)</sql>-->
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Searchv1'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode) VALUES ('Searchv1', 'Søg, vægtet', 0, 0, 1, 0)</sql>
        <!--<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Registration'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode) VALUES ('Registration', 'Registrering', 0, 0, 'SearchV2/Registration_module_List.aspx', 0, 0)</sql>-->
      </Module>
    </database>
  </package>
  <package version="39" date="20-04-2005" internalversion="18.8.2.0">
    <database file="Dynamic.mdb">
      <Area>
        <sql conditional="">ALTER TABLE Area ADD AreaCulture VARCHAR(50) null</sql>
      </Area>
    </database>
  </package>
  <package version="38" date="06-04-2005" internalversion="18.8.2.0">
    <database file="Dynamic.mdb">
      <FAQItem>
        <sql conditional="">ALTER TABLE FAQItem DROP FAQItemUserCreate, FAQItemUserEdit</sql>
        <sql conditional="">ALTER TABLE FAQItem ADD FAQItemUserCreate VARCHAR (255) NULL, FAQItemUserEdit VARCHAR (255) NULL</sql>
      </FAQItem>
    </database>
  </package>
  <package version="37" date="22-03-2005" internalversion="18.8.2.0">
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'Audit_cpl.aspx' WHERE ModuleSystemName = 'Audit'</sql>
        <sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'Paygate_cpl.aspx' WHERE ModuleSystemName = 'Paygate'</sql>
        <!--<sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'Users_cpl.aspx' WHERE ModuleSystemName = 'Users'</sql>-->
        <!--<sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'Dynamicdoc_cpl.aspx' WHERE ModuleSystemName = 'Dynamicdoc'</sql>-->
        <sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'Filemanager_cpl.aspx' WHERE ModuleSystemName = 'Filearchive'</sql>
        <!--<sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'Cart_cpl.aspx' WHERE ModuleSystemName = 'CartV2'</sql>-->
        <sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'Language_cpl.aspx' WHERE ModuleSystemName = 'LanguagePack'</sql>
        <sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'Stylesheet_cpl.aspx' WHERE ModuleSystemName = 'Stylesheet'</sql>
        <sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'NewsletterExtended_cpl.aspx' WHERE ModuleSystemName = 'NewsletterExtended'</sql>
        <!--<sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'Search_cpl.aspx' WHERE ModuleSystemName = 'SearchExtended'</sql>-->
        <!--<sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'Shop_cpl.aspx' WHERE ModuleSystemName = 'Shop'</sql>-->
        <sql conditional="">UPDATE [Module] SET ModuleControlPanel = 'VersionControl_cpl.aspx' WHERE ModuleSystemName = 'VersionControl'</sql>
        <sql conditional="">UPDATE [Module] SET ModuleControlPanel = '' WHERE ModuleSystemName = 'Statistics'</sql>
        <!--<sql conditional="">UPDATE [Module] SET ModuleControlPanel = '' WHERE ModuleSystemName = 'Cart'</sql>-->
      </Module>
    </database>
  </package>
  <package version="36" date="04-02-2005" internalversion="18.8.2.0">
    <database file="Stylesheet.mdb">
      <SendFriendLayout>
        <sql conditional="">ALTER TABLE SendFriendLayout ADD SendFriendLayoutFormTemplate VARCHAR (255) NULL</sql>
      </SendFriendLayout>
      <SendFriendLayout>
        <sql conditional="">ALTER TABLE SendFriendLayout ADD SendFriendMailTemplate VARCHAR (255) NULL, SendFriendLayoutMasterTemplate VARCHAR (255) NULL</sql>
      </SendFriendLayout>
    </database>
    <file name="SendToFriendForm.html" overwrite="false" target="Files/Templates/PageFeatures" source="Files/Templates/PageFeatures" />
    <file name="SendToFriendMail_dk.html" overwrite="false" target="Files/Templates/PageFeatures" source="Files/Templates/PageFeatures" />
    <file name="SendToFriendMail_uk.html" overwrite="false" target="Files/Templates/PageFeatures" source="Files/Templates/PageFeatures" />
    <file name="SendToFriendMaster.html" overwrite="false" target="Files/Templates/PageFeatures" source="Files/Templates/PageFeatures" />
  </package>
  <package version="35" date="04-01-2005" internalversion="18.8.2.0">
    <!--
    <database file="DWShop.mdb">
      <ShopOrder>
        <sql conditional="">ALTER TABLE ShopOrder ADD ShopOrderDeleted BIT,  ShopOrderStatusModified DATETIME</sql>
      </ShopOrder>
      <ShopProductUserPrice>
        <sql conditional="">CREATE TABLE ShopProductUserPrice (ShopProductUserPriceID IDENTITY PRIMARY KEY NOT NULL, ShopProductUserPriceUserName VARCHAR (255) NULL , ShopProductUserPriceIDProductNumber VARCHAR (255) NULL , ShopProductUserPrice INT NULL DEFAULT 0)</sql>
      </ShopProductUserPrice>
    </database>
    -->
    <database file="Dynamic.mdb">
      <CalenderCategory>
        <sql conditional="">ALTER TABLE CalenderCategory ADD CalenderCategoryApprovalType INT</sql>
      </CalenderCategory>
      <CalenderEvent>
        <sql conditional="">ALTER TABLE CalenderEvent ADD CalenderEventApprovalState INT, CalenderEventApprovalType INT, CalenderEventVersionTimeStamp DATETIME</sql>
      </CalenderEvent>
      <CalenderEventVersion>
        <sql conditional="">CREATE TABLE CalenderEventVersion (VersionAutoID IDENTITY PRIMARY KEY NOT NULL, CalenderEventID INT NULL DEFAULT 0, CalenderEventCategoryID INT NULL DEFAULT 0, CalenderEventDate DATETIME NULL , CalenderEventDateTo DATETIME NULL , CalenderEventTitle NVARCHAR (255) NULL , CalenderEventPlace NVARCHAR (255) NULL , CalenderEventDescription MEMO NULL , CalenderEventImage NVARCHAR (50) NULL , CalenderEventCreated DATETIME NULL , CalenderEventModified DATETIME NULL , CalenderEventValidFrom DATETIME NULL , CalenderEventValidTo DATETIME NULL , CalenderEventLayoutValue NVARCHAR (50) NULL  DEFAULT 'T11-B11', CalenderEventImageSpan NVARCHAR (50) NULL , CalenderEventTextSpan NVARCHAR (50) NULL , CalenderEventImageAlign NVARCHAR (50) NULL , CalenderEventInclude BIT NOT NULL DEFAULT 0, CalenderEventTemplateID INT NULL DEFAULT 0, CalenderEventWorkflowID INT NULL DEFAULT 0, CalenderEventWorkflowState INT NULL DEFAULT 0, CalenderEventVersionParentID INT NULL DEFAULT 0, CalenderEventVersionNumber INT NULL DEFAULT 0, CalenderEventVersionComments MEMO NULL, CalenderEventBookPage NVARCHAR (255) NULL, CalenderEventUserCreate INT NULL, CalenderEventUserEdit INT NULL, CalenderEventApprovalType INT NULL, CalenderEventApprovalState INT NULL, CalenderEventVersionTimeStamp DATETIME NULL, VersionNumber INT NULL  DEFAULT 0, VersionCreated DATETIME NULL, VersionEdited DATETIME NULL, VersionUserCreated INT NULL DEFAULT 0, VersionUserEdited INT NULL DEFAULT 0, VersionPublished BIT NOT NULL DEFAULT 0)</sql>
      </CalenderEventVersion>
      <FAQCategory>
        <sql conditional="">ALTER TABLE FAQCategory ADD FAQCategoryApprovalType INT</sql>
      </FAQCategory>
      <FAQItem>
        <sql conditional="">ALTER TABLE FAQItem ADD FAQItemApprovalState INT, FAQItemApprovalType INT, FAQItemCreatedDate DATETIME, FAQItemUpdatedDate DATETIME, FAQItemUserCreate VARCHAR (255) NULL, FAQItemUserEdit VARCHAR (255) NULL, FAQItemVersionTimeStamp DATETIME</sql>
      </FAQItem>
      <FAQItemVersion>
        <sql conditional="">CREATE TABLE FAQItemVersion (VersionAutoID  IDENTITY PRIMARY KEY NOT NULL, FAQItemID INT NOT NULL , FAQItemCategoryID INT NULL , FAQItemSort INT NULL , FAQItemActive BIT NOT NULL , FAQItemDate DATETIME NULL , FAQItemDateEdit DATETIME NULL , FAQItemQSenderName NVARCHAR (255) NULL , FAQItemQSenderMail NVARCHAR (255) NULL , FAQItemQHeader NVARCHAR (255) NULL , FAQItemQText MEMO NULL , FAQItemASenderName NVARCHAR (255) NULL , FAQItemASenderMail NVARCHAR (255) NULL , FAQItemAHeader NVARCHAR (255) NULL , FAQItemAText MEMO NULL , FAQItemWorkflowID INT NULL , FAQItemWorkflowState INT NULL , FAQItemVersionParentID INT NULL , FAQItemVersionNumber INT NULL , FAQItemVersionComment MEMO NULL , FAQItemValidFrom DATETIME NULL , FAQItemValidTo DATETIME NULL , FAQItemCreatedDate DATETIME NULL , FAQItemUpdatedDate DATETIME NULL , FAQItemUserCreate INT NULL , FAQItemUserEdit INT NULL , FAQItemApprovalType INT NULL , FAQItemApprovalState INT NULL , FAQItemVersionTimeStamp DATETIME NULL , VersionNumber INT NULL DEFAULT 0, VersionCreated DATETIME NULL , VersionEdited DATETIME NULL , VersionUserCreated INT NULL DEFAULT 0, VersionUserEdited INT NULL DEFAULT 0, VersionPublished BIT NULL DEFAULT 0)</sql>
      </FAQItemVersion>
      <News>
        <sql conditional="">ALTER TABLE News ADD NewsApprovalState INT, NewsApprovalType INT, NewsVersionTimeStamp DATETIME</sql>
      </News>
      <NewsCategory>
        <sql conditional="">ALTER TABLE NewsCategory ADD NewsCategoryApprovalType INT</sql>
      </NewsCategory>
      <!--
      <NewsVersion>
        <sql conditional="">CREATE TABLE NewsVersion (VersionAutoID  IDENTITY PRIMARY KEY NOT NULL, NewsID INT NULL DEFAULT 0, NewsCategoryID INT NULL DEFAULT 0, NewsActiveFrom datetime NULL , NewsActiveTo datetime NULL , NewsActive BIT NOT NULL DEFAULT 1, NewsArchive BIT NOT NULL DEFAULT 0, NewsHeading NVARCHAR (255) NULL , NewsManchet MEMO NULL , NewsAuthor NVARCHAR (255) NULL , NewsText MEMO NULL , NewsImage NVARCHAR (255) NULL , NewsInitials NVARCHAR (255) NULL , NewsCreatedDate datetime NULL , NewsUpdatedDate datetime NULL , NewsDate datetime NULL , NewsTemplateID INT NULL DEFAULT 0, NewsSmallImage NVARCHAR (255) NULL , NewsLink NVARCHAR (255) NULL , NewsLinkPopup BIT NOT NULL DEFAULT 0, NewsUserCreate INT NULL , NewsUserEdit INT NULL , NewsApprovalType INT NULL , NewsApprovalState INT NULL , NewsVersionTimeStamp datetime NULL , VersionNumber INT NULL DEFAULT 0, VersionCreated datetime NULL , VersionEdited datetime NULL , VersionUserCreated INT NULL DEFAULT 0, VersionUserEdited INT NULL DEFAULT 0,VersionPublished BIT NOT NULL DEFAULT 0)</sql>
      </NewsVersion>
      -->
      <Page>
        <sql conditional="">ALTER TABLE Page ADD PageInheritID INT NULL DEFAULT 0, PageInheritUpdateDate DATETIME NULL , PageInheritStatus INT NULL DEFAULT 0, PageApprovalType INT NULL DEFAULT 0, PageApprovalState INT NULL DEFAULT 0, PageVersionTimeStamp DATETIME NULL</sql>
      </Page>
      <Paragraph>
        <sql conditional="">ALTER TABLE Paragraph ADD ParagraphInheritID INT NULL DEFAULT 0, ParagraphInheritUpdateDate DATETIME NULL , ParagraphInheritStatus INT NULL DEFAULT 0, ParagraphApprovalType INT NULL DEFAULT 0, ParagraphApprovalState INT NULL DEFAULT 0, ParagraphVersionTimeStamp DATETIME NULL</sql>
      </Paragraph>
      <ParagraphVersion>
        <sql conditional="">CREATE TABLE ParagraphVersion (VersionAutoID  IDENTITY PRIMARY KEY NOT NULL, ParagraphID INT NULL DEFAULT 0, ParagraphPageID INT NULL DEFAULT 0, ParagraphModuleSystemName NVARCHAR (50) NULL , ParagraphIndex INT NOT NULL DEFAULT 0, ParagraphSort INT NULL DEFAULT 0, ParagraphHeader NVARCHAR (255) NULL , ParagraphShowHeader BIT NOT NULL DEFAULT 0, ParagraphShowParagraph BIT NOT NULL DEFAULT 0, ParagraphSubHeader MEMO NULL , ParagraphText MEMO NULL , ParagraphIgnoreBreaks BIT NOT NULL DEFAULT 0, ParagraphImage NVARCHAR (255) NULL , ParagraphImageURL NVARCHAR (255) NULL , ParagraphImageTarget NVARCHAR (250) NULL , ParagraphImageNewWindow BIT NOT NULL DEFAULT 0, ParagraphImageMouseOver NVARCHAR (255) , ParagraphImageCaption NVARCHAR (255) NULL , ParagraphImageResize BIT NOT NULL DEFAULT 0, ParagraphImageVAlign NVARCHAR (255) DEFAULT 'top', ParagraphImageVSpace INT NULL DEFAULT 0, ParagraphImageHAlign NVARCHAR (50) DEFAULT 'Left', ParagraphImageHSpace INT NULL DEFAULT 0, ParagraphTemplateID INT NULL DEFAULT 0, ParagraphValidFrom DATETIME NULL , ParagraphValidTo DATETIME NULL , ParagraphCreatedDate DATETIME NULL DEFAULT Now(), ParagraphUpdatedDate DATETIME NULL , ParagraphBottomSpace INT NULL DEFAULT 0, ParagraphModuleSettings MEMO NULL , ParagraphUserCreate INT NULL DEFAULT 0, ParagraphUserEdit INT NULL DEFAULT 0, ParagraphImageLinkTarget NVARCHAR (255) NULL, ParagraphVersionParentID INT NULL DEFAULT 0, ParagraphVersionNumber INT NULL DEFAULT 0, ParagraphWorkflowID INT NULL DEFAULT 0, ParagraphWorkflowState INT NULL DEFAULT 0, ParagraphVersionComment MEMO NULL , ParagraphInheritID INT NULL DEFAULT 0, ParagraphInheritUpdateDate DATETIME NULL , ParagraphInheritStatus INT NULL DEFAULT 0, ParagraphApprovalType INT NULL DEFAULT 0, ParagraphApprovalState INT NULL DEFAULT 0, ParagraphVersionTimeStamp DATETIME NULL , VersionNumber INT NULL DEFAULT 0, VersionCreated DATETIME NULL , VersionEdited DATETIME NULL , VersionUserCreated INT NULL DEFAULT 0, VersionUserEdited INT NULL DEFAULT 0, VersionPublished BIT NOT NULL DEFAULT 0)</sql>
      </ParagraphVersion>
      <Template>
        <sql conditional="">ALTER TABLE Template ADD TemplateDescription MEMO, TemplateActive BIT, TemplateSort INT</sql>
      </Template>
      <Template>
        <sql conditional="">ALTER TABLE Area ADD AreaMasterTemplate NVARCHAR (100) NULL, AreaHtmlType NVARCHAR (10) NULL</sql>
      </Template>
      <Template>
        <sql conditional="">UPDATE [Template] SET TemplateActive = blnTrue</sql>
      </Template>
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleParagraph = blnFalse WHERE [ModuleSystemName] = 'Paygate'</sql>
      </Module>
    </database>
    <!--
    <database file="NewsletterExtended.mdb">
      <NewsletterExtended>
        <sql conditional="">ALTER TABLE NewsletterExtended ADD NewsletterLetterType INT, NewsletterPageBasedLink NVARCHAR (255)</sql>
      </NewsletterExtended>
    </database>
    -->
    <!--<file name="DeliveryTemplate.html" overwrite="false" target="Files/Templates/Dynamicdoc" source="Files/Templates/Dynamicdoc" />-->
    <file name="ParagraphSetup.html" overwrite="false" target="Files/Templates/ParagraphSetup" source="Files/Templates/ParagraphSetup" />
    <!--<file name="ShopOrder.html" overwrite="false" target="Files/Templates/Shop" source="Files/Templates/Shop" />
    <file name="ShopOrderLine.html" overwrite="false" target="Files/Templates/Shop" source="Files/Templates/Shop" />
    <file name="ShopOrderList.html" overwrite="false" target="Files/Templates/Shop" source="Files/Templates/Shop" />
    <file name="ShopOrderListPart.html" overwrite="false" target="Files/Templates/Shop" source="Files/Templates/Shop" />-->
    <folder source="Files/Templates/ImageGallery" target="Files/Templates/" />
    <folder source="Files/Templates/Master" target="Files/Templates/" />
    <folder source="Files/Templates/RSSfeed" target="Files/Templates/" />
    <folder source="Files/Templates/Searchv1" target="Files/Templates/" />
  </package>
  <package version="34" date="03-01-2005" internalversion="18.8.1.0">
    <!--
    <database file="DWShop.mdb">
      <ShopLanguage>
        <sql conditional="">CREATE TABLE ShopLanguage (ShopLanguageID IDENTITY PRIMARY KEY NOT NULL, ShopLanguageCharacter VARCHAR(50) NULL, ShopLanguageText VARCHAR(50) NULL)</sql>
      </ShopLanguage>
      <ShopLanguage>
        <sql conditional="SELECT * FROM ShopLanguage WHERE ShopLanguageCharacter = 'da'">INSERT INTO ShopLanguage (ShopLanguageCharacter, ShopLanguageText) VALUES('da','Dansk')</sql>
      </ShopLanguage>
      <ShopLanguage>
        <sql conditional="SELECT * FROM ShopLanguage WHERE ShopLanguageCharacter = 'sv'">INSERT INTO ShopLanguage (ShopLanguageCharacter, ShopLanguageText) VALUES('sv','Svensk')</sql>
      </ShopLanguage>
      <ShopLanguage>
        <sql conditional="SELECT * FROM ShopLanguage WHERE ShopLanguageCharacter = 'no'">INSERT INTO ShopLanguage (ShopLanguageCharacter, ShopLanguageText) VALUES('no','Norsk')</sql>
      </ShopLanguage>
      <ShopLanguage>
        <sql conditional="SELECT * FROM ShopLanguage WHERE ShopLanguageCharacter = 'en'">INSERT INTO ShopLanguage (ShopLanguageCharacter, ShopLanguageText) VALUES('en','Engelsk')</sql>
      </ShopLanguage>
      <ShopLanguage>
        <sql conditional="SELECT * FROM ShopLanguage WHERE ShopLanguageCharacter = 'nl'">INSERT INTO ShopLanguage (ShopLanguageCharacter, ShopLanguageText) VALUES('nl','Hollandsk')</sql>
      </ShopLanguage>
      <ShopLanguage>
        <sql conditional="SELECT * FROM ShopLanguage WHERE ShopLanguageCharacter = 'de'">INSERT INTO ShopLanguage (ShopLanguageCharacter, ShopLanguageText) VALUES('de','Tysk')</sql>
      </ShopLanguage>
      <ShopLanguage>
        <sql conditional="SELECT * FROM ShopLanguage WHERE ShopLanguageCharacter = 'fr'">INSERT INTO ShopLanguage (ShopLanguageCharacter, ShopLanguageText) VALUES('fr','Fransk')</sql>
      </ShopLanguage>
      <ShopLanguage>
        <sql conditional="SELECT * FROM ShopLanguage WHERE ShopLanguageCharacter = 'fi'">INSERT INTO ShopLanguage (ShopLanguageCharacter, ShopLanguageText) VALUES('fi','Finsk')</sql>
      </ShopLanguage>
      <ShopLanguage>
        <sql conditional="SELECT * FROM ShopLanguage WHERE ShopLanguageCharacter = 'es'">INSERT INTO ShopLanguage (ShopLanguageCharacter, ShopLanguageText) VALUES('es','Spansk')</sql>
      </ShopLanguage>
      <ShopLanguage>
        <sql conditional="SELECT * FROM ShopLanguage WHERE ShopLanguageCharacter = 'it'">INSERT INTO ShopLanguage (ShopLanguageCharacter, ShopLanguageText) VALUES('it','Italiensk')</sql>
      </ShopLanguage>
      <ShopCurrency>
        <sql conditional="">ALTER TABLE ShopCurrency ADD ShopCurrencyDIBSAccount INT NULL, ShopCurrencyDIBSLanguageID INT NULL</sql>
      </ShopCurrency>
    </database>
    -->
  </package>

  <package version="32" date="11-05-2004" internalversion="18.8.1.0">
    <database file="Access.mdb">
      <AccessUser>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserPasswordDate DATETIME</sql>
      </AccessUser>
      <AccessUserPassword>
        <sql conditional="">CREATE TABLE AccessUserPassword (AccessUserPasswordID IDENTITY PRIMARY KEY NOT NULL , AccessUserPasswordPassword VARCHAR(50) , AccessUserPasswordCreated DATETIME NULL, AccessUserPasswordUserID INT NULL )</sql>
      </AccessUserPassword>
    </database>
    <database file="Dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleParagraph = 0 WHERE  ModuleSystemName = 'Personalize'</sql>
      </Module>
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleAccess = 0 WHERE ModuleSystemName = 'PDA' OR ModuleSystemName = 'Personalize' OR ModuleSystemName = 'Audit'</sql>
      </Module>
      <!--
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleHiddenMode = 1 WHERE ModuleSystemName = 'ModuleGenerator' AND ModuleAccess = 0</sql>
      </Module>
      -->
      <!--
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleHiddenMode = 1 WHERE ModuleSystemName = 'Searchv2'</sql>
      </Module>
      -->
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE  (ModuleAccess = 0) AND (ModuleSystemName = 'Corporate')">UPDATE [Module] SET ModuleAccess = 1 WHERE ModuleSystemName = 'PDA' OR ModuleSystemName = 'Personalize' OR ModuleSystemName = 'Audit'</sql>
      </Module>
      <!--
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'CartV2'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode) VALUES ('CartV2', 'Indkobskurv', 0, 0, 1, 1)</sql>
      </Module>
      -->
    </database>
    <!--
    <file name="ChangePassword.html" overwrite="false" target="Files/Templates/Extranet" source="Files/Templates/Extranet" />
    <file name="Extranet_Edit_wSecurity.html" overwrite="false" target="Files/Templates/ExtranetExtended" source="Files/Templates/ExtranetExtended" />
    <file name="DIBSv2.html" overwrite="false" target="Files/Templates/Shop" source="Files/Templates/Shop" />
    <file name="CartListAlternative.html" overwrite="false" target="Files/Templates/Shop" source="Files/Templates/Shop" />
    -->
  </package>
  <package version="31" date="28-04-2004" internalversion="18.8.1.0">
    <database file="Access.mdb">
      <AccessUser>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserAdsiMap VARCHAR(255)</sql>
      </AccessUser>
      <AccessUserAddress>
        <sql conditional="">ALTER TABLE AccessUserAddress ADD AccessUserAddressUID VARCHAR(25)</sql>
      </AccessUserAddress>
    </database>
    <database file="Dynamic.mdb">
      <CalenderEvent>
        <sql conditional="">ALTER TABLE CalenderEvent ADD CalenderEventUserCreate INT</sql>
      </CalenderEvent>
      <CalenderEvent>
        <sql conditional="">ALTER TABLE CalenderEvent ADD CalenderEventUserEdit INT</sql>
      </CalenderEvent>
      <Module>
        <sql conditional="">ALTER TABLE [Module] ADD ModuleDescription MEMO</sql>
      </Module>
      <News>
        <sql conditional="">ALTER TABLE News ADD NewsUserCreate INT</sql>
      </News>
      <News>
        <sql conditional="">ALTER TABLE News ADD NewsUserEdit INT</sql>
      </News>
      <Page>
        <sql conditional="">ALTER TABLE Page ADD PageShowFavorites BIT</sql>
      </Page>
      <TaskManager>
        <sql conditional="">CREATE TABLE TaskManager ( TaskID IDENTITY PRIMARY KEY NOT NULL, TaskHeader VARCHAR (255) NULL, TaskDeadline DATETIME NULL, TaskCreated DATETIME NULL, TaskGiverID INT NULL, TaskTakerID INT NULL, TaskNotification BIT NOT NULL, TaskStatus INT NULL, TaskDescription Memo NULL, TaskComments  Memo NULL, TaskPriority INT NULL)</sql>
      </TaskManager>
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Audit'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode) VALUES ('Audit', 'Audit', 0, 0, 'Audit/Audit_list.asp', 1, 0)</sql>
      </Module>
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'PDA'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode) VALUES ('PDA', 'PDA/Smartphone support', 0, 0, 0, 0)</sql>
      </Module>
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Personalize'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode) VALUES ('Personalize', 'Personalisering', 0, 0, 1, 0)</sql>
      </Module>
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'TaskManager'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode) VALUES ('TaskManager', 'Notificering', 0, 0, 'TaskManager/TaskManager_Administration.asp', 0, 0)</sql>
      </Module>
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleAccess = 1 WHERE ModuleSystemName = 'Business' AND 2 = (SELECT COUNT(*) FROM [Module] WHERE (ModuleAccess = 0) AND ((ModuleSystemName = 'Corporate') OR (ModuleSystemName = 'Light')))</sql>
      </Module>
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleName = 'Portal' WHERE ModuleSystemName = 'Corporate'</sql>
      </Module>
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleName = 'Tilgængelighed' WHERE ModuleSystemName = 'Accessibility'</sql>
      </Module>
      <Module>
        <sql conditional="">UPDATE [Module] SET ModuleHiddenMode = 0 WHERE ModuleSystemName Like 'Business'</sql>
      </Module>
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE  (ModuleAccess = 0) AND (ModuleSystemName = 'Corporate')">UPDATE [Module] SET ModuleAccess = 1 WHERE ModuleSystemName = 'PDA' OR ModuleSystemName = 'Personalize' OR ModuleSystemName = 'Audit'</sql>
      </Module>
    </database>
    <!--
    <database file="NewsletterExtended.mdb">
      <NewsletterExtended>
        <sql conditional="">ALTER TABLE NewsletterExtended ADD NewsletterSpecTextMail BIT, NewsletterTextMailBody MEMO</sql>
      </NewsletterExtended>
    </database>
    -->
    <database file="Statisticsv2.mdb">
      <Statv2Object>
        <sql conditional="">CREATE TABLE Statv2Object (Statv2ObjectID IDENTITY PRIMARY KEY NOT NULL, Statv2ObjectSessionID VARCHAR (50) NULL, Statv2ObjectType VARCHAR (10) NULL, Statv2ObjectElement VARCHAR (255) NULL, Statv2ObjectTimestamp DATETIME NULL)</sql>
      </Statv2Object>
      <Statv2SessionBot>
        <sql conditional="">ALTER TABLE Statv2SessionBot ADD Statv2SessionGwIPDbl DOUBLE</sql>
      </Statv2SessionBot>
    </database>
    <database file="Stylesheet.mdb">
      <FavoritesLayout>
        <sql conditional="">CREATE TABLE FavoritesLayout (FavoritesLayoutID IDENTITY PRIMARY KEY NOT NULL, FavoritesLayoutName VARCHAR (255) NULL, FavoritesLayoutTemplateList VARCHAR (50) NULL, FavoritesLayoutTemplateElement VARCHAR (255) NULL, FavoritesLayoutButton INT NULL, FavoritesLayoutButtonImage VARCHAR (50) NULL, FavoritesLayoutButtonText VARCHAR (50) NULL)</sql>
      </FavoritesLayout>
    </database>
    <!--
    <database file="DWShop.mdb">
      <ShopProduct>
        <sql conditional="">ALTER TABLE [ShopProduct] ADD ShopProductGroupNumber VARCHAR(100)</sql>
      </ShopProduct>
      <ShopOrder>
        <sql conditional="">ALTER TABLE ShopOrder ADD ShopOrderStatus INT</sql>
      </ShopOrder>
      <ShopOrderLine>
        <sql conditional="">ALTER TABLE ShopOrderLine ADD ShopOrderLineProductID INT, ShopOrderLineGroupName VARCHAR(255)</sql>
      </ShopOrderLine>
    </database>
    -->
    <file name="FavoritesElement.html" target="Files/Templates/PageFeatures" source="Files/Templates/PageFeatures" />
    <file name="FavoritesList.html" target="Files/Templates/PageFeatures" source="Files/Templates/PageFeatures" />
    <!--<file name="CartOrderConfirmMail_wCurrency.html" overwrite="false" target="Files/Templates/Shop" source="Files/Templates/Shop" />
    <file name="CartOrderMail_wCurrency.html" overwrite="false" target="Files/Templates/Shop" source="Files/Templates/Shop" />
    <file name="DWWordTemp.doc" target="Files" source="Files" />
    <file name="dsoframer.ocx" target="Files" source="Files" />-->
    <folder source="Files/Templates/Audit" target="Files/Templates/" />
    <!--<folder source="Files/Templates/TaskManager" target="Files/Templates/" />-->
  </package>
  <package version="30" date="22-01-2004" internalversion="18.7.3.0">
    <database file="Access.mdb">
      <AccessUser>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserRead  BIT</sql>
      </AccessUser>
    </database>
  </package>
  <package version="29" date="22-01-2004" internalversion="18.7.2.0">
    <!--
    <database file="DWShop.mdb">
      <ShopOrder>
        <sql conditional="">ALTER TABLE ShopOrder ADD ShopOrderCurrencyID INT, ShopOrderCurrencyName VARCHAR(100) NULL, ShopOrderCurrencyCharacter VARCHAR(20) NULL, ShopOrderCurrencyRate INT NULL</sql>
      </ShopOrder>
      <ShopProduct>
        <sql conditional="">ALTER TABLE ShopProduct DROP ShopOrderCurrencyID, ShopOrderCurrencyName, ShopOrderCurrencyCharacter, ShopOrderCurrencyRate</sql>
      </ShopProduct>
    </database>
    -->
  </package>
  <package version="28" date="22-01-2004" internalversion="18.7.1.0">
    <!--
    <database file="DWShop.mdb">
      <ShopProduct>
        <sql conditional="">ALTER TABLE ShopProduct ADD ShopOrderCurrencyID INT, ShopOrderCurrencyName VARCHAR(100) NULL, ShopOrderCurrencyCharacter VARCHAR(20) NULL, ShopOrderCurrencyRate INT NULL</sql>
      </ShopProduct>
    </database>
    -->
    <database file="Access.mdb">
      <AccessUser>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserCurrencyCharacter VARCHAR(3) NULL</sql>
      </AccessUser>
    </database>
  </package>
  <package version="27" date="21-01-2004" internalversion="18.6.1.0">
    <!--
    <database file="DWShop.mdb">
      <ShopProduct>
        <sql conditional="">ALTER TABLE ShopProduct ADD ShopProductRead BIT</sql>
      </ShopProduct>
      <ShopGroup>
        <sql conditional="">ALTER TABLE ShopGroup ADD ShopGroupRead BIT</sql>
      </ShopGroup>
      <ShopOrder>
        <sql conditional="">ALTER TABLE ShopOrder ADD ShopOrderRead BIT</sql>
      </ShopOrder>
      <ShopOrderLine>
        <sql conditional="">ALTER TABLE ShopOrderLine ADD ShopOrderLineRead BIT</sql>
      </ShopOrderLine>
      <ShopCurrency>
        <sql conditional="">ALTER TABLE ShopCurrency ADD ShopCurrencyRead BIT</sql>
      </ShopCurrency>
    </database>
    -->
    <database file="Access.mdb">
      <AccessUser>
        <sql conditional="">ALTER TABLE AccessUser DROP AccessUserCurrencyID</sql>
      </AccessUser>
      <AccessUserAddress>
        <sql conditional="">ALTER TABLE AccessUserAddress ADD AccessUserAddressCustomerNumber VARCHAR(50) NULL</sql>
      </AccessUserAddress>
    </database>
  </package>
  <package version="26" date="21-01-2004" internalversion="18.5.1.0">
    <database file="dynamic.mdb">
      <Module>
        <sql conditional="">UPDATE [Module] SET [ModuleHiddenMode] = 1 WHERE [ModuleSystemName] ='VersionControl' AND [ModuleAccess] = 0</sql>
      </Module>
      <Module>
        <sql conditional="">UPDATE [Module] SET [ModuleHiddenMode] = 1 WHERE [ModuleSystemName] ='Workflow' AND [ModuleAccess] = 0</sql>
      </Module>
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Filepublish'">INSERT INTO [Module] (ModuleSystemName, ModuleStandard, ModuleAccess, ModuleName, ModuleHiddenMode) VALUES ('Filepublish', 0, 0, 'Fil publicering', 0)</sql>
      </Module>
      <Page>
        <sql conditional="">ALTER TABLE Page DROP PageUseCacheFrequence</sql>
      </Page>
      <Page>
        <sql conditional="">ALTER TABLE Page DROP PageUseCache</sql>
      </Page>
      <Page>
        <sql conditional="">ALTER TABLE Page ADD PageCacheMode INT, PageCacheFrequence INT, PageTextIndex MEMO</sql>
      </Page>
      <Page>
        <sql conditional="">
        </sql>
      </Page>
      <News>
        <sql conditional="">ALTER TABLE News ADD NewsLinkPopup BIT</sql>
      </News>
      <NewsCategory>
        <sql conditional="">ALTER TABLE NewsCategory ADD NewsCategoryAccess VARCHAR(255)</sql>
      </NewsCategory>
    </database>
    <!--
    <database file="DWShop.mdb">
      <ShopPayment>
        <sql conditional="">ALTER TABLE ShopPayment ADD ShopPaymentPrice2 INT NULL, ShopPaymentMaxTotal INT NULL, ShopPaymentActive BIT, ShopPaymentSystemName VARCHAR(250) NULL</sql>
      </ShopPayment>
      <ShopCurrency>
        <sql conditional="">CREATE TABLE ShopProductField (ShopProductFieldID IDENTITY PRIMARY KEY NOT NULL, ShopProductFieldTypeID INT NULL, ShopProductFieldGroupID INT NULL, ShopProductFieldName VARCHAR (255) NULL, ShopProductFieldType VARCHAR (255) NULL, ShopProductFieldLocked BIT NOT NULL, ShopProductFieldSystemName VARCHAR (255) NULL,	ShopProductFieldTemplateName VARCHAR (255) NULL, ShopProductFieldSort INT NULL,	ShopProductFieldDoNotPublish BIT NULL)</sql>
      </ShopCurrency>
      <ShopCurrency>
        <sql conditional="">CREATE TABLE ShopCurrency (ShopCurrencyID IDENTITY PRIMARY KEY NOT NULL,  ShopCurrencyName VARCHAR(255) NULL, ShopCurrencyRate INT NULL, ShopCurrencyCharacter VARCHAR (255) NULL, ShopCurrencyImage VARCHAR (255) NULL, ShopCurrencyDate DATETIME, ShopCurrencyDefault BIT)</sql>
      </ShopCurrency>
      <ShopCurrency>
        <sql conditional="">ALTER TABLE ShopCurrency ADD ShopCurrencyDefault BIT</sql>
      </ShopCurrency>
      <ShopGroup>
        <sql conditional="">ALTER TABLE ShopGroup ADD ShopGroupDocTemplateID INT</sql>
      </ShopGroup>
      <ShopProductField>
        <sql conditional="">ALTER TABLE ShopProductField ADD ShopProductFieldSort INT, ShopProductFieldDoNotPublish BIT</sql>
      </ShopProductField>
      <ShopProduct>
        <sql conditional="">ALTER TABLE ShopProduct ADD ShopProductParentID INT, ShopProductVariantList VARCHAR(100), ShopProductVariantListElement VARCHAR(100), ShopProductSpecificFieldXml Memo</sql>
      </ShopProduct>
      <ShopProductFieldGroup>
        <sql conditional="">CREATE TABLE ShopProductFieldGroup (ShopProductFieldGroupID IDENTITY PRIMARY KEY NOT NULL,  ShopProductFieldGroupName VARCHAR(255) NULL, ShopProductFieldGroupTag VARCHAR (255) NULL, ShopProductFieldGroupSort INT)</sql>
      </ShopProductFieldGroup>
      <ShopProduct>
        <sql conditional="">ALTER TABLE ShopProduct ADD ShopProductCustomFieldsListElement VARCHAR(100), ShopProductTemplate VARCHAR(100), ShopProductCustomFieldsList VARCHAR(100)</sql>
      </ShopProduct>
      <ShopGroup>
        <sql conditional="">ALTER TABLE ShopGroup ADD ShopGroupCustomFieldsList VARCHAR(100), ShopGroupCustomFieldsListElement VARCHAR(100), ShopGroupProductTemplate VARCHAR(100), ShopGroupFieldGroupID INT</sql>
      </ShopGroup>
      <ShopProductFieldType>
        <sql conditional="">CREATE TABLE ShopProductFieldType (ShopProductFieldTypeID IDENTITY PRIMARY KEY NOT NULL, ShopProductFieldTypeName varchar (255) NULL, ShopProductFieldTypeDW varchar (255) NULL, ShopProductFieldTypeOption varchar (255) NULL, ShopProductFieldTypeDB varchar (255) NULL, ShopProductFieldTypeDBSQL varchar (255) NULL )</sql>
      </ShopProductFieldType>
      <ShopProductFieldType>
        <sql conditional="SELECT * FROM [ShopProductFieldType] WHERE [ShopProductFieldTypeName] = 'Tekst (255)'">INSERT INTO ShopProductFieldType (ShopProductFieldTypeName, ShopProductFieldTypeDW, ShopProductFieldTypeDB, ShopProductFieldTypeDBSQL) VALUES ('Tekst (255)', 'Text', 'VARCHAR(255) NULL', 'VARCHAR(255) NULL')</sql>
      </ShopProductFieldType>
      <ShopProductFieldType>
        <sql conditional="SELECT * FROM [ShopProductFieldType] WHERE [ShopProductFieldTypeName] = 'Lang tekst'">INSERT INTO ShopProductFieldType (ShopProductFieldTypeName, ShopProductFieldTypeDW, ShopProductFieldTypeDB, ShopProductFieldTypeDBSQL) VALUES ('Lang tekst', 'LargeText', 'MEMO NULL', 'NTEXT NULL')</sql>
      </ShopProductFieldType>
      <ShopProductFieldType>
        <sql conditional="SELECT * FROM [ShopProductFieldType] WHERE [ShopProductFieldTypeName] = 'Checkboks'">INSERT INTO ShopProductFieldType (ShopProductFieldTypeName, ShopProductFieldTypeDW, ShopProductFieldTypeDB, ShopProductFieldTypeDBSQL) VALUES ('Checkboks', 'Checkbox', 'BIT', 'BIT')</sql>
      </ShopProductFieldType>
      <ShopProductFieldType>
        <sql conditional="SELECT * FROM [ShopProductFieldType] WHERE [ShopProductFieldTypeName] = 'Dato'">INSERT INTO ShopProductFieldType (ShopProductFieldTypeName, ShopProductFieldTypeDW, ShopProductFieldTypeDB, ShopProductFieldTypeDBSQL) VALUES ('Dato', 'Date', 'DATE NULL', 'DATE NULL')</sql>
      </ShopProductFieldType>
      <ShopProductFieldType>
        <sql conditional="SELECT * FROM [ShopProductFieldType] WHERE [ShopProductFieldTypeName] = 'Dato/tid'">INSERT INTO ShopProductFieldType (ShopProductFieldTypeName, ShopProductFieldTypeDW, ShopProductFieldTypeDB, ShopProductFieldTypeDBSQL) VALUES ('Dato/tid', 'DateTime', 'DATE NULL', 'DATE NULL')</sql>
      </ShopProductFieldType>
      <ShopProductFieldType>
        <sql conditional="SELECT * FROM [ShopProductFieldType] WHERE [ShopProductFieldTypeName] = 'Heltal'">INSERT INTO ShopProductFieldType (ShopProductFieldTypeName, ShopProductFieldTypeDW, ShopProductFieldTypeDB, ShopProductFieldTypeDBSQL) VALUES ('Heltal', 'Integer', 'INT NULL', 'INT NULL')</sql>
      </ShopProductFieldType>
      <ShopProductFieldType>
        <sql conditional="SELECT * FROM [ShopProductFieldType] WHERE [ShopProductFieldTypeName] = 'Link'">INSERT INTO ShopProductFieldType (ShopProductFieldTypeName, ShopProductFieldTypeDW, ShopProductFieldTypeDB, ShopProductFieldTypeDBSQL) VALUES ('Link', 'Link', 'VARCHAR(255) NULL', 'VARCHAR(255) NULL')</sql>
      </ShopProductFieldType>
      <ShopProductFieldType>
        <sql conditional="SELECT * FROM [ShopProductFieldType] WHERE [ShopProductFieldTypeName] = 'Filarkiv'">INSERT INTO ShopProductFieldType (ShopProductFieldTypeName, ShopProductFieldTypeDW, ShopProductFieldTypeDB, ShopProductFieldTypeDBSQL) VALUES ('Filarkiv', 'Filemanager', 'VARCHAR(255) NULL', 'VARCHAR(255) NULL')</sql>
      </ShopProductFieldType>
      <ShopProductFieldType>
        <sql conditional="SELECT * FROM [ShopProductFieldType] WHERE [ShopProductFieldTypeName] = 'Tekst (100)'">INSERT INTO ShopProductFieldType (ShopProductFieldTypeName, ShopProductFieldTypeDW, ShopProductFieldTypeDB, ShopProductFieldTypeDBSQL) VALUES ('Tekst (100)', 'Text', 'VARCHAR(100) NULL', 'VARCHAR(100) NULL')</sql>
      </ShopProductFieldType>
      <ShopProductFieldType>
        <sql conditional="SELECT * FROM [ShopProductFieldType] WHERE [ShopProductFieldTypeName] = 'Tekst (50)'">INSERT INTO ShopProductFieldType (ShopProductFieldTypeName, ShopProductFieldTypeDW, ShopProductFieldTypeDB, ShopProductFieldTypeDBSQL) VALUES ('Tekst (50)', 'Text', 'VARCHAR(50) NULL', 'VARCHAR(50) NULL')</sql>
      </ShopProductFieldType>
      <ShopProductFieldType>
        <sql conditional="SELECT * FROM [ShopProductFieldType] WHERE [ShopProductFieldTypeName] = 'Tekst (20)'">INSERT INTO ShopProductFieldType (ShopProductFieldTypeName, ShopProductFieldTypeDW, ShopProductFieldTypeDB, ShopProductFieldTypeDBSQL) VALUES ('Tekst (20)', 'Text', 'VARCHAR(20) NULL', 'VARCHAR(20) NULL')</sql>
      </ShopProductFieldType>
      <ShopProductFieldType>
        <sql conditional="SELECT * FROM [ShopProductFieldType] WHERE [ShopProductFieldTypeName] = 'Tekst (5)'">INSERT INTO ShopProductFieldType (ShopProductFieldTypeName, ShopProductFieldTypeDW, ShopProductFieldTypeDB, ShopProductFieldTypeDBSQL) VALUES ('Tekst (5)', 'Text', 'VARCHAR(5) NULL', 'VARCHAR(5) NULL')</sql>
      </ShopProductFieldType>
      <ShopProductFieldType>
        <sql conditional="SELECT * FROM [ShopProductFieldType] WHERE [ShopProductFieldTypeName] = 'Gruppering'">INSERT INTO ShopProductFieldType (ShopProductFieldTypeName, ShopProductFieldTypeDW, ShopProductFieldTypeDB, ShopProductFieldTypeDBSQL) VALUES ('Gruppering', 'Group', '', '')</sql>
      </ShopProductFieldType>
    </database>
    -->
    <database file="Access.mdb">
      <AccessUser>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserCurrencyID  INT</sql>
      </AccessUser>
      <AccessUserAddress>
        <sql conditional="">CREATE TABLE AccessUserAddress (AccessUserAddressID IDENTITY PRIMARY KEY NOT NULL, AccessUserAddressUserID INT NOT NULL, AccessUserAddressType BIT NOT NULL, AccessUserAddressCallName VARCHAR(50) NULL, AccessUserAddressCompany VARCHAR(100) NULL, AccessUserAddressName VARCHAR(100) NULL, AccessUserAddressAddress VARCHAR(100) NULL, AccessUserAddressAddress2 VARCHAR(100) NULL, AccessUserAddressZip VARCHAR(10) NULL, AccessUserAddressCity VARCHAR(100) NULL, AccessUserAddressCountry VARCHAR(30) NULL, AccessUserAddressPhone VARCHAR(20) NULL, AccessUserAddressCell VARCHAR(20) NULL, AccessUserAddressFax VARCHAR(20) NULL, AccessUserAddressEmail VARCHAR(100) NULL)</sql>
      </AccessUserAddress>
      <AccessUserAddress>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserAddress  VARCHAR(100), AccessUserAddress2  VARCHAR(100), AccessUserZip  VARCHAR(10), AccessUserCity  VARCHAR(100), AccessUserCountry VARCHAR(30), AccessUserJobTitle VARCHAR(50), AccessUserCompany VARCHAR(50), AccessUserPhonePriv VARCHAR(20), AccessUserMobile VARCHAR(20), AccessUserCustomerNumber VARCHAR(50)</sql>
      </AccessUserAddress>
      <AccessElementType>
        <sql conditional="">CREATE TABLE AccessElementType (AccessElementTypeID IDENTITY PRIMARY KEY NOT NULL, AccessElementType VARCHAR(255))</sql>
      </AccessElementType>
      <AccessElementPermission>
        <sql conditional="">CREATE TABLE AccessElementPermission (AccessElementPermissionID IDENTITY PRIMARY KEY NOT NULL, AccessElementPermissionTypeID INT NULL, AccessElementPermissionUserID INT NULL, AccessElementPermissionElementID INT NULL, AccessElementPermissionElementTextID VARCHAR(255))</sql>
      </AccessElementPermission>
      <AccessElementType>
        <sql conditional="SELECT * FROM [AccessElementType] WHERE [AccessElementType] = 'folder'">INSERT INTO AccessElementType (AccessElementType) VALUES ('folder')</sql>
      </AccessElementType>
      <AccessElementType>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserRedirectOnLogin  VARCHAR(255)</sql>
      </AccessElementType>
      <AccessUser>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserRead  BIT, AccessUserCurrencyCharacter VARCHAR(3)</sql>
      </AccessUser>
    </database>
    <!--<file name="ForumListCategories_wSubscription.html" target="Files/Templates/Forum" source="Files/Templates/Forum" />-->
    <file name="FAQMail.html" target="Files/Templates/FAQ" source="Files/Templates/FAQ" />
    <!--<file name="Custom_Admin.asp" target="Files" source="Files" />
    <file name="ShopCustomFieldsList.html" target="Files/Templates/Shop" source="Files/Templates/Shop" />
    <file name="ShopCustomFieldsListElement.html" target="Files/Templates/Shop" source="Files/Templates/Shop" />
    <file name="ShopVariantList.html" target="Files/Templates/Shop" source="Files/Templates/Shop" />
    <file name="ShopVariantListElement.html" target="Files/Templates/Shop" source="Files/Templates/Shop" />
    <file name="ShowCurrencyPickerList_Char.html" target="Files/Templates/Shop" source="Files/Templates/Shop" />
    <file name="ShowCurrencyPickerList_img.html" target="Files/Templates/Shop" source="Files/Templates/Shop" />
    <file name="ShowCurrencyPickerListElement_Char.html" target="Files/Templates/Shop" source="Files/Templates/Shop" />
    <file name="ShowCurrencyPickerListElement_img.html" target="Files/Templates/Shop" source="Files/Templates/Shop" />
    <file name="ShowProductList_wSearch.html" target="Files/Templates/Shop" source="Files/Templates/Shop" />
    <file name="ShowProductSearch.html" target="Files/Templates/Shop" source="Files/Templates/Shop" />-->
    <file name="NewsletterReceiptDefault_UserFields.html" target="Files/Templates/Newsletters" source="Files/Templates/Newsletters" />
    <folder source="Files/Templates/Filepublish" target="Files/Templates/" />
  </package>
  <package version="25" date="14-11-2003" internalversion="18.4.1.0">
    <database file="dynamic.mdb">
      <FormField>
        <sql conditional="">ALTER TABLE FormField ADD FormFieldSystemName VARCHAR(255)</sql>
      </FormField>
    </database>
  </package>
  <package version="24" date="16-09-2003" internalversion="18.4.1.0">
    <database file="dynamic.mdb">
      <!--
      <Module>
        <sql conditional="">UPDATE [MODULE] SET [ModuleDatabase]='', [ModuleTable]='', [ModuleFieldID]='', [ModuleFieldName]='', [ModuleWhere]='' WHERE [ModuleSystemName] = 'NewsletterExtended'</sql>
      </Module>
      -->
      <page>
        <sql conditional="">UPDATE Page SET PageShowInLegend = -1 WHERE PageShowInLegend IS NULL OR PageShowInLegend = 1</sql>
      </page>
    </database>
    <!--<file name="NewsletterExtended.mdb" target="Database" source="Database" />-->
  </package>
  <package version="23" date="10-09-2003" internalversion="18.4.1.0">
    <database file="access.mdb">
      <AccessWorkflow>
        <sql conditional="">CREATE TABLE [AccessWorkflow] (AccessWorkflowID COUNTER PRIMARY KEY, AccessWorkflowTitle VARCHAR(255), AccessWorkflowCreatedDate DATETIME)</sql>
      </AccessWorkflow>
      <AccessWorkflowLog>
        <sql conditional="">CREATE TABLE [AccessWorkflowLog] (AccessWorkflowLogID COUNTER PRIMARY KEY, AccessWorkflowLogSystemName VARCHAR(255), AccessWorkflowLogSystemChildID INT, AccessWorkflowLogStepID INT, AccessWorkflowLogComment MEMO, AccessWorkflowLogPostDate DATETIME)</sql>
      </AccessWorkflowLog>
      <AccessWorkflowUser>
        <sql conditional="">CREATE TABLE [AccessWorkflowUser] (AccessWorkflowUserID COUNTER PRIMARY KEY, AccessWorkflowUserUserID INT, AccessWorkflowUserWorkflowID INT, AccessWorkflowUserRole INT, AccessWorkflowUserPriority INT, AccessWorkflowUserNotify BIT, AccessWorkflowUserRequired BIT)</sql>
      </AccessWorkflowUser>
    </database>
    <database file="Stylesheet.mdb">
      <LegendLayout>
        <sql conditional="">ALTER TABLE LegendLayout ADD LegendLayoutTextdecoration VARCHAR(255), LegendLayoutFontStyle VARCHAR(255), LegendLayoutTextdecorationActive VARCHAR(255), LegendLayoutFontStyleActive VARCHAR(255)</sql>
      </LegendLayout>
    </database>
    <database file="dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Workflow'">INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleHiddenMode], [ModuleScript]) VALUES ('Workflow','Godkendelse', 0, 'Workflow/Workflow_List.asp')</sql>
      </Module>
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'VersionControl'">INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleHiddenMode], [ModuleControlPanel]) VALUES ('VersionControl','Versionstyring', 0, 'Workflow/Workflow_Cpl.asp')</sql>
      </Module>
      <!--
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'NewsletterExtended'">INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleHiddenMode], [ModuleScript], [ModuleControlPanel], [ModuleParagraph], [ModuleDatabase], [ModuleTable], [ModuleFieldID], [ModuleFieldName]) VALUES ('NewsletterExtended','Udvidet Nyhedsbreve', 0, 'NewsletterExtended/NewsletterExtended_front.asp', 'NewsletterExtended/NewsletterExtended_cpl.asp', 1, 'NewsletterExtended.mdb', 'NewsletterCategory', 'NewsletterCategoryID', 'NewsletterCategoryName')</sql>
      </Module>
      -->
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'TemplateColumn'">INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleHiddenMode], [ModuleStandard], [ModuleParagraph]) VALUES ('TemplateColumn','Kolonneskift', 0, 1, 1)</sql>
      </Module>
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Statisticsv2'">INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleHiddenMode], [ModuleStandard], [ModuleParagraph], [ModuleControlPanel], [ModuleAccess], [ModuleScript]) VALUES ('Statisticsv2','Statistik 2003', 0, 1, 0, '', 1, '../Statisticsv2/Menu.asp')</sql>
      </Module>
      <module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'Accessibility'">INSERT INTO [Module] (ModuleSystemName, ModuleStandard, ModuleName, ModuleHiddenMode) VALUES ('Accessibility', 1, 'Tilgængelighed', 0)</sql>
      </module>
      <CalenderCategory>
        <sql conditional="">ALTER TABLE CalenderCategory ADD CalenderCategoryWorkflowID INT</sql>
      </CalenderCategory>
      <CalenderEvent>
        <sql conditional="">ALTER TABLE CalenderEvent ADD CalenderEventWorkflowID INT, CalenderEventWorkflowState INT, CalenderEventVersionParentID INT, CalenderEventVersionNumber INT, CalenderEventVersionComments MEMO, CalenderEventBookPage VARCHAR(255)</sql>
      </CalenderEvent>
      <CalenderEvent>
        <sql conditional="">UPDATE CalenderEvent SET CalenderEventWorkflowState=0, CalenderEventVersionParentID= CalenderEventID, CalenderEventVersionNumber = 1 WHERE CalenderEventWorkflowState IS NULL AND CalenderEventVersionParentID IS NULL</sql>
      </CalenderEvent>
      <CalenderEvent>
        <sql conditional="">ALTER TABLE CalenderEvent ADD CalenderEventBookPage VARCHAR(255)</sql>
      </CalenderEvent>
      <FAQCategory>
        <sql conditional="">ALTER TABLE FAQCategory ADD FAQCategoryWorkflowID INT</sql>
      </FAQCategory>
      <FAQItem>
        <sql conditional="">ALTER TABLE FAQItem ADD FAQItemWorkflowID INT, FAQItemWorkflowState INT, FAQItemVersionParentID INT, FAQItemVersionNumber INT, FAQItemVersionComment MEMO, FAQItemValidFrom DATETIME, FAQItemValidTo DATETIME</sql>
      </FAQItem>
      <FAQItem>
        <sql conditional="">UPDATE FAQItem SET FAQItemWorkflowState=0, FAQItemVersionParentID= FAQItemID, FAQItemVersionNumber = 1 WHERE FAQItemVersionParentID IS NULL AND FAQItemWorkflowState IS NULL</sql>
      </FAQItem>
      <News>
        <sql conditional="">ALTER TABLE News ADD NewsVersionParentID INT, NewsVersionNumber INT, NewsWorkflowID INT, NewsWorkflowState INT, NewsVersionComments MEMO</sql>
      </News>
      <News>
        <sql conditional="">UPDATE News SET NewsVersionParentID= NewsID, NewsVersionNumber=1, NewsWorkflowState = 0 WHERE NewsVersionParentID IS NULL AND NewsWorkflowState IS NULL</sql>
      </News>
      <TemplateCategory>
        <sql conditional="SELECT * FROM [TemplateCategory] WHERE TemplateCategoryName = 'Nyhedsbreve'">INSERT INTO [TemplateCategory] ([TemplateCategoryName], [TemplateCatgeoryDirectory], [TemplateCategoryIsProtected]) VALUES ('Nyhedsbreve', 'Newsletters', 1)</sql>
      </TemplateCategory>
      <Template>
        <sql conditional="">INSERT INTO [Template] ([TemplateCategoryID], [TemplateName], [TemplateFile], [TemplateIcon], [TemplateIsProtected], [TemplateIsDefault], [TemplateTypeID], [TemplatePutInTable]) SELECT TemplateCategoryID, 'Newsletter Default Mail', 'NewsletterDefaultMail.html', 'NewsletterDefault.gif', 0, 1, 0, '-1' FROM TemplateCategory WHERE TemplateCategoryName = 'Nyhedsbreve'</sql>
      </Template>
      <NewsCategory>
        <sql conditional="">ALTER TABLE NewsCategory ADD NewsCategoryWorkflowID INT</sql>
      </NewsCategory>
      <Page>
        <sql conditional="">ALTER TABLE Page ADD PageShowInLegend BIT, PageWorkflowID INT, PageWorkflowState INT, PageVersionParentID INT, PageVersionComments MEMO, PageVersionNumber INT</sql>
      </Page>
      <Page>
        <sql conditional="">UPDATE Page SET PageWorkflowState=0, PageVersionParentID= PageID, PageVersionNumber=1 WHERE PageVersionParentID IS NULL AND PageWorkflowState IS NULL</sql>
      </Page>
      <Paragraph>
        <sql conditional="">ALTER TABLE Paragraph ADD ParagraphVersionParentID INT, ParagraphVersionNumber INT, ParagraphWorkflowID INT, ParagraphWorkflowState INT, ParagraphVersionComment MEMO</sql>
      </Paragraph>
      <Paragraph>
        <sql conditional="">UPDATE Paragraph SET ParagraphVersionParentID = ParagraphID, ParagraphVersionNumber=1, ParagraphWorkflowState = 0 WHERE ParagraphWorkflowState IS NULL AND ParagraphVersionParentID IS NULL</sql>
      </Paragraph>
      <Page>
        <sql conditional="">ALTER TABLE Page ADD PageUseCacheFrequence int NULL</sql>
      </Page>
      <page>
        <sql conditional="">ALTER TABLE Page ADD PageUseCache BIT 1</sql>
      </page>
      <area>
        <sql conditional="">ALTER TABLE Area ADD AreaLanguage int null, AreaCodePage int null</sql>
      </area>
      <page>
        <sql conditional="">ALTER TABLE Page ADD PageShowUpdateDate BIT 1</sql>
      </page>
      <page>
        <sql conditional="">ALTER TABLE Page ADD PageShowInLegend BIT 1</sql>
      </page>
      <page>
        <sql conditional="">UPDATE Page SET PageShowInLegend = 1 WHERE PageShowInLegend IS NULL</sql>
      </page>
    </database>
    <!--
    <database file="Dwshop.mdb">
      <ShopProduct>
        <sql conditional="">ALTER TABLE ShopProduct ADD ShopProductAllowAddToCart BIT</sql>
      </ShopProduct>
    </database>
    -->
    <file name="Poll_List.html" target="Files/Templates/Poll" source="Files/Templates/Poll" />
    <!--<file name="DOBSGateWay.html" target="Files/Templates/Shop" source="Files/Templates/Shop" />-->
    <file name="NewsletterCancellationDefault.html" target="Files/Templates/Newsletters" source="Files/Templates/Newsletters" />
    <file name="NewsletterDefaultMail.html" target="Files/Templates/Newsletters" source="Files/Templates/Newsletters" />
    <file name="NewsletterReceiptDefault.html" target="Files/Templates/Newsletters" source="Files/Templates/Newsletters" />
    <file name="NewsletterDefault.gif" target="Files/Templates/Images" source="Files/Templates/Images" />
    <file name="Search.html" target="Files/Templates/MediaDB" source="Files/Templates/MediaDB" />
    <file name="Coloumn_Element.html" target="Files/Templates/MediaDB" source="Files/Templates/MediaDB" />
    <file name="Coloumn_LightboxList.html" target="Files/Templates/MediaDB" source="Files/Templates/MediaDB" />
    <file name="Coloumn_LightboxListElement.html" target="Files/Templates/MediaDB" source="Files/Templates/MediaDB" />
    <file name="Coloumn_List.html" target="Files/Templates/MediaDB" source="Files/Templates/MediaDB" />
    <file name="Coloumn_ListElement.html" target="Files/Templates/MediaDB" source="Files/Templates/MediaDB" />
    <file name="Coloumn_Search.html" target="Files/Templates/MediaDB" source="Files/Templates/MediaDB" />
    <file name="Coloumn_Search_New.html" target="Files/Templates/MediaDB" source="Files/Templates/MediaDB" />
    <!--<file name="Statisticsv2.mdb" target="Database" source="Database" />-->
    <!--<file name="NewsletterExtended.mdb" target="Database" source="Database" />-->
    <folder source="Files/Templates/SiteMap" target="Files/Templates/" />
  </package>
  <package version="22" date="04-06-2003" internalversion="18.3.1.0">
    <folder source="Files/Templates/SiteMap" target="Files/Templates/" />
  </package>
  <package version="21" date="07-05-2003" internalversion="18.3.1.0">
    <database file="Dynamic.mdb">
      <Template>
        <addfield type="INT" name="TemplateImageColumns" />
        <addfield type="INT" name="TemplateImageWidth" />
      </Template>
    </database>
  </package>
  <package version="20" date="05-05-2003" internalversion="18.3.1.0">
    <!--<file name="dwmedia.mdb" target="Database" source="Database" />-->
    <database file="DWMedia.mdb">
      <Medie>
        <sql conditional="">CREATE TABLE MediaDBFiletypes(MediaDBFiletypesID COUNTER, MediaDBFiletypesName VARCHAR(255), MediaDBFiletypesExtensions VarCHAR(255))</sql>
      </Medie>
      <Medie>
        <sql conditional="">CREATE TABLE MediaDBOrientation (MediaDBOrientationID COUNTER, MediaDBOrientationName VARCHAR(255), MediaDBOrientationMinratio DOUBLE, MediaDBOrientationMaxratio DOUBLE)</sql>
      </Medie>
      <Medie>
        <sql conditional="">ALTER TABLE MediaDBMedia ADD MediaDBMediaBlackWhite BIT, MediaDBMediaOriginalID INT NULL, MediaDBMediaColorSpace VARCHAR(255)</sql>
      </Medie>
      <Medie>
        <sql conditional="">ALTER TABLE MediaDBMedia ADD MediaDBMediaResolution VARCHAR(255)</sql>
      </Medie>
    </database>
    <database file="forum.mdb">
      <Forum>
        <sql conditional="">CREATE TABLE ForumUserRelation (ForumUserRelationID COUNTER, ForumUserRelationUserID INT  NOT NULL, ForumUserRelationForumCategoryID INT  NOT NULL)</sql>
      </Forum>
    </database>
    <database file="Dynamic.mdb">
      <AreaEncoding>
        <sql conditional="">ALTER TABLE Area ADD AreaCodepage int NULL DEFAULT 1252, AreaLanguage int NULL DEFAULT 1</sql>
      </AreaEncoding>
      <AreaEncoding>
        <sql conditional="">ALTER TABLE AreaEncoding ADD AreaEncodingCodepage int NULL</sql>
      </AreaEncoding>
      <Page>
        <sql conditional="">ALTER TABLE Page ADD PageManager int NULL</sql>
      </Page>
      <Page>
        <sql conditional="">ALTER TABLE Page ADD PageManageFrequence int NULL</sql>
      </Page>
      <module>
        <sql conditional="SELECT * FROM [module] WHERE [ModuleSystemName] = 'Corporate'">INSERT INTO [Module] ([modulesystemname], [ModuleName], [ModuleStandard], ) VALUES('Corporate', 'Corporate', True)</sql>
      </module>
      <module>
        <sql conditional="">UPDATE [Module] SET [ModuleHiddenMode] = 0 WHERE [ModuleSystemName] = 'Corporate'</sql>
      </module>
      <page>
        <addfield type="MEMO" name="PageDublincore" />
      </page>
    </database>
    <database file="access.mdb">
      <AreaEncoding>
        <sql conditional="">ALTER TABLE AccessUser ADD AccessUserMyFolder VARCHAR(255)</sql>
      </AreaEncoding>
    </database>
    <file name="PageLeftDropdownNavigation.html" target="Files/Templates/Page" source="Files/Templates/Page" />

    <file name="List.html" target="Files/Templates/News" source="Files/Templates/News" />
    <file name="ListElement.html" target="Files/Templates/News" source="Files/Templates/News" />

    <!-- FILES FOR A MODULE THAT NO LONGER EXISTS
    <file name="ForumListCategories.html" target="Files/Templates/Forum" source="Files/Templates/Forum" />
    <file name="ForumListCategoriesItem.html" target="Files/Templates/Forum" source="Files/Templates/Forum" />
    <file name="ForumNotifyAll.txt" target="Files/Templates/Forum" source="Files/Templates/Forum" />
    <file name="ForumMessageShow.html" target="Files/Templates/Forum" source="Files/Templates/Forum" />
    <file name="ForumOriginalMessage.html" target="Files/Templates/Forum" source="Files/Templates/Forum" />
    <file name="ForumMessageReply.html" target="Files/Templates/Forum" source="Files/Templates/Forum" />
    <file name="ForumFrontend.html" target="Files/Templates/Forum" source="Files/Templates/Forum" />
    <file name="ForumMessageList.html" target="Files/Templates/Forum" source="Files/Templates/Forum" />
    <file name="ForumMessageNew.html" target="Files/Templates/Forum" source="Files/Templates/Forum" />
    <file name="ForumMessageThread.html" target="Files/Templates/Forum" source="Files/Templates/Forum" />
    <file name="ForumNotifyEmail.txt" target="Files/Templates/Forum" source="Files/Templates/Forum" />
    -->

    <!-- FILES PROBABLY NO LONGER IN USE
    <file name="Expand.gif" target="Files" source="Files" />
    <file name="Expand_dot.gif" target="Files" source="Files" />
    <file name="Expand_off.gif" target="Files" source="Files" />
    -->
  </package>
  <package version="19" date="29-01-2003" internalversion="18.2.1.1">
    <database file="dynamic.mdb">
      <Page>
        <addfield type="BIT" name="PageShowUpdateDate" />
      </Page>
    </database>
  </package>
  <package version="18" date="14-01-2003" internalversion="18.2.1.0">
    <!-- MODULE NO LONGER EXISTS
    <database file="dwshop.mdb">
      <ShopOrder>
        <addfield type="MEMO" name="ShopOrderComment2" />
        <addfield type="CHAR" name="ShopOrderComment3" />
        <addfield type="CHAR" name="ShopOrderComment4" />
        <addfield type="INT" name="ShopOrderTransActionStatus" />
      </ShopOrder>
      <ShopOrderLine>
        <addfield type="MEMO" name="ShopOrderLineComment1" />
        <addfield type="MEMO" name="ShopOrderLineComment2" />
      </ShopOrderLine>
    </database>
    -->
    <database file="Stylesheet.mdb">
      <SendFriendLayout>
        <addfield type="CHAR" name="SendFriendLayoutPage" />
      </SendFriendLayout>
    </database>
    <!-- MODULE DOES NOT EXIST ANYMORE
    <database file="dynamic.mdb">
      <Module>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'UsersExtended'">INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleHiddenMode]) VALUES ('UsersExtended','Udvidet brugerstyring', 0)</sql>
      </Module>
    </database>
    -->
    <file name="PageLeftDropdownNavigation.html" target="Files/Templates/Page" source="Files/Templates/Page" />
  </package>
</updates>
