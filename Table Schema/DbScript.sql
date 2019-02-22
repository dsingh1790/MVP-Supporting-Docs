


------------------------------------------------------------------------ Login ----------------------------------------------------------

CREATE TABLE [Role]
(
	RoleID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_Role_RoleID] PRIMARY KEY CLUSTERED,
	RoleType VARCHAR(20),
    [Description] VARCHAR(200),
	Is_Active BIT NOT NULL CONSTRAINT [DF_Role_Is_Active] DEFAULT (1),
	CreationUser VARCHAR(200),
	CreationDate DATETIME CONSTRAINT [DF_Role_CreationDate] DEFAULT (GETDATE()),
	ModificationUser VARCHAR(200),
	ModificationDate DATETIME CONSTRAINT [DF_Role_ModificationDate] DEFAULT (GETDATE())

)

GO
CREATE TABLE Features
(
	FeatureID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_Features_FeatureID] PRIMARY KEY CLUSTERED,
	SubFeatureID INT,
	description VARCHAR(200),
	URL_Link VARCHAR(200),
	Is_Active BIT NOT NULL CONSTRAINT [DF_Features_Is_Active] DEFAULT (1),
	CreationUser VARCHAR(200),
	CreationDate DATETIME CONSTRAINT [DF_Features_CreationDate] DEFAULT (GETDATE()),
	ModificationUser VARCHAR(200),
	ModificationDate DATETIME CONSTRAINT [DF_Features_ModificationDate] DEFAULT (GETDATE()),
	CONSTRAINT [FK_Features_SubFeatureID] FOREIGN KEY (SubFeatureID) REFERENCES Features(FeatureID)
	
)
GO

CREATE TABLE RoleFeaturesMap
(

	RoleFeaturesMapID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_RoleFeaturesMap_RoleFeaturesMapID] PRIMARY KEY CLUSTERED,
	RoleID INT,
	FeatureID INT,
	Description VARCHAR(200),
	Is_Active BIT NOT NULL CONSTRAINT [DF_RoleFeaturesMap_Is_Active] DEFAULT (1),
	CreationUser VARCHAR(200),
	CreationDate DATETIME CONSTRAINT [DF_RoleFeaturesMap_CreationDate] DEFAULT (GETDATE()),
	ModificationUser VARCHAR(200),
	ModificationDate DATETIME CONSTRAINT [DF_RoleFeaturesMap_ModificationDate] DEFAULT (GETDATE()),
	CONSTRAINT [FK_RoleFeaturesMap_RoleID] FOREIGN KEY (RoleID) REFERENCES Role(RoleID),
	CONSTRAINT [FK_RoleFeaturesMap_FEATURESID] FOREIGN KEY (RoleID) REFERENCES Features(FeatureID)

)
GO

CREATE TABLE UserLogIn
(
	UserLogInID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_UserLogIn_UserLogInID] PRIMARY KEY CLUSTERED,
	UserName VARCHAR(200),
	[Password] VARCHAR(200),
	[RoleID] INT, 
	Email VARCHAR(300),
	Is_Active BIT NOT NULL CONSTRAINT [DF_UserLogIn_Is_Active] DEFAULT (1),
	CreationUser VARCHAR(200),
	CreationDate DATETIME CONSTRAINT [DF_UserLogIn_CreationDate] DEFAULT (GETDATE()),
	ModificationUser VARCHAR(200),
	ModificationDate DATETIME CONSTRAINT [DF_UserLogIn_ModificationDate] DEFAULT (GETDATE()),
	CONSTRAINT [FK_UserLogIn_RoleID] FOREIGN KEY (RoleID) REFERENCES Role(RoleID)
	
)
GO

create table Questions
(

	QuestionID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_Questions_QuestionID] PRIMARY KEY CLUSTERED,
	Question VARCHAR(200),
	Is_Active BIT NOT NULL CONSTRAINT [DF_questions_Is_Active] DEFAULT (1),
	CreationUser VARCHAR(200),
	CreationDate DATETIME CONSTRAINT [DF_questions_CreationDate] DEFAULT (GETDATE()),
	ModificationUser VARCHAR(200),
	ModificationDate DATETIME CONSTRAINT [DF_questions_ModificationDate] DEFAULT (GETDATE())
)

CREATE TABLE UserQuestions
(
	UserQuestionID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_UserQuestions_UserQuestionID] PRIMARY KEY CLUSTERED,
	UserLogInID INT,
	QuestionID INT,
	Answer VARCHAR(100),
	Is_Active BIT NOT NULL CONSTRAINT [DF_UserQuestions_Is_Active] DEFAULT (1),
	CreationUser VARCHAR(200),
	CreationDate DATETIME CONSTRAINT [DF_UserQuestions_CreationDate] DEFAULT (GETDATE()),
	ModificationUser VARCHAR(200),
	ModificationDate DATETIME CONSTRAINT [DF_UserQuestions_ModificationDate] DEFAULT (GETDATE()),
	CONSTRAINT [FK_UserQuestions_UserLogInID] FOREIGN KEY (UserLogInID) REFERENCES UserLogIn(UserLogInID),
	CONSTRAINT [FK_UserQuestions_QuestionID] FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID)


)
GO


------------------------------------------------------------------------------------- General Setup ----------------------------------------------------------------------------------------

CREATE TABLE [dbo].[GEN_CURRENCY](
	[ID] [INT] IDENTITY(1,1) NOT NULL,
	[CODE] [varchar](5) NOT NULL,
	[NAME] [varchar](50) NULL,
	[DESCRIPTION] [varchar](200) NULL,
	[IS_ACTIVE] [bit] NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL,
 CONSTRAINT [PK_GEN_CURRENCY_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[GEN_CURRENCY] ADD  CONSTRAINT [DF_GEN_CURRENCY_IS_ACTIVE]  DEFAULT ((1)) FOR [IS_ACTIVE]
GO

ALTER TABLE [dbo].[GEN_CURRENCY] ADD  CONSTRAINT [DF_GEN_CURRENCY_CREATION_DATE]  DEFAULT (getdate()) FOR [CREATION_DATE]
GO

ALTER TABLE [dbo].[GEN_CURRENCY] ADD  CONSTRAINT [DF_GEN_CURRENCY_MODIFICATION_DATE]  DEFAULT (getdate()) FOR [MODIFICATION_DATE]
GO




CREATE TABLE [dbo].[GEN_COUNTRY]
(
	[ID] [INT] IDENTITY(1,1) NOT NULL CONSTRAINT [PK_GEN_COUNTRY_ID] PRIMARY KEY CLUSTERED,
	[GEN_CURRENCY_XID] INT NULL,
	[CODE] [varchar](5) NOT NULL,
	[NAME] [varchar](50) NOT NULL,
	[DESCRIPTION] [varchar](200) NULL,
	[IS_ACTIVE] BIT NOT NULL CONSTRAINT [DF_GEN_COUNTRY_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_COUNTRY_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_COUNTRY_MODIFICATION_DATE] DEFAULT(GETDATE()),
	CONSTRAINT [FK_GEN_COUNTRY_GEN_CURRENCY_XID] FOREIGN KEY (GEN_CURRENCY_XID) REFERENCES GEN_CURRENCY(ID)
)
GO


CREATE TABLE [dbo].[GEN_TIMEZONE]
(
	[ID] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [PK_GEN_TIMEZONE_ID] PRIMARY KEY CLUSTERED,
	[CODE] [varchar](5) NOT NULL,
	[NAME] [varchar](50) NOT NULL,
	[DESCRIPTION] [varchar](200) NULL,
	[TIMEZONE_TIME_DIFF] [float] NOT NULL,
	[IS_ACTIVE] BIT NOT NULL CONSTRAINT [DF_GEN_TIMEZONE_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_TIMEZONE_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_TIMEZONE_MODIFICATION_DATE] DEFAULT(GETDATE())
)
GO


CREATE TABLE [dbo].[GEN_CITY]
(
	[ID] [INT] IDENTITY(1,1) NOT NULL CONSTRAINT [PK_GEN_CITY_ID] PRIMARY KEY CLUSTERED,
	[GEN_COUNTRY_XID] [INT] NULL,
	[GEN_CITY_TIMEZONE_XID] [int] NULL,
	[CODE] [varchar](5) NOT NULL,
	[NAME] [varchar](50) NOT NULL,
	[DESCRIPTION] [varchar](200) NULL,
	[IS_ACTIVE] BIT NOT NULL CONSTRAINT [DF_GEN_CITY_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_CITY_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_CITY_MODIFICATION_DATE] DEFAULT(GETDATE()),
	CONSTRAINT [FK_GEN_CITY_GEN_COUNTRY_XID] FOREIGN KEY (GEN_COUNTRY_XID) REFERENCES GEN_COUNTRY(ID),
	CONSTRAINT [FK_GEN_CITY_GEN_CITY_TIMEZONE_XID] FOREIGN KEY (GEN_CITY_TIMEZONE_XID) REFERENCES GEN_TIMEZONE(ID)
)
GO

CREATE TABLE [dbo].[GEN_AIRLINES]
(
	[ID] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [PK_GEN_AIRLINES_ID] PRIMARY KEY CLUSTERED,
	[NUM_CODE] [varchar](3) NOT NULL,
	[ALPHA_CODE] [varchar](8) NULL,
	[NAME] [varchar](50) NULL,
	[DESCRIPTION] [varchar](200) NULL,
	[IS_DOMESTIC] [char](1) NULL,
	[IS_AMADEUS_CARRIER] [char](1) NULL,
	[GDS_CODE] [varchar](2) NULL,
	[IS_ACTIVE] BIT NOT NULL CONSTRAINT [DF_GEN_AIRLINES_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_AIRLINES_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_AIRLINES_MODIFICATION_DATE] DEFAULT(GETDATE())

)
GO


CREATE TABLE GEN_FARE_TYPE
(
	ID INT IDENTITY(1,1) NOT NULL CONSTRAINT [PK_GEN_FARE_TYPE_ID] PRIMARY KEY CLUSTERED,
	NAME VARCHAR(50),
	[IS_ACTIVE] BIT NOT NULL CONSTRAINT [DF_GEN_FARE_TYPE_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_FARE_TYPE_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_FARE_TYPE_MODIFICATION_DATE] DEFAULT(GETDATE())

)
GO

CREATE TABLE GEN_AIRLINE_POINTING_OF_STAMPING_TYPE
(
	ID INT IDENTITY(1,1) NOT NULL CONSTRAINT [PK_GEN_AIRLINE_POINTING_OF_STAMPING_TYPE_ID] PRIMARY KEY CLUSTERED,
	POINT_OF_STAMPING VARCHAR(50),
	[IS_ACTIVE] BIT NOT NULL CONSTRAINT [DF_GEN_AIRLINE_POINTING_OF_STAMPING_TYPE_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_AIRLINE_POINTING_OF_STAMPING_TYPE_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_AIRLINE_POINTING_OF_STAMPING_TYPE_MODIFICATION_DATE] DEFAULT(GETDATE())

)
GO


CREATE TABLE GEN_AIRLINE_STAMPING_TYPE
(
	ID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_GEN_AIRLINE_STAMPING_TYPE_ID] PRIMARY KEY CLUSTERED,
	CODE VARCHAR(5),
	NAME VARCHAR(5),
	[IS_ACTIVE] BIT NOT NULL CONSTRAINT [DF_GEN_AIRLINE_STAMPING_TYPE_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_AIRLINE_STAMPING_TYPE_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_AIRLINE_STAMPING_TYPE_MODIFICATION_DATE] DEFAULT(GETDATE())
)
GO


CREATE TABLE GEN_ASSETS
(
	ID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_GEN_ASSETS_ID] PRIMARY KEY CLUSTERED,
	NAME VARCHAR(50),
	[IS_ACTIVE] BIT NOT NULL CONSTRAINT [DF_GEN_ASSETS_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_ASSETS_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_ASSETS_MODIFICATION_DATE] DEFAULT(GETDATE())

)



CREATE TABLE [dbo].[GEN_AIRLINE_STAMPING_FORMAT]
(
	[ID] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [PK_GEN_AIRLINE_STAMPING_FORMAT_ID] PRIMARY KEY CLUSTERED,
	[GEN_FARE_TYPE_XID] [int] NULL,
	[GEN_AIRLINES_XID] [int] NULL,
	[GEN_AIRLINE_STAMPING_TYPE_XID] INT NULL,
	[GEN_AIRLINE_POINTING_OF_STAMPING_TYPE_XID] [int] NULL,
	[FORMAT] [varchar](200) NULL,
	[IS_OVERRIDE] BIT NOT NULL,
	[IS_ACTIVE] BIT NOT NULL CONSTRAINT [DF_GEN_AIRLINE_STAMPING_FORMAT_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL CONSTRAINT [DF_GEN_AIRLINE_STAMPING_FORMAT_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL ,
	[MODIFICATION_DATE] [datetime] NULL CONSTRAINT [DF_GEN_AIRLINE_STAMPING_FORMAT_MODIFICATION_DATE] DEFAULT(GETDATE()),
	CONSTRAINT [FK_GEN_AIRLINE_STAMPING_FORMAT_GEN_FARE_TYPE_XID] FOREIGN KEY (GEN_FARE_TYPE_XID) REFERENCES GEN_FARE_TYPE(ID),
	CONSTRAINT [FK_GEN_AIRLINE_STAMPING_FORMAT_GEN_AIRLINES_XID] FOREIGN KEY (GEN_AIRLINES_XID) REFERENCES GEN_AIRLINES(ID),
	CONSTRAINT [FK_GEN_AIRLINE_STAMPING_FORMAT_GEN_AIRLINE_POINTING_OF_STAMPING_TYPE_XID] FOREIGN KEY (GEN_AIRLINE_POINTING_OF_STAMPING_TYPE_XID) REFERENCES GEN_AIRLINE_POINTING_OF_STAMPING_TYPE(ID),
	CONSTRAINT [FK_GEN_AIRLINE_STAMPING_FORMAT_GEN_AIRLINE_STAMPING_TYPE_XID] FOREIGN KEY (GEN_AIRLINE_STAMPING_TYPE_XID) REFERENCES GEN_AIRLINE_STAMPING_TYPE(ID)

	
)
GO


CREATE TABLE [dbo].[GEN_ASSET_STAMPING_FORMAT]
(
	[ID] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [PK_GEN_ASSET_STAMPING_FORMAT_ID] PRIMARY KEY CLUSTERED,
	[GEN_FARE_TYPE_XID] [int] NULL,
	[GEN_ASSETS_XID] [int] NULL,
	[GEN_AIRLINES_XID] [int] NULL,
	[GEN_AIRLINE_STAMPING_TYPE_XID] [int] NULL,
	[GEN_AIRLINE_POINTING_OF_STAMPING_TYPE_XID] [int] NULL,
	[FORMAT] [varchar](200) NULL,
	[IS_OVERRIDE] [char](1) NOT NULL,
	Is_Active BIT NOT NULL CONSTRAINT [DF_GEN_ASSET_STAMPING_FORMAT_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL CONSTRAINT [DF_GEN_ASSET_STAMPING_FORMAT_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL CONSTRAINT [DF_GEN_ASSET_STAMPING_FORMAT_MODIFICATION_DATE] DEFAULT(GETDATE()),
	CONSTRAINT [FK_GEN_ASSET_STAMPING_FORMAT_GEN_FARE_TYPE_XID] FOREIGN KEY (GEN_FARE_TYPE_XID) REFERENCES GEN_FARE_TYPE(ID),
	CONSTRAINT [FK_GEN_ASSET_STAMPING_FORMAT_GEN_ASSETS_XID] FOREIGN KEY (GEN_ASSETS_XID) REFERENCES GEN_ASSETS (ID),
	CONSTRAINT [FK_GEN_ASSET_STAMPING_FORMAT_GEN_AIRLINES_XID] FOREIGN KEY (GEN_AIRLINES_XID) REFERENCES GEN_AIRLINES (ID),
	CONSTRAINT [FK_GEN_ASSET_STAMPING_FORMAT_GEN_AIRLINE_STAMPING_TYPE_XID] FOREIGN KEY (GEN_AIRLINE_STAMPING_TYPE_XID) REFERENCES GEN_AIRLINE_STAMPING_TYPE (ID),
	CONSTRAINT [FK_GEN_ASSET_STAMPING_FORMAT_GEN_AIRLINE_POINTING_OF_STAMPING_TYPE_XID] FOREIGN KEY (GEN_AIRLINE_POINTING_OF_STAMPING_TYPE_XID) REFERENCES GEN_AIRLINE_POINTING_OF_STAMPING_TYPE (ID)

)

GO

CREATE TABLE PRIORITY_TYPE
(
	ID INT IDENTITY(1,1) NOT NULL CONSTRAINT [PK_PRIORITY_TYPE_ID] PRIMARY KEY CLUSTERED,
	PRIORITY_TYPE VARCHAR(50),
	IS_ACTIVE BIT NOT NULL CONSTRAINT [DF_PRIORITY_TYPE_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL CONSTRAINT [DF_PRIORITY_TYPE_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL CONSTRAINT [DF_PRIORITY_TYPE_MODIFICATION_DATE] DEFAULT(GETDATE())
)
GO

CREATE TABLE [dbo].[GEN_AIRLINE_NOTES]
(
	[ID] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [PK_GEN_AIRLINE_NOTES_ID] PRIMARY KEY CLUSTERED,
	[GEN_FARE_TYPE_XID] [int] NOT NULL,
	[GEN_AIRLINES_XID] [int] NOT NULL,
	[ADD_AIRLINE_NOTES] [varchar](500) NULL,
	[VALID_FROM_DATE] [datetime] NULL,
	[VALID_TO_DATE] [datetime] NULL,
	[PRIORITY_TYPE_XID] [int] NULL,
	[IS_ACTIVE] BIT NOT NULL  CONSTRAINT [DF_GEN_AIRLINE_NOTES_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL CONSTRAINT [DF_GEN_AIRLINE_NOTES_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL CONSTRAINT [DF_GEN_AIRLINE_NOTES_MODIFICATION_DATE] DEFAULT(GETDATE()),
	CONSTRAINT [FK_GEN_AIRLINE_NOTES_GEN_FARE_TYPE_XID] FOREIGN KEY (GEN_FARE_TYPE_XID) REFERENCES GEN_FARE_TYPE(ID),
	CONSTRAINT [FK_GEN_AIRLINE_NOTES_GEN_AIRLINES_XID] FOREIGN KEY (GEN_AIRLINES_XID) REFERENCES GEN_AIRLINES (ID),
	CONSTRAINT [FK_GEN_AIRLINE_NOTES_PRIORITY_TYPE_XID] FOREIGN KEY (PRIORITY_TYPE_XID) REFERENCES PRIORITY_TYPE (ID)
)

GO

CREATE TABLE [dbo].[GEN_AIRPORT]
(
	[ID] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [PK_GEN_AIRPORT_ID] PRIMARY KEY CLUSTERED,
	[GEN_CITY_XID] [int] NOT NULL,
	[CODE] [varchar](5) NOT NULL,
	[NAME] [varchar](250) NOT NULL,
	[GMT_OFFSET] [float] NULL,
	[LATITUDE_DEG] [float] NULL,
	[LATITUDE_MIN] [float] NULL,
	[LATITUDE_SEC] [float] NULL,
	[LONGITUDE_DEG] [float] NULL,
	[LONGITUDE_MIN] [float] NULL,
	[LONGITUDE_SEC] [float] NULL,
	[STATUS] VARCHAR(50) NULL,
	[IS_ACTIVE] BIT NOT NULL CONSTRAINT [DF_GEN_AIRPORT_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_AIRPORT_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_AIRPORT_MODIFICATION_DATE] DEFAULT(GETDATE()),
	CONSTRAINT [FK_GEN_AIRPORT_GEN_CITY_XID] FOREIGN KEY (GEN_CITY_XID) REFERENCES GEN_CITY(ID)
)
GO


CREATE TABLE [dbo].[GEN_REFERENCE_HEADING]
(
	[ID] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [PK_GEN_REFERENCE_HEADING_ID] PRIMARY KEY CLUSTERED,
	[HEADING] [varchar](100) NOT NULL,
	[DESCRIPTION] [varchar](200) NULL,
	[IS_ACTIVE] BIT NOT NULL CONSTRAINT [DF_GEN_REFERENCE_HEADING_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_REFERENCE_HEADING_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_REFERENCE_HEADING_MODIFICATION_DATE] DEFAULT(GETDATE())
)

GO


CREATE TABLE [dbo].[GEN_GDS_REFERENCE_HEADING_BO_ENTRY]
(   [ID] INT IDENTITY(1,1) NOT NULL CONSTRAINT [PK_GEN_GDS_REFERENCE_HEADING_BO_ENTRY_ID] PRIMARY KEY CLUSTERED,
 	[GEN_REFERENCE_HEADING_XID] [int] NOT NULL,
    [Stamping_Mode] VARCHAR(200),
	[GDS_NAME_LIBRARY_XID] [INT] NOT NULL,
	[BO_ENTRY] [varchar](100) NOT NULL,
	[IS_ACTIVE] BIT NOT NULL CONSTRAINT [DF_GEN_GDS_REFERENCE_HEADING_BO_ENTRY_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_GDS_REFERENCE_HEADING_BO_ENTRY_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_GDS_REFERENCE_HEADING_BO_ENTRY_MODIFICATION_DATE] DEFAULT(GETDATE()),
	CONSTRAINT [FK_GEN_GDS_REFERENCE_HEADING_BO_ENTRY_GEN_REFERENCE_HEADING_XID] FOREIGN KEY(GEN_REFERENCE_HEADING_XID) REFERENCES GEN_REFERENCE_HEADING(ID)
)
GO



CREATE TABLE [dbo].[GEN_USER_GROUP]
(
	[ID] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [PK_GEN_USER_GROUP_ID] PRIMARY KEY CLUSTERED,
	[CODE] [varchar](5) NOT NULL,
	[NAME] [varchar](50) NOT NULL,
	[DESCRIPTION] [varchar](200) NULL,
	[IS_CUSTOMER] [char](1) NOT NULL,
	[IS_ACTIVE] BIT NOT NULL CONSTRAINT [DF_GEN_USER_GROUP_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_USER_GROUP_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_USER_GROUP_MODIFICATION_DATE] DEFAULT(GETDATE())
)
GO


CREATE TABLE [dbo].[GEN_ALLIANCE_AIRLINE]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GEN_AIRLINE_XID] [int] NOT NULL,
	Air_Alliance VARCHAR(100),
	Is_Active BIT NOT NULL CONSTRAINT [DF_GEN_ALLIANCE_AIRLINE_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_ALLIANCE_AIRLINE_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_ALLIANCE_AIRLINE_MODIFICATION_DATE] DEFAULT(GETDATE()),
	CONSTRAINT [FK_GEN_ALLIANCE_AIRLINE_GEN_AIRLINE_XID] FOREIGN KEY (GEN_AIRLINE_XID) REFERENCES GEN_AIRLINES(ID)
)
GO


CREATE TABLE [dbo].[GEN_USER_RIGHTS]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CODE] [varchar](5) NOT NULL,
	[NAME] [varchar](50) NOT NULL,
	[DESCRIPTION] [varchar](200) NOT NULL,
	[IS_ACTIVE] BIT NOT NULL CONSTRAINT [DF_GEN_USER_RIGHTS_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_USER_RIGHTS_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_USER_RIGHTS_MODIFICATION_DATE] DEFAULT(GETDATE())
)
GO

CREATE TABLE [dbo].[GEN_ALERT_SETTINGS]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MODULE] [varchar](200) NULL,
	[FUNCTIONALITY] [varchar](200) NULL,
	[IS_ALERT_REQUIRED] [char](1) NULL,
	[IS_ACTIVE] BIT NULL CONSTRAINT [DF_GEN_ALERT_SETTINGS_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL CONSTRAINT [DF_GEN_ALERT_SETTINGS_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL CONSTRAINT [DF_GEN_ALERT_SETTINGS_MODIFICATION_DATE] DEFAULT(GETDATE())
)
GO


CREATE TABLE PRODUCT_TYPE
(
	ID INT IDENTITY(1,1) NOT NULL CONSTRAINT [PK_PRODUCT_TYPE_ID] PRIMARY KEY CLUSTERED,
	NAME VARCHAR(30),
	CODE VARCHAR(10),
	[IS_ACTIVE] BIT NULL CONSTRAINT [DF_PRODUCT_TYPE_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL CONSTRAINT [DF_PRODUCT_TYPE_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL CONSTRAINT [DF_PRODUCT_TYPE_MODIFICATION_DATE] DEFAULT(GETDATE())
)
GO

CREATE TABLE [dbo].[GEN_PRODUCT_CODE]
(
	[ID] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [PK_GEN_PRODUCT_CODE_ID] PRIMARY KEY CLUSTERED,
	[PRODUCT_TYPE_XID] [int] NULL,
	[CODE] [varchar](10) NULL,
	[NAME] [varchar](100) NULL,
	[DESCRIPTION] [varchar](100) NULL,
	[ISACTIVE] BIT NULL CONSTRAINT [DF_GEN_PRODUCT_CODE_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL CONSTRAINT [DF_GEN_PRODUCT_CODE_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL CONSTRAINT [DF_GEN_PRODUCT_CODE_MODIFICATION_DATE] DEFAULT(GETDATE()),
	CONSTRAINT [FK_GEN_PRODUCT_CODE_PRODUCT_TYPE_XID] FOREIGN KEY (PRODUCT_TYPE_XID) REFERENCES PRODUCT_TYPE(ID)
)
GO

------------------------------------------------------------------------------------ Office Setup ----------------------------------------------------------------------

CREATE TABLE [dbo].[GEN_REGION]
(
	[ID] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [PK_GEN_REGION] PRIMARY KEY CLUSTERED,
	[REGION_CODE] [varchar](50) NOT NULL,
	[REGION_NAME] [varchar](50) NOT NULL,
	[DESCRIPTION] VARCHAR(500) NOT NULL,
	[Is_Flight_Delay_Info] BIT,
	[Is_IATA_Travel_Documentation_Advice] BIT,
	[Is_DownSell_Benefit_Setup] BIT,
	[ISACTIVE] BIT NULL CONSTRAINT [DF_GEN_REGION_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NOT NULL,
	[CREATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_REGION_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NOT NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_REGION_MODIFICATION_DATE] DEFAULT(GETDATE())
)
GO


CREATE TABLE GEN_OFFICE
(
	ID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_GEN_OFFICE_ID] PRIMARY KEY CLUSTERED,
	OFFICE_CODE VARCHAR(10),
	OFFICE_NAME VARCHAR(50),
	REGION VARCHAR(10),
	IS_SERVICED_BY_GSC BIT,
	ADDRESSLINE1 VARCHAR(200),
	ADDRESSLINE2 VARCHAR(200),
	COUNTRY VARCHAR(20),
	CITY VARCHAR(20),
	ZIPCODE VARCHAR(10),
	FAX VARCHAR(10),
	PHONE1 VARCHAR(15),
	PHONE2 VARCHAR(15),
	EMAIL VARCHAR(50),
	CURRENCY1 VARCHAR(10),
	CURRENCY2 VARCHAR(10),
	MID_OFFICE_CODE VARCHAR(10),
	AIRLINES VARCHAR(20),
	PCC_LOCATION VARCHAR(20),
	VOLARO_LOCATION VARCHAR(20),
	VOLARO_AGENT VARCHAR(20),
	ADDITIONAL_PCC_LOCATION VARCHAR(20),
	BACK_OFFICE VARCHAR(10),
	IS_AUTO_MODE BIT,
	IS_SEMI_AUTO_MODE BIT,
	IS_MANUAL_MODE BIT,
	GDS_PREFERENCE VARCHAR(20),
	[ISACTIVE] BIT NULL CONSTRAINT [DF_GEN_OFFICE_IS_ACTIVE] DEFAULT (1),
	[CREATION_USER] [varchar](50) NOT NULL,
	[CREATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_OFFICE_CREATION_DATE] DEFAULT(GETDATE()),
	[MODIFICATION_USER] [varchar](50) NOT NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL CONSTRAINT [DF_GEN_OFFICE_MODIFICATION_DATE] DEFAULT(GETDATE())
)	
GO


CREATE  TABLE Back_Office
(
	ID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_Back_Office_ID] PRIMARY KEY CLUSTERED,
	Name VARCHAR(20),
	Code VARCHAR(5),
	[IS_ACTIVE] BIT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL
)
GO

CREATE TABLE GST_Fee_Type
(
	ID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_GST_Fee_Type_ID] PRIMARY KEY CLUSTERED,
	GST_Fee_Type_Name NVARCHAR(20),
	GST_Fee_Type_Code VARCHAR(5),
	[IS_ACTIVE] BIT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL

)
GO


CREATE TABLE [dbo].[GO_BRANCH]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GEN_OFFICE_XID] [int] NULL,
	[BRANCH_NAME] VARCHAR(50),
	[GEN_CITY_XID] [int] NULL,
	[GEN_COUNTRY_XID] [int] NULL,
	[CODE] [varchar](50) NULL,
	[NAME] [varchar](100) NULL,
	[ADDRESS1] [varchar](4000) NULL,
	[CONTACT_PERSON] [varchar](50) NULL,
	[TEL1] [varchar](30) NULL,
	[TEL2] [varchar](30) NULL,
	[FAX] [varchar](30) NULL,
	[E_MAIL] [varchar](50) NULL,
	[IATA_CODE] [varchar](100) NULL,
	[IATA_LOCATION_ID] [varchar](5) NULL,
	[PSUEDO_CODE] [varchar](50) NULL,
	[GEN_CURRENCY_XID] [INT] NULL,
	[PSUEDO_CODE1_XID] [INT] NULL,
	[BACK_OFFICE_XID] [INT] NULL,
	[IS_GST_APPLICABLE] [bit] NULL DEFAULT ((0)),
	[GST_FEE_TYPE_XID] [INT] NULL,
	[GST_PERCENTAGE] [int] NULL,
	Is_Active BIT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL

)

CREATE TABLE [dbo].[GO_CUST_HOLIDAY](
	[ID] [INT] IDENTITY(122,1) NOT NULL,
	[GO_BRANCH_XID] [INT] NULL,
	[DATE] [datetime] NULL,
	[DESCRIPTION] [varchar](100) NULL,
	Is_Active BIT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL,
)



CREATE TABLE [dbo].[GO_DEPARTMENT](
	[ID] [INT] IDENTITY(1,1) NOT NULL,
	[GO_BRANCH_XID] [INT] NULL,
	[CODE] [varchar](10) NULL,
	[NAME] [varchar](100) NULL,
	[DESCRIPTION] [varchar](250) NULL,
	Is_Active BIT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL
)
GO

CREATE TABLE [dbo].[GO_AGENT_TEAM](
	[ID] [INT] IDENTITY(1,1) NOT NULL,
	[GO_BRANCH_XID] [INT] NULL,
	[GO_DEPARTMENT_XID] [INT] NULL,
	[CODE] [varchar](10) NULL,
	[NAME] [varchar](100) NULL,
	[DESCRIPTION] [varchar](250) NULL,
	Is_Active BIT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL
)
GO

CREATE TABLE [dbo].[GO_JOB_TITLE](
	[ID] [INT] IDENTITY(1,1) NOT NULL,
	[GEN_OFFICE_XID] [INT] NULL,
	[CODE] [varchar](10) NULL,
	[NAME] [varchar](100) NOT NULL,
	[DESCRIPTION] [varchar](250) NULL,
	Is_Active BIT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL
)

CREATE TABLE Title
(
	ID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_Title_ID] PRIMARY KEY CLUSTERED,
	Title_Name VARCHAR(5),
	Is_Active BIT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL
)
GO


CREATE TABLE [dbo].[GO_EMPLOYEE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	Title_XID INT,
	[FIRST_NAME] [varchar](50) NOT NULL,
	[MIDDLE_NAME] [varchar](50) NULL,
	[LAST_NAME] [varchar](50) NOT NULL,
	Customer_Alias_Name VARCHAR(20),
	[User_ID] VARCHAR(20),
	Employee_No VARCHAR(10),
	Default_login_domain VARCHAR(30),
	EMail_1 VARCHAR(200),
	EMail_2 VARCHAR(200),
	[PHONE_NO] [varchar](15) NOT NULL,
	Extn_No VARCHAR(5),
	[FAX] [varchar](30) NOT NULL,
	[MOBILE_NO] [varchar](15) NOT NULL,
	Amadeus_Login_ID VARCHAR(20),
	Amadeus_Password VARCHAR(50),
	Duty_Code VARCHAR(5),
	Default_Queue VARCHAR(20),
	Default_Category VARCHAR(50),
	[VOIP_NO] [varchar](50) NULL,
	[AGM_SIGN_IN_ID] [varchar](50) NULL,
	[GALILEO_QUEUE_NO] [varchar](50) NULL,
	[VISTA_Login_ID] [varchar](20) NULL,
	[VISTA_CODE] [varchar](20) NULL,
	[Vista_Duty_Code] [varchar](20) NULL,
	[VISTA_PASSWORD] [varchar](100) NULL,
	[SHOW_MAP_IN_SEARCH_BOOKING_MGMT] [bit] NULL CONSTRAINT [DF_GO_EMPLOYEE_SHOW_MAP_IN_SEARCH_BOOKING_MGMT]  DEFAULT ((0)),
	[SHOW_CALENDAR_IN_SEARCH_BOOKING_MGMT] [bit] NULL CONSTRAINT [DF_GO_EMPLOYEE_SHOW_CALENDAR_IN_SEARCH_BOOKING_MGMT]  DEFAULT ((0)),
	Is_Active BIT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL
)





CREATE TABLE Employee_Rights_Security
(
	ID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_Employee_Rights_Security_ID] PRIMARY KEY CLUSTERED,
	Employee_ID INT,
	[GEN_USER_GROUP_XID] [INT] NULL,
	[AGM_SIGN_IN_ID] [varchar](50) NULL,
	[IS_USER_GROUP_RIGHTS_FLAG] [char](1) NULL CONSTRAINT [DF_Employee_Rights_Security_IS_USER_GROUP_RIGHTS_FLAG]  DEFAULT ('G'),
	GSC_Branch_XID INT,
	Agent_Team_XID INT,
	Service_Team_XID INT,
	Is_Active BIT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL

)

CREATE TABLE Employee_Office_Setup
(
	ID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_Employee_Office_Setup_ID] PRIMARY KEY CLUSTERED,
	Employee_ID INT,
	Country_XID INT,
	Region_XID INT,
	Office_XID INT,
	Branch_XID INT,
	Department_XID INT,
	Job_Title_XID INT,
	Customer_Service_Team_ID INT,
	Time_Zone_XID INT,
	Time_Zone_City_XID INT,
	Is_Active BIT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL

)

GO

CREATE TABLE [dbo].[GO_ROE](
	[ID] [INT] IDENTITY(1,1) NOT NULL,
	[GEN_OFFICE_XID] [INT] NULL,
	[FROM_DATE] [datetime] NULL,
	[TO_DATE] [datetime] NULL,
	[GEN_CURRENCY_FROM_XID] [varchar](5) NULL,
	[GEN_CURRENCY_TO_XID] [varchar](5) NULL,
	[ROE_VALUES] [varchar](50) NULL,
	Is_Active BIT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL
)


CREATE TABLE [dbo].[GO_AIRLINE_BRANCH_CONTRACT]
(
	[ID] [INT] NOT NULL IDENTITY(1,1) ,
	[PUBLISHED_CODES] [varchar](300) NULL,
	[OFFSHORE_CODES] [varchar](300) NULL,
	[ENERGY_CODES] [varchar](300) NULL,
	[MARINE_CODES] [varchar](300) NULL,
	[AIRSEA_CODES] [varchar](300) NULL,
	[GEN_AIRLINES_XID] [INT] NULL,
	[GO_BRANCH_XID] [INT] NULL,
	[EFFECTIVE_START_DATE] [datetime] NULL,
	[EFFECTIVE_END_DATE] [datetime] NULL,
	Is_Active BIT NOT NULL CONSTRAINT [DF_GO_AIRLINE_BRANCH_CONTRACT_Is_Active]  DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL
)
GO

CREATE TABLE Office_Region
(
	ID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_Office_Region_ID] PRIMARY KEY CLUSTERED,
	GEN_REGION_XID INT,
	GEN_Office_XID INT,
	GEN_Country_XID INT,
	Region_Type VARCHAR(10),
	Is_Active BIT NOT NULL CONSTRAINT [DF_Office_Region_Is_Active]  DEFAULT (1),
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NULL
)		


------------------------------------------------------------------------------------------- Customer Setup --------------------------------------------------------



CREATE TABLE [dbo].[CUST_COMPANY]
(
	[ID] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [PK_CUST_COMPANY_ID] PRIMARY KEY CLUSTERED,
	[GEN_CITY_XID] [int] NULL,
	[GEN_COUNTRY_XID] [int] NOT NULL,
	[CUST_NAME] [varchar](200) NOT NULL,
	[Short_Name] [varchar](100) NULL,
	[PIN] [varchar](25) NULL,
	[ADDRESS1] [varchar](4000) NULL,
	[ADDRESS2] [varchar](4000) NULL,
	[PHONE] [varchar](30) NULL,
	[PHONE1] [varchar](30) NULL,
	[CELL] [varchar](30) NULL,
	[FAX] [varchar](30) NULL,
	[E_MAIL] [varchar](50) NULL,
	[WEB_SITE] [varchar](100) NULL,
	[DEFAULT_CURRENCY] [varchar](50) NULL,
	Reporting_Currency [varchar](50) NULL,
	Customer_Type [varchar](10) ,
	Primary_Branch [varchar](50) ,
	[DATE_FORMAT] [varchar](25) NULL,
	[BAR_ID] [varchar](100) NULL,
	Vessel_PAR_Prefix varchar(100),
	Is_Active BIT NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL

)

CREATE TABLE [dbo].[CUST_COMPANY_ACCOUNT_NUMBER_MAPPING]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CUST_COMPANY_XID] [bigint] NULL,
	[ACCOUNT_NUMBER] [varchar](50) NULL,
	Is_Active BIT NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL
)
GO



CREATE TABLE Cust_Business_Type
(
	ID INT,
	CUST_COMPANY_XID INT,
	Business_Type VARCHAR(20),
	Is_Active BIT NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL

)
GO

CREATE TABLE Cust_Griffin_Branchs
(
	ID INT,
	CUST_COMPANY_XID INT,
	Griffin_Branch VARCHAR(30),
	Is_Active BIT NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL

)
GO


CREATE TABLE CUST_LOCATION
(
	ID INT,
	CUST_COMPANY_XID INT,
	AddressLine_1 VARCHAR(100),
	AddressLine_2 VARCHAR(100),
    Important_Notes VARCHAR(200),
	Country_XID INT,
	City_XID INT,
	State_XID INT,
	Zip_code VARCHAR(10),
	Is_Active BIT NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL

)
GO


CREATE TABLE Cust_Billing_Address
(
	ID INT,
	CUST_COMPANY_XID INT,
	AddressLine_1 VARCHAR(100),
	AddressLine_2 VARCHAR(100),
	Country_XID INT,
	City_XID INT,
	State_XID INT,
	Zip_code VARCHAR(10),
	Is_Active BIT NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL

)
GO


CREATE TABLE Cust_Contact_Information
(
	ID INT,
	CUST_COMPANY_XID INT,
	Title VARCHAR(5),
	Contact_Person VARCHAR(20),
	Email VARCHAR(100),
	Website VARCHAR(200),
	Mobile VARCHAR(15),
	Phone1 VARCHAR(15),
	Phone2 VARCHAR(15),
	Fax VARCHAR(15),
	Is_Active BIT NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL
)
GO


CREATE TABLE Cust_Out_Of_Office_Hours
(
	ID INT,
	CUST_COMPANY_XID INT,
	Booking_Products VARCHAR(20),
	Primary_Branch VARCHAR(20),
	Secondary_Branch VARCHAR(20),	
	Is_Active BIT NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL
)
GO


CREATE TABLE Cust_Travel_Type
(
	ID INT,
	CUST_COMPANY_XID INT,
	Travel_Type_Code VARCHAR(10),
	Travel_Type_Name VARCHAR(20),
	[Description] VARCHAR(100),
	Is_Global BIT,
	Is_Active BIT NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL

)
GO

CREATE TABLE Cust_Passenger_Type
(
	ID INT,
	CUST_COMPANY_XID INT,
	Passenger_Type_Code VARCHAR(10),
	Passenger_Type_Name VARCHAR(50),
	Description VARCHAR(100),
	Passenger_Type_Mode VARCHAR(10),
	Is_Global BIT,
	Is_Active BIT NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL

)
GO

CREATE TABLE Cust_Passenger_User
(
	ID INT,
	CUST_COMPANY_XID INT,
	Cust_Passenger_Type_XID INT,
	Customer_User VARCHAR(20),
	Is_Active BIT NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL


)
GO


CREATE TABLE Cust_Rank
(
	ID INT,
	CUST_COMPANY_XID INT,
	Rank_Code VARCHAR(10),
	Rank_Name VARCHAR(50),
	Description VARCHAR(100),
	Is_Global BIT,
	Is_Active BIT NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL

)
GO

CREATE TABLE Cust_Salary_Grade
(
	ID INT,
	CUST_COMPANY_XID INT,
	Salary_Grade_Code VARCHAR(10),
	Salary_Grade_Name VARCHAR(50),
	Description VARCHAR(100),
	Is_Global BIT,
	Is_Active BIT NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL

)
GO


CREATE TABLE Agent
(
	ID INT IDENTITY(1,1) CONSTRAINT [PK_Agent_ID] PRIMARY KEY CLUSTERED,
	Cust_Company_XID INT,
	Country_XID INT,
	City_XID INT,
	First_Name VARCHAR(50),
	Middle_Name VARCHAR(50),
	Last_Name VARCHAR(50),
	Agent_Company_Name VARCHAR(50),
	Mobile_No VARCHAR(15),
	Telephone_No VARCHAR(15),
	Fax VARCHAR(20),
	Agent_Company_Address VARCHAR(500),
	Agent_Company_Pin VARCHAR(10),
	Email VARCHAR(200),
	Is_Active BIT NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL

)
GO


CREATE TABLE Cust_Port_Agent
(
	ID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_Cust_Port_Agent_ID] PRIMARY KEY CLUSTERED,
	Agent_XID INT,
	Airport_XID INT,
	Nearest_Airport VARCHAR(20),
	Port_Country_XID INT,
	Port_City_XID INT,
	Is_Active BIT NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL

)
GO



CREATE TABLE Nationality
(
	ID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_Nationality_ID] PRIMARY KEY CLUSTERED,
	Country_XID INT,
	Nationality_Name VARCHAR(25),
	Nationality_Code VARCHAR(10),
	Is_Active BIT NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL


)
GO



CREATE TABLE Cust_Booking_Group
(
	ID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_Cust_Booking_Group_ID] PRIMARY KEY CLUSTERED,
	Cust_Company_XID INT,
	Booking_Group_Name VARCHAR(50),
	CUST_LOCATION_XID INT,
	Currency_XID INT,
	Nationality_XID INT,

)

GO

CREATE TABLE Division_Type
(
	ID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_Division_Type_ID] PRIMARY KEY CLUSTERED,
	Division_Type_Name VARCHAR(40),
	Division_Type_Code VARCHAR(20),
	Is_Active BIT NOT NULL,
	[CREATION_USER] [varchar](50) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[MODIFICATION_USER] [varchar](50) NULL,
	[MODIFICATION_DATE] [datetime] NOT NULL
) 
GO

CREATE TABLE Division
(
	ID INT NOT NULL IDENTITY(1,1) CONSTRAINT [PK_Division_ID] PRIMARY KEY CLUSTERED,
	Division_Name VARCHAR(25),
	Description VARCHAR(50),
	Country_XID INT,
	CURRENCY_XID INT,
	Division_Type_XID INT,
	Customers_Department_Office VARCHAR(30),
	Email_ID VARCHAR(200),
	[BAR_STAMPING_APPLICABLE] [bit],
	[PAR_STAMPING_APPLICABLE] [bit],
	[VESSEL_PAR_STAMPING_APPLICABLE] [bit],
	[RANK_STAMP_APPLICABLE] [bit],
	[BAR_ID] [varchar](100) NULL,
	[VESSEL_PAR_PREFIX] [varchar](10) NULL,
    [PRIMARY_BRANCH_XID] INT,
	[SECONDARY_BRANCH_XID] INT,
)
