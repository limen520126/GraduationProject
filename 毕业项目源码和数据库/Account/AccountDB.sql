USE [master]
GO
/****** Object:  Database [AccountDB]    Script Date: 2020/5/16 15:58:03 ******/
CREATE DATABASE [AccountDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AccountDB', FILENAME = N'G:\DB\AccountDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AccountDB_log', FILENAME = N'G:\DB\AccountDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [AccountDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AccountDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AccountDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AccountDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AccountDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AccountDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AccountDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [AccountDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AccountDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [AccountDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AccountDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AccountDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AccountDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AccountDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AccountDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AccountDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AccountDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AccountDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AccountDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AccountDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AccountDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AccountDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AccountDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AccountDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AccountDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AccountDB] SET RECOVERY FULL 
GO
ALTER DATABASE [AccountDB] SET  MULTI_USER 
GO
ALTER DATABASE [AccountDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AccountDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AccountDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AccountDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
USE [AccountDB]
GO
/****** Object:  Table [dbo].[Answer]    Script Date: 2020/5/16 15:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answer](
	[AnswerID] [int] IDENTITY(1,1) NOT NULL,
	[PaperID] [int] NOT NULL,
	[StuID] [int] NOT NULL,
	[TeacherID] [int] NULL,
	[AnswerScore] [int] NULL,
	[AnswerTime] [datetime] NULL,
	[SubmitTime] [datetime] NULL,
	[BatchTime] [datetime] NULL,
	[AnswerState] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AnswerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Departments]    Script Date: 2020/5/16 15:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Remark] [nvarchar](200) NULL,
 CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Detail]    Script Date: 2020/5/16 15:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detail](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[AnswerID] [int] NOT NULL,
	[TopicID] [int] NOT NULL,
	[DetailAnswer] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Menus]    Script Date: 2020/5/16 15:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Url] [nvarchar](50) NULL,
	[Remark] [nvarchar](50) NULL,
	[Pid] [int] NULL,
 CONSTRAINT [PK_Menus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Paper]    Script Date: 2020/5/16 15:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paper](
	[PaperID] [int] IDENTITY(1,1) NOT NULL,
	[PaperName] [nvarchar](20) NOT NULL,
	[PaperExplain] [nvarchar](100) NOT NULL,
	[PaperTime] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PaperID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[R_Role_Menus]    Script Date: 2020/5/16 15:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_Role_Menus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NULL,
	[MenuID] [int] NULL,
 CONSTRAINT [PK_R_Role_Menus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[R_User_Roles]    Script Date: 2020/5/16 15:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_User_Roles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[RoleID] [int] NULL,
 CONSTRAINT [PK_R_User_Roles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 2020/5/16 15:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Remark] [nvarchar](50) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Student]    Script Date: 2020/5/16 15:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[StuID] [int] IDENTITY(1,1) NOT NULL,
	[StuName] [nvarchar](20) NOT NULL,
	[StuLoginName] [nvarchar](20) NOT NULL,
	[StuLoginPwd] [nvarchar](20) NOT NULL,
	[StuSex] [bit] NOT NULL,
	[StuPhone] [nvarchar](20) NULL,
	[StuEmail] [nvarchar](50) NULL,
	[StuGrade] [nvarchar](50) NULL,
	[UserID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 2020/5/16 15:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teacher](
	[TeacherID] [int] IDENTITY(1,1) NOT NULL,
	[TeacherName] [nvarchar](20) NOT NULL,
	[TeacherLoginName] [nvarchar](20) NOT NULL,
	[TeacherLoginPwd] [nvarchar](20) NOT NULL,
	[TeacherPhone] [nvarchar](20) NULL,
	[TeacherEmail] [nvarchar](50) NULL,
	[UserID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TeacherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Topic]    Script Date: 2020/5/16 15:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Topic](
	[TopicID] [int] IDENTITY(1,1) NOT NULL,
	[TopicExplain] [nvarchar](200) NOT NULL,
	[TopicScore] [int] NOT NULL,
	[TopicType] [int] NOT NULL,
	[TopicA] [nvarchar](100) NULL,
	[TopicB] [nvarchar](100) NULL,
	[TopicC] [nvarchar](100) NULL,
	[TopicD] [nvarchar](100) NULL,
	[TopicSort] [int] NOT NULL,
	[TopicAnswer] [nvarchar](200) NOT NULL,
	[PaperID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TopicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserInfos]    Script Date: 2020/5/16 15:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfos](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentID] [int] NULL,
	[Account] [nvarchar](50) NULL,
	[Pwd] [nvarchar](50) NULL,
 CONSTRAINT [PK_UserInfos] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[v_menuByUser]    Script Date: 2020/5/16 15:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_menuByUser]
as
select distinct rur.UserID,m.ID,m.Name,m.Remark,m.Url,m.Pid
 from R_User_Roles rur,R_Role_Menus rrm,Menus m
where rur.RoleID= rrm.RoleID and rrm.MenuID = m.ID
GO
/****** Object:  View [dbo].[v_user_menus]    Script Date: 2020/5/16 15:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_user_menus]
AS
SELECT DISTINCT rur.UserID, m.ID, m.Name, m.Url, m.Remark, m.Pid, dbo.Roles.Name AS rName
FROM      dbo.Roles INNER JOIN
                dbo.R_User_Roles AS rur ON dbo.Roles.ID = rur.RoleID INNER JOIN
                dbo.Menus AS m INNER JOIN
                dbo.R_Role_Menus AS rrm ON m.ID = rrm.MenuID ON dbo.Roles.ID = rrm.RoleID

GO
/****** Object:  View [dbo].[v_User_Role_Menu]    Script Date: 2020/5/16 15:58:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create View [dbo].[v_User_Role_Menu]
as
select rur.UserID,m.ID,m.Url,m.Name,m.Remark,m.Pid 
from R_User_Roles rur,R_Role_Menus rrm,Menus m
where rur.RoleID =  rrm.RoleID and rrm.MenuID = m.ID

GO
SET IDENTITY_INSERT [dbo].[Answer] ON 

INSERT [dbo].[Answer] ([AnswerID], [PaperID], [StuID], [TeacherID], [AnswerScore], [AnswerTime], [SubmitTime], [BatchTime], [AnswerState]) VALUES (2015, 1, 1008, 1, 75, CAST(0x0000ABA400C09683 AS DateTime), CAST(0x0000ABA400C98251 AS DateTime), CAST(0x0000ABA400C9EF0A AS DateTime), 2)
INSERT [dbo].[Answer] ([AnswerID], [PaperID], [StuID], [TeacherID], [AnswerScore], [AnswerTime], [SubmitTime], [BatchTime], [AnswerState]) VALUES (2016, 10, 1008, 1, 25, CAST(0x0000ABA400DEA0A3 AS DateTime), CAST(0x0000ABA40119DB05 AS DateTime), CAST(0x0000ABA500C7A337 AS DateTime), 2)
INSERT [dbo].[Answer] ([AnswerID], [PaperID], [StuID], [TeacherID], [AnswerScore], [AnswerTime], [SubmitTime], [BatchTime], [AnswerState]) VALUES (2017, 1, 7, 1, 0, CAST(0x0000ABA50095317E AS DateTime), CAST(0x0000ABA500B4853A AS DateTime), NULL, 1)
INSERT [dbo].[Answer] ([AnswerID], [PaperID], [StuID], [TeacherID], [AnswerScore], [AnswerTime], [SubmitTime], [BatchTime], [AnswerState]) VALUES (2018, 2, 1008, 1, 0, CAST(0x0000ABA500B58551 AS DateTime), CAST(0x0000ABA500B59DFA AS DateTime), NULL, 1)
INSERT [dbo].[Answer] ([AnswerID], [PaperID], [StuID], [TeacherID], [AnswerScore], [AnswerTime], [SubmitTime], [BatchTime], [AnswerState]) VALUES (2019, 9, 1008, 1, 0, CAST(0x0000ABA500B5A22C AS DateTime), CAST(0x0000ABA500B5BDA3 AS DateTime), NULL, 1)
INSERT [dbo].[Answer] ([AnswerID], [PaperID], [StuID], [TeacherID], [AnswerScore], [AnswerTime], [SubmitTime], [BatchTime], [AnswerState]) VALUES (2020, 10, 1, 1, 0, CAST(0x0000ABA500B65212 AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Answer] ([AnswerID], [PaperID], [StuID], [TeacherID], [AnswerScore], [AnswerTime], [SubmitTime], [BatchTime], [AnswerState]) VALUES (2021, 1, 1, 1, 0, CAST(0x0000ABA500F42591 AS DateTime), CAST(0x0000ABA500F45428 AS DateTime), NULL, 1)
INSERT [dbo].[Answer] ([AnswerID], [PaperID], [StuID], [TeacherID], [AnswerScore], [AnswerTime], [SubmitTime], [BatchTime], [AnswerState]) VALUES (2022, 8, 1008, 1, 0, CAST(0x0000ABA5010E10CD AS DateTime), CAST(0x0000ABA5010E1EC2 AS DateTime), NULL, 1)
INSERT [dbo].[Answer] ([AnswerID], [PaperID], [StuID], [TeacherID], [AnswerScore], [AnswerTime], [SubmitTime], [BatchTime], [AnswerState]) VALUES (3017, 3, 1008, 1, 0, CAST(0x0000ABB3009DB323 AS DateTime), CAST(0x0000ABB3009DDD7E AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[Answer] OFF
SET IDENTITY_INSERT [dbo].[Departments] ON 

INSERT [dbo].[Departments] ([ID], [Name], [Remark]) VALUES (1007, N'学术部', NULL)
INSERT [dbo].[Departments] ([ID], [Name], [Remark]) VALUES (1008, N'学工部', NULL)
INSERT [dbo].[Departments] ([ID], [Name], [Remark]) VALUES (1009, N'学生处', NULL)
SET IDENTITY_INSERT [dbo].[Departments] OFF
SET IDENTITY_INSERT [dbo].[Detail] ON 

INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2036, 2015, 1, N'B')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2037, 2015, 2, N'A')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2038, 2015, 3, N'')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2039, 2015, 4, N'ul  li')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2040, 2015, 9, N'A')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2041, 2015, 10, N'B')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2042, 2015, 11, N'B')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2043, 2015, 15, N'D')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2044, 2016, 27, N'C')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2045, 2016, 28, N'错误')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2046, 2016, 29, N'nnn')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2047, 2016, 30, N'B')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2048, 2017, 1, N'A')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2049, 2017, 2, N'A')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2050, 2017, 3, N'')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2051, 2017, 4, N'ul li')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2052, 2017, 9, N'A')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2053, 2017, 10, N'D')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2054, 2017, 11, N'D')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2055, 2017, 15, N'D')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2056, 2018, 5, N'A')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2057, 2018, 6, N'B')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2058, 2018, 7, N'')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2059, 2018, 8, N'1')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2060, 2019, 24, N'D')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2061, 2019, 25, N'正确')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2062, 2019, 26, N'模型控制器视图')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2063, 2020, 27, N'A')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2064, 2020, 28, N'正确')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2065, 2020, 29, N'123')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2066, 2020, 30, N'A')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2067, 2021, 1, N'A')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2068, 2021, 2, N'A')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2069, 2021, 3, N'')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2070, 2021, 4, N'ttyy')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2071, 2021, 9, N'A')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2072, 2021, 10, N'B')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2073, 2021, 11, N'D')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2074, 2021, 15, N'A')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2075, 2022, 16, N'B')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2076, 2022, 17, N'错误')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2077, 2022, 18, N'1')
INSERT [dbo].[Detail] ([DetailID], [AnswerID], [TopicID], [DetailAnswer]) VALUES (2078, 2022, 20, N'B')
SET IDENTITY_INSERT [dbo].[Detail] OFF
SET IDENTITY_INSERT [dbo].[Menus] ON 

INSERT [dbo].[Menus] ([ID], [Name], [Url], [Remark], [Pid]) VALUES (1015, N'部门管理', N'/Department/Index', N'部门信息', 1023)
INSERT [dbo].[Menus] ([ID], [Name], [Url], [Remark], [Pid]) VALUES (1016, N'用户管理', N'/User/Index', N'管理用户信息', 1023)
INSERT [dbo].[Menus] ([ID], [Name], [Url], [Remark], [Pid]) VALUES (1017, N'角色管理', N'/Role/Index', N'角色信息管理', 1022)
INSERT [dbo].[Menus] ([ID], [Name], [Url], [Remark], [Pid]) VALUES (1018, N'菜单管理', N'/Menu/Index', N'菜单信息管理', 1022)
INSERT [dbo].[Menus] ([ID], [Name], [Url], [Remark], [Pid]) VALUES (1019, N'关于', N'/Home/About', NULL, NULL)
INSERT [dbo].[Menus] ([ID], [Name], [Url], [Remark], [Pid]) VALUES (1020, N'联系方式', N'/Home/Contact', NULL, NULL)
INSERT [dbo].[Menus] ([ID], [Name], [Url], [Remark], [Pid]) VALUES (1021, N'授权管理', N'/Account/Index', NULL, 1022)
INSERT [dbo].[Menus] ([ID], [Name], [Url], [Remark], [Pid]) VALUES (1022, N'系统管理', NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ID], [Name], [Url], [Remark], [Pid]) VALUES (1023, N'人员管理', NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ID], [Name], [Url], [Remark], [Pid]) VALUES (1024, N'教师管理', N'/Teachers/Index', NULL, 1023)
INSERT [dbo].[Menus] ([ID], [Name], [Url], [Remark], [Pid]) VALUES (1025, N'学生管理', N'/Student/Index', NULL, 1023)
INSERT [dbo].[Menus] ([ID], [Name], [Url], [Remark], [Pid]) VALUES (1026, N'教务管理', NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ID], [Name], [Url], [Remark], [Pid]) VALUES (1027, N'试卷管理', N'/Papers/Index', NULL, 1026)
INSERT [dbo].[Menus] ([ID], [Name], [Url], [Remark], [Pid]) VALUES (1028, N'审卷', N'/Answers/TeAnswer', NULL, 1026)
INSERT [dbo].[Menus] ([ID], [Name], [Url], [Remark], [Pid]) VALUES (1029, N'个人中心', NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ID], [Name], [Url], [Remark], [Pid]) VALUES (1030, N'在线考试', N'/Papers/IndexStu', NULL, 1029)
INSERT [dbo].[Menus] ([ID], [Name], [Url], [Remark], [Pid]) VALUES (1031, N'我的考试', N'/Answers/MyAnswer', NULL, 1029)
SET IDENTITY_INSERT [dbo].[Menus] OFF
SET IDENTITY_INSERT [dbo].[Paper] ON 

INSERT [dbo].[Paper] ([PaperID], [PaperName], [PaperExplain], [PaperTime]) VALUES (1, N'HTML理论试题一', N'HTML理论试题一', 49)
INSERT [dbo].[Paper] ([PaperID], [PaperName], [PaperExplain], [PaperTime]) VALUES (2, N'C#Base 2019 期末试卷', N'C#Base 2019 期末试卷', 15)
INSERT [dbo].[Paper] ([PaperID], [PaperName], [PaperExplain], [PaperTime]) VALUES (3, N'mvc考试', N'测试', 60)
INSERT [dbo].[Paper] ([PaperID], [PaperName], [PaperExplain], [PaperTime]) VALUES (4, N'11', N'123', 11)
INSERT [dbo].[Paper] ([PaperID], [PaperName], [PaperExplain], [PaperTime]) VALUES (5, N'模拟', N'模拟', 120)
INSERT [dbo].[Paper] ([PaperID], [PaperName], [PaperExplain], [PaperTime]) VALUES (6, N'MVC模拟考试', N'比较简单', 120)
INSERT [dbo].[Paper] ([PaperID], [PaperName], [PaperExplain], [PaperTime]) VALUES (8, N'模拟1', N'字段', 60)
INSERT [dbo].[Paper] ([PaperID], [PaperName], [PaperExplain], [PaperTime]) VALUES (9, N'模拟测试', N'1', 50)
INSERT [dbo].[Paper] ([PaperID], [PaperName], [PaperExplain], [PaperTime]) VALUES (10, N'20200420理论测试', N'难易适中', 45)
SET IDENTITY_INSERT [dbo].[Paper] OFF
SET IDENTITY_INSERT [dbo].[R_Role_Menus] ON 

INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (7, 1011, 1015)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (8, 1011, 1016)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (9, 1012, 1017)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (10, 1012, 1018)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (11, 1013, 1015)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (12, 1013, 1016)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (13, 1013, 1017)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (14, 1013, 1018)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (28, 1010, 1015)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (29, 1010, 1016)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (30, 1010, 1017)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (31, 1010, 1018)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (32, 1010, 1019)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (33, 1010, 1020)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (34, 1010, 1021)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (35, 1010, 1022)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (36, 1010, 1023)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (37, 1010, 1024)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (38, 1010, 1025)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (39, 1010, 1026)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (40, 1010, 1027)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (41, 1010, 1028)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (42, 1010, 1029)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (43, 1010, 1030)
INSERT [dbo].[R_Role_Menus] ([ID], [RoleID], [MenuID]) VALUES (44, 1010, 1031)
SET IDENTITY_INSERT [dbo].[R_Role_Menus] OFF
SET IDENTITY_INSERT [dbo].[R_User_Roles] ON 

INSERT [dbo].[R_User_Roles] ([ID], [UserID], [RoleID]) VALUES (1, 1015, 1011)
INSERT [dbo].[R_User_Roles] ([ID], [UserID], [RoleID]) VALUES (2, 1016, 1012)
INSERT [dbo].[R_User_Roles] ([ID], [UserID], [RoleID]) VALUES (5, 1019, 1010)
INSERT [dbo].[R_User_Roles] ([ID], [UserID], [RoleID]) VALUES (9, 1017, 1010)
INSERT [dbo].[R_User_Roles] ([ID], [UserID], [RoleID]) VALUES (10, 1017, 1013)
INSERT [dbo].[R_User_Roles] ([ID], [UserID], [RoleID]) VALUES (1007, 1018, 1011)
INSERT [dbo].[R_User_Roles] ([ID], [UserID], [RoleID]) VALUES (1008, 1018, 1012)
INSERT [dbo].[R_User_Roles] ([ID], [UserID], [RoleID]) VALUES (2007, 3021, 1011)
SET IDENTITY_INSERT [dbo].[R_User_Roles] OFF
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([ID], [Name], [Remark]) VALUES (1010, N'超级管理员', NULL)
INSERT [dbo].[Roles] ([ID], [Name], [Remark]) VALUES (1011, N'学术主任', NULL)
INSERT [dbo].[Roles] ([ID], [Name], [Remark]) VALUES (1012, N'学工主任', NULL)
INSERT [dbo].[Roles] ([ID], [Name], [Remark]) VALUES (1013, N'学生处主任', NULL)
SET IDENTITY_INSERT [dbo].[Roles] OFF
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([StuID], [StuName], [StuLoginName], [StuLoginPwd], [StuSex], [StuPhone], [StuEmail], [StuGrade], [UserID]) VALUES (1, N'张三', N'zhangsan', N'111', 0, N'133*****000', N'asdf@qq.com', N'湖南工程3801', NULL)
INSERT [dbo].[Student] ([StuID], [StuName], [StuLoginName], [StuLoginPwd], [StuSex], [StuPhone], [StuEmail], [StuGrade], [UserID]) VALUES (2, N'李四', N'lisi', N'111', 1, N'133*****001', N'1232444@qq.com', N'湖南工程3802', NULL)
INSERT [dbo].[Student] ([StuID], [StuName], [StuLoginName], [StuLoginPwd], [StuSex], [StuPhone], [StuEmail], [StuGrade], [UserID]) VALUES (3, N'王武', N'wangwu', N'111', 0, N'133*****002', N'ssdfett@qq.com', N'湖南工程3802', NULL)
INSERT [dbo].[Student] ([StuID], [StuName], [StuLoginName], [StuLoginPwd], [StuSex], [StuPhone], [StuEmail], [StuGrade], [UserID]) VALUES (6, N'王宁河', N'wnh', N'111', 1, N'18221731149', N'24@qq.com', N'湖南工程3801班', NULL)
INSERT [dbo].[Student] ([StuID], [StuName], [StuLoginName], [StuLoginPwd], [StuSex], [StuPhone], [StuEmail], [StuGrade], [UserID]) VALUES (7, N'李凌君', N'llj', N'111', 0, N'18221731149', N'102@qq.com', N'湖南工程3802班', NULL)
INSERT [dbo].[Student] ([StuID], [StuName], [StuLoginName], [StuLoginPwd], [StuSex], [StuPhone], [StuEmail], [StuGrade], [UserID]) VALUES (8, N'李凌君', N'llj2', N'111111', 1, N'asdasdasd', N'123@qq.com', N'2018173802班', NULL)
INSERT [dbo].[Student] ([StuID], [StuName], [StuLoginName], [StuLoginPwd], [StuSex], [StuPhone], [StuEmail], [StuGrade], [UserID]) VALUES (1008, N'胡瑶', N'huyao', N'111111', 0, N'18221731149', N'102555555@qq.com', N'2018173801班', NULL)
SET IDENTITY_INSERT [dbo].[Student] OFF
SET IDENTITY_INSERT [dbo].[Teacher] ON 

INSERT [dbo].[Teacher] ([TeacherID], [TeacherName], [TeacherLoginName], [TeacherLoginPwd], [TeacherPhone], [TeacherEmail], [UserID]) VALUES (1, N'teacher', N'teacher', N'111', N'138*****000', N'1@qq.com', NULL)
INSERT [dbo].[Teacher] ([TeacherID], [TeacherName], [TeacherLoginName], [TeacherLoginPwd], [TeacherPhone], [TeacherEmail], [UserID]) VALUES (2028, N'huyao', N'huyao', N'111111', N'1122334445566', N'1075602052@qq.com', NULL)
INSERT [dbo].[Teacher] ([TeacherID], [TeacherName], [TeacherLoginName], [TeacherLoginPwd], [TeacherPhone], [TeacherEmail], [UserID]) VALUES (2029, N'李凌君', N'llj', N'111111', N'18221731149', N'10756020521@qq.com', NULL)
INSERT [dbo].[Teacher] ([TeacherID], [TeacherName], [TeacherLoginName], [TeacherLoginPwd], [TeacherPhone], [TeacherEmail], [UserID]) VALUES (2030, N'陈兰兰', N'cll', N'1111111', N'12312311231', N'111@qq.com', NULL)
SET IDENTITY_INSERT [dbo].[Teacher] OFF
SET IDENTITY_INSERT [dbo].[Topic] ON 

INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (1, N'下列css属性中,用于指定背景图片的是( )', 25, 1, N'background-image', N'background-color', N'background-position', N'background-repeat', 1, N'A', 1)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (2, N'下面哪个CSS属性是用来改变背景颜色( )', 25, 1, N'background-color', N'bgcolor', N'color', N'text', 1, N'A', 1)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (3, N'天空是红色的', 25, 2, N'', N'', N'', N'', 2, N'0', 1)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (4, N'无序列表的标签是？', 25, 3, N'', N'', N'', N'', 3, N'<ul><li>', 1)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (5, N'在C#.NET中，下列定义常量的语句中，正确的是( )', 25, 1, N'const double PI 3.1415926;', N'const double e=2.7;', N'define double PI 3.1415926', N'define double e=2.7', 1, N'B', 2)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (6, N'在C#.NET中，下列变量名是正确的选项是( )', 25, 1, N'$3', N'45b', N'a_3', N'int', 1, N'C', 2)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (7, N'C#源程序的扩展名是.cs', 25, 2, N'', N'', N'', N'', 2, N'1', 2)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (8, N'在C#.NET中，设int a=3,b=4,c=5;表达式(a+b)>c&&b==c的值是:', 25, 3, N'', N'', N'', N'', 3, N'false', 2)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (9, N'请选择您现在的心情？', 25, 1, N'非常好', N'很好', N'一般', N'差', 1, N'A', 1)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (10, N'这个题目不错', 25, 1, N'很难', N'一般', N'还行', N'容易', 1, N'B', 1)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (11, N'123', 12, 1, N'1', N'2', N'3', N'4', 1, N'4', 1)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (12, N'今天的课如何？', 100, 1, N'容易', N'还行', N'有点难', N'非常难', 1, N'A', 5)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (13, N'你觉得mvc学习内容设计得如何？', 50, 1, N'不好', N'一般', N'还可以', N'非常好', 1, N'D', 6)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (14, N'你觉得学习起来难吗？', 50, 1, N'非常容易', N'还行', N'有点难', N'非常难', 1, N'A', 6)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (15, N'123', 5, 1, N'1', N'2', N'3', N'4', 1, N'A', 1)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (16, N'123', 1, 1, N'1', N'2', N'3', N'4', 1, N'A', 8)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (17, N'第二题', 2, 2, N'正确', N'错误', NULL, NULL, 1, N'正确', 8)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (18, N'第三题', 3, 3, N'答案1', NULL, NULL, NULL, 6, N'答案1', 8)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (20, N'我美吗?????', 100, 1, N'很美', N'美', N'一般', N'你丑', 1, N'D', 8)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (24, N'今天考试题难吗？', 20, 1, N'难', N'一般', N'简单', N'非常简单', 1, N'B', 9)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (25, N'你MVC可以结合三层一起用吗？', 20, 2, N'正确', N'错误', NULL, NULL, 1, N'正确', 9)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (26, N'MVC是由哪几部分组成？', 60, 3, NULL, NULL, NULL, NULL, 1, N'控制器、模型、视图', 9)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (27, N'哪一部分不属于MVC的组成部分？', 25, 1, N'模型', N'控制器', N'视图', N'路由', 1, N'D', 10)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (28, N'MVC不能与三层结合一起使用，对吗？', 25, 2, N'正确', N'错误', NULL, NULL, 2, N'错误', 10)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (29, N'MVC的组成部分是？', 25, 3, NULL, NULL, NULL, NULL, 3, N'控制器、模型、视图', 10)
INSERT [dbo].[Topic] ([TopicID], [TopicExplain], [TopicScore], [TopicType], [TopicA], [TopicB], [TopicC], [TopicD], [TopicSort], [TopicAnswer], [PaperID]) VALUES (30, N'你觉得这套题目难吗？', 25, 1, N'难', N'一般', N'简单', N'非常简单', 4, N'D', 10)
SET IDENTITY_INSERT [dbo].[Topic] OFF
SET IDENTITY_INSERT [dbo].[UserInfos] ON 

INSERT [dbo].[UserInfos] ([ID], [DepartmentID], [Account], [Pwd]) VALUES (1015, 1007, N'chen.jiang', N'111111')
INSERT [dbo].[UserInfos] ([ID], [DepartmentID], [Account], [Pwd]) VALUES (1016, 1008, N'li.qiong', N'111111')
INSERT [dbo].[UserInfos] ([ID], [DepartmentID], [Account], [Pwd]) VALUES (1017, 1009, N'liu.guiling', N'111111')
INSERT [dbo].[UserInfos] ([ID], [DepartmentID], [Account], [Pwd]) VALUES (1018, 1009, N'hu.yao', N'111111')
INSERT [dbo].[UserInfos] ([ID], [DepartmentID], [Account], [Pwd]) VALUES (1019, 1009, N'chen.jianjun', N'111111')
INSERT [dbo].[UserInfos] ([ID], [DepartmentID], [Account], [Pwd]) VALUES (3021, 1007, N'hu', N'1')
SET IDENTITY_INSERT [dbo].[UserInfos] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Student__94E085758E9E9FD1]    Script Date: 2020/5/16 15:58:03 ******/
ALTER TABLE [dbo].[Student] ADD UNIQUE NONCLUSTERED 
(
	[StuLoginName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Teacher__5FCE442FF27BF203]    Script Date: 2020/5/16 15:58:03 ******/
ALTER TABLE [dbo].[Teacher] ADD UNIQUE NONCLUSTERED 
(
	[TeacherLoginName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Student] ADD  DEFAULT ('111') FOR [StuLoginPwd]
GO
ALTER TABLE [dbo].[Teacher] ADD  DEFAULT ('111') FOR [TeacherLoginPwd]
GO
ALTER TABLE [dbo].[Answer]  WITH CHECK ADD FOREIGN KEY([PaperID])
REFERENCES [dbo].[Paper] ([PaperID])
GO
ALTER TABLE [dbo].[Answer]  WITH CHECK ADD FOREIGN KEY([StuID])
REFERENCES [dbo].[Student] ([StuID])
GO
ALTER TABLE [dbo].[Answer]  WITH CHECK ADD FOREIGN KEY([TeacherID])
REFERENCES [dbo].[Teacher] ([TeacherID])
GO
ALTER TABLE [dbo].[Detail]  WITH CHECK ADD FOREIGN KEY([AnswerID])
REFERENCES [dbo].[Answer] ([AnswerID])
GO
ALTER TABLE [dbo].[Detail]  WITH CHECK ADD FOREIGN KEY([TopicID])
REFERENCES [dbo].[Topic] ([TopicID])
GO
ALTER TABLE [dbo].[R_Role_Menus]  WITH CHECK ADD  CONSTRAINT [FK_R_Role_Menus_Menus] FOREIGN KEY([MenuID])
REFERENCES [dbo].[Menus] ([ID])
GO
ALTER TABLE [dbo].[R_Role_Menus] CHECK CONSTRAINT [FK_R_Role_Menus_Menus]
GO
ALTER TABLE [dbo].[R_Role_Menus]  WITH CHECK ADD  CONSTRAINT [FK_R_Role_Menus_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([ID])
GO
ALTER TABLE [dbo].[R_Role_Menus] CHECK CONSTRAINT [FK_R_Role_Menus_Roles]
GO
ALTER TABLE [dbo].[R_User_Roles]  WITH CHECK ADD  CONSTRAINT [FK_R_User_Roles_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([ID])
GO
ALTER TABLE [dbo].[R_User_Roles] CHECK CONSTRAINT [FK_R_User_Roles_Roles]
GO
ALTER TABLE [dbo].[R_User_Roles]  WITH CHECK ADD  CONSTRAINT [FK_R_User_Roles_UserInfos] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserInfos] ([ID])
GO
ALTER TABLE [dbo].[R_User_Roles] CHECK CONSTRAINT [FK_R_User_Roles_UserInfos]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_UserInfos] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserInfos] ([ID])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_UserInfos]
GO
ALTER TABLE [dbo].[Teacher]  WITH CHECK ADD  CONSTRAINT [FK_Teacher_UserInfos] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserInfos] ([ID])
GO
ALTER TABLE [dbo].[Teacher] CHECK CONSTRAINT [FK_Teacher_UserInfos]
GO
ALTER TABLE [dbo].[Topic]  WITH CHECK ADD FOREIGN KEY([PaperID])
REFERENCES [dbo].[Paper] ([PaperID])
GO
ALTER TABLE [dbo].[UserInfos]  WITH CHECK ADD  CONSTRAINT [FK_UserInfos_Departments] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Departments] ([ID])
GO
ALTER TABLE [dbo].[UserInfos] CHECK CONSTRAINT [FK_UserInfos_Departments]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[50] 4[22] 2[23] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "rur"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 127
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rrm"
            Begin Extent = 
               Top = 124
               Left = 228
               Bottom = 245
               Right = 370
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "m"
            Begin Extent = 
               Top = 132
               Left = 38
               Bottom = 272
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Roles"
            Begin Extent = 
               Top = 6
               Left = 398
               Bottom = 127
               Right = 540
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_user_menus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_user_menus'
GO
USE [master]
GO
ALTER DATABASE [AccountDB] SET  READ_WRITE 
GO
