USE [APPendixFromPreProd]
GO
/****** Object:  StoredProcedure [dbo].[qryAddApplicationAdministrator]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryAddApplicationAdministrator]
	-- Add the parameters for the stored procedure here
	@nBDAppNo int,
	@nAdminPID int,
	@nActive bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE       tblBDApp_Admin
SET                Active_Admin = @nActive
WHERE        (BDApp_Number = @nBDAppNo) AND (BDApp_Admin_PID = @nAdminPID)

IF @@ROWCOUNT=0
	INSERT INTO tblBDApp_Admin
                         (BDApp_Number, BDApp_Admin_PID, Active_Admin)
VALUES        (@nBDAppNo,@nAdminPID,@nActive)
END

GO
/****** Object:  StoredProcedure [dbo].[qryAddApprovedUserApp]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryAddApprovedUserApp]  
	-- Add the parameters for the stored procedure here
	@nBDApp_ID int,
	@nUser_PID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		declare @nCount int
    -- Insert statements for procedure here
	SELECT PID, BDApp_ID
	FROM  tblUser_Apps
	WHERE (PID = @nUser_PID) AND (BDApp_ID = @nBDApp_ID)
	SET @nCount = @@ROWCOUNT
	IF @nCount=0
	INSERT INTO tblUser_Apps
		(PID, BDApp_ID, Favourite_App, Last_Used_by_User)
	VALUES (@nUser_PID, @nBDApp_ID, 0, CONVERT(VARCHAR(10), GETDATE(), 102) )

	UPDATE [dbo].[tblBDApp_Approvals] 
	SET [Decision] = 'Approved'
	FROM [dbo].[tblBDApp_Approvals]
	INNER JOIN dbo.tblApplications ON dbo.tblBDApp_Approvals.BDApp_No = dbo.tblApplications.BDApp_Number
	WHERE  ([User_PID] = @nUser_PID) AND (dbo.tblApplications.BDApp_ID = @nBDApp_ID)

END

GO
/****** Object:  StoredProcedure [dbo].[qryAddBDAppApplication]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryAddBDAppApplication] 
	-- Add the parameters for the stored procedure here
	@nBDAppNo int,
	@nBDAppName nvarchar(255),
	@nBDApp_Friendly nvarchar(255),
	@nRestBDApp bit,
	@nGoverningDL int,  
	@nContact nvarchar(255), 
    @nVersionNo nvarchar(255),  
	@nSourceFolder nvarchar(max),
	@nStatus int,
	@nUser_Install nvarchar(max),
	@nUpdatedBy int,
	@nUpdateProcess nvarchar(50),
	@nCommand nvarchar(max),
	@nCommandArgs nvarchar(max),
	@nAvailable_Launcher bit

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	UPDATE       tblApplications
SET                BDApp_Name = @nBDAppName, BDApp_Friendly_Name = @nBDApp_Friendly, Restricted_BDApp = @nRestBDApp, BDApp_Governing_DL = @nGoverningDL, BDApp_Admin_Contact = @nContact, 
                         BDApp_Version_Number = @nVersionNo, BDApp_Source_Folder = @nSourceFolder, BDApp_Status = @nStatus, User_Install_Location = @nUser_Install, Updated_By = @nUpdatedBy, Date_Updated = GETDATE(), Update_Process = @nUpdateProcess, 
                         BDApp_Command = @nCommand, BDApp_Command_Args = @nCommandArgs, Available_Via_Launcher = @nAvailable_Launcher
WHERE        (BDApp_Number = @nBDAppNo)

	IF @@ROWCOUNT=0
		INSERT INTO tblApplications
                         (BDApp_Number, BDApp_Name, BDApp_Friendly_Name, Restricted_BDApp, BDApp_Governing_DL, BDApp_Admin_Contact, BDApp_Version_Number, BDApp_Source_Folder, BDApp_Status, User_Install_Location, Updated_By, Date_Updated, 
                         Update_Process, BDApp_Command, BDApp_Command_Args, Available_Via_Launcher)
VALUES        (@nBDAppNo,@nBDAppName,@nBDApp_Friendly,@nRestBDApp,@nGoverningDL,@nContact,@nVersionNo,@nSourceFolder,@nStatus,@nUser_Install,@nUpdatedBy, GETDATE(),@nUpdateProcess,@nCommand,@nCommandArgs,@nAvailable_Launcher)
	
END

GO
/****** Object:  StoredProcedure [dbo].[qryAddBDAppApprovalRequest]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryAddBDAppApprovalRequest] 
	-- Add the parameters for the stored procedure here
	@nBDApp_No int,
	@nUser_PID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		declare @nCount int
    -- Insert statements for procedure here
	SELECT User_PID, BDApp_No
	FROM  dbo.tblBDApp_Approvals
	WHERE (User_PID = @nUser_PID) AND (BDApp_No = @nBDApp_No)
	SET @nCount = @@ROWCOUNT
	IF @nCount=0
	INSERT INTO tblBDApp_Approvals
		(User_PID, BDApp_No)
	VALUES (@nUser_PID, @nBDApp_No)
END

GO
/****** Object:  StoredProcedure [dbo].[qryAddBDAppIcon]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryAddBDAppIcon] 
	-- Add the parameters for the stored procedure here
	@nBDApp_No Int,
	@nBDApp_Icon Image
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE       tblBDApp_Image
SET                BDApp_Image = @nBDApp_Icon
WHERE        (BDApp_Number = @nBDApp_No)

IF @@ROWCOUNT=0		
	INSERT INTO tblBDApp_Image
                         (BDApp_Number, BDApp_Image)
	SELECT @nBDApp_No, @nBDApp_Icon;
END

GO
/****** Object:  StoredProcedure [dbo].[qryAddBDAppPackage]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryAddBDAppPackage] 
	-- Add the parameters for the stored procedure here
	@nBDApp_No Int,
	@nBDApp_Package varbinary(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE       tblBDApp_Package
SET                BDApp_Package = @nBDApp_Package
WHERE        (BDApp_Number = @nBDApp_No)

IF @@ROWCOUNT=0		
	INSERT INTO tblBDApp_Package
                         (BDApp_Number, BDApp_Package)
	 values(@nBDApp_No, @nBDApp_Package)
END


GO
/****** Object:  StoredProcedure [dbo].[qryAddNewUser]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryAddNewUser] 
	-- Add the parameters for the stored procedure here
	@nPID int, 
	@nFullName nvarchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblUsers
                         (PID, Full_Name, Active, App_Launcher_Admin)
VALUES        (@nPID, @nFullName, 1, 0)
END

GO
/****** Object:  StoredProcedure [dbo].[qryAmendUserFavourite]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[qryAmendUserFavourite] 
	-- Add the parameters for the stored procedure here
	@iPID Int,	@iBDApp_ID int, @bIsFavourite as bit 
AS
BEGIN

UPDATE [dbo].[tblUser_Apps]
   SET [Favourite_App] = @bIsFavourite
 WHERE  ([PID] = @iPID) AND ([BDApp_ID] = @iBDApp_ID)

END



GO
/****** Object:  StoredProcedure [dbo].[qryDeleteApplicationAdministrator]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryDeleteApplicationAdministrator]
	-- Add the parameters for the stored procedure here
	@nBDAppNo int,
	@nAdminPID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblBDApp_Admin
WHERE        (BDApp_Number = @nBDAppNo) AND (BDApp_Admin_PID = @nAdminPID)
END

GO
/****** Object:  StoredProcedure [dbo].[qryDeleteBDAppApplication]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[qryDeleteBDAppApplication] 
	-- Add the parameters for the stored procedure here
	@nBDAppNo int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	DELETE FROM tblUser_Apps
		FROM            tblUser_Apps INNER JOIN
                         tblApplications ON tblUser_Apps.BDApp_ID = tblApplications.BDApp_ID
		WHERE        (tblApplications.BDApp_Number = @nBDAppNo)

	DELETE FROM tblApplications
		WHERE        (BDApp_Number = @nBDAppNo)

	DELETE FROM tblBDApp_Package
		WHERE        (BDApp_Number = @nBDAppNo)

END

GO
/****** Object:  StoredProcedure [dbo].[qryGetAllApps]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Graham Shrives
-- Create date: 04/12/2018
-- Description:	List all apps
-- =============================================
CREATE PROCEDURE [dbo].[qryGetAllApps] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        tblApplications.BDApp_ID, tblApplications.BDApp_Number, tblApplications.BDApp_Name, tblApplications.BDApp_Friendly_Name, tblApplications.Restricted_BDApp, tblApplications.BDApp_Governing_DL, 
                         tblApplications.BDApp_Admin_Contact, tblApplications.BDApp_Version_Number, tblApplications.BDApp_Source_Folder, tblApplications.BDApp_Status, tblApplications.Updated_By, tblApplications.Date_Updated, 
                         tblApplications.Update_Process, tblStatus.Status_Description, tblGoverning_DLs.Governing_DL, tblGoverning_DLs.List_Managers, tblApplications.BDApp_Command, tblApplications.BDApp_Command_Args, 
                         tblApplications.User_Install_Location, tblApplications.Available_Via_Launcher
FROM            tblApplications INNER JOIN
                         tblGoverning_DLs ON tblApplications.BDApp_Governing_DL = tblGoverning_DLs.GDL_ID INNER JOIN
                         tblStatus ON tblApplications.BDApp_Status = tblStatus.Status_ID
WHERE        (tblApplications.Available_Via_Launcher = 1)
ORDER BY tblApplications.BDApp_Number
END

GO
/****** Object:  StoredProcedure [dbo].[qryGetAllUsers]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryGetAllUsers] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        PID, Full_Name, Active, App_Launcher_Admin
FROM            tblUsers
END

GO
/****** Object:  StoredProcedure [dbo].[qryGetAppAdmins]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryGetAppAdmins]
	-- Add the parameters for the stored procedure here
	@nBDAppNo int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        BDApp_Admin_PID, Active_Admin
FROM            tblBDApp_Admin
WHERE        (BDApp_Number = @nBDAppNo)
ORDER BY BDApp_Admin_PID
END

GO
/****** Object:  StoredProcedure [dbo].[qryGetApplicationImages]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryGetApplicationImages] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        BDApp_Number, BDApp_Image
FROM            tblBDApp_Image
END

GO
/****** Object:  StoredProcedure [dbo].[qryGetBDAppKPIs]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryGetBDAppKPIs] 
	-- Add the parameters for the stored procedure here
	@nBDAppNo int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        KPI_Description, KPI_Link
FROM            dbo.tblVPKPIs
WHERE        (BDApp_Number = @nBDAppNo)
Order By KPI_Description
END

GO
/****** Object:  StoredProcedure [dbo].[qryGetBDAppNos]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryGetBDAppNos] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        BDApp_Number
FROM            tblApplications
order by BDApp_Number
END

GO
/****** Object:  StoredProcedure [dbo].[qryGetBDAppPackage]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryGetBDAppPackage] 
	-- Add the parameters for the stored procedure here
		@nBDApp_No Int,
		@nBDApp_File nvarchar(max)

AS
BEGIN

	declare @nBDApp_Package varbinary(max)
	declare @init int

    SELECT @nBDApp_Package = BDApp_Package 
    FROM tblBDApp_Package
    WHERE BDApp_Number = @nBDApp_No;

	print 'no of matching rows ' + cast(@@ROWCOUNT as varchar(30));
	print 'package length ' + cast(LEN(@nBDApp_Package) as varchar(30));

    EXEC sp_OACreate 'ADODB.Stream', @init OUTPUT; -- Instance created
    EXEC sp_OASetProperty @init, 'Type', 1; 
    EXEC sp_OAMethod @init, 'Open'; 
    EXEC sp_OAMethod @init, 'Write', NULL, @nBDApp_Package;
    EXEC sp_OAMethod @init, 'SaveToFile', NULL, 'C:\Users\USER2\Documents\CEDAT.zip', 2;
    EXEC sp_OAMethod @init, 'Close'; 
    EXEC sp_OADestroy @init; -- Close the resource

    print 'Document Generated at - '+  @nBDApp_File  


 END         
        

GO
/****** Object:  StoredProcedure [dbo].[qryGetBDAppPackageZIP]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryGetBDAppPackageZIP] 
	-- Add the parameters for the stored procedure here
		@nBDApp_No Int

AS
BEGIN
	declare @init int

    SELECT BDApp_Package, cast(LEN(BDApp_Package) as varchar(30)) as PackageLength 
    FROM tblBDApp_Package
    WHERE BDApp_Number = @nBDApp_No;

 END

GO
/****** Object:  StoredProcedure [dbo].[qryGetGoverningDLs]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryGetGoverningDLs] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        GDL_ID, Governing_DL
FROM            tblGoverning_DLs
End

GO
/****** Object:  StoredProcedure [dbo].[qryGetPendingAppApprovals]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryGetPendingAppApprovals]
	-- Add the parameters for the stored procedure here
	@nPID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        tblApplications.BDApp_ID, tblApplications.BDApp_Name, tblBDApp_Approvals.User_PID, tblUsers.Full_Name, tblBDApp_Approvals.Decision, dbo.tblGoverning_DLs.Governing_DL AS BDApp_Governing_DL
FROM            tblBDApp_Approvals INNER JOIN
                         tblApplications ON tblBDApp_Approvals.BDApp_No = tblApplications.BDApp_Number INNER JOIN
                         tblBDApp_Admin ON tblBDApp_Approvals.BDApp_No = tblBDApp_Admin.BDApp_Number INNER JOIN
                         tblUsers ON tblBDApp_Approvals.User_PID = tblUsers.PID INNER JOIN
                         dbo.tblGoverning_DLs ON dbo.tblApplications.BDApp_Governing_DL = dbo.tblGoverning_DLs.GDL_ID
WHERE        (tblBDApp_Admin.BDApp_Admin_PID = @nPID) AND (tblBDApp_Approvals.Decision IS NULL)
END

GO
/****** Object:  StoredProcedure [dbo].[qryGetStatuses]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryGetStatuses] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        Status_ID, Status_Description
FROM            tblStatus
END

GO
/****** Object:  StoredProcedure [dbo].[qryGetUserAllocatedApps]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[qryGetUserAllocatedApps]  
	-- Add the parameters for the stored procedure here
	@PID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT        TOP (100) PERCENT tblApplications.BDApp_ID, tblApplications.BDApp_Number, 
                         CASE WHEN dbo.tblApplications.BDApp_Friendly_Name <> '' THEN dbo.tblApplications.BDApp_Friendly_Name ELSE dbo.tblApplications.BDApp_Name END AS BDAppName, tblApplications.Restricted_BDApp, 
                         tblGoverning_DLs.Governing_DL, tblApplications.BDApp_Admin_Contact, tblApplications.BDApp_Version_Number, tblApplications.BDApp_Source_Folder, tblApplications.BDApp_Command, 
                         tblApplications.BDApp_Command_Args, tblApplications.BDApp_Status, tblStatus.Status_Description, tblStatus.Status_Image, tblApplications.Updated_By, tblApplications.Date_Updated, tblApplications.Update_Process, 
                         '1' AS odr, tblUser_Apps.Favourite_App, lvwAppImages.BDApp_Image, tblApplications.User_Install_Location, tblApplications.Available_Via_Launcher
FROM            tblApplications INNER JOIN
                         tblUser_Apps ON tblApplications.BDApp_ID = tblUser_Apps.BDApp_ID INNER JOIN
                         lvwAppImages ON tblApplications.BDApp_ID = lvwAppImages.BDApp_ID LEFT OUTER JOIN
                         tblStatus ON tblApplications.BDApp_Status = tblStatus.Status_ID LEFT OUTER JOIN
                         tblGoverning_DLs ON tblApplications.BDApp_Governing_DL = tblGoverning_DLs.GDL_ID
WHERE        (tblUser_Apps.PID = @PID) AND (tblApplications.Available_Via_Launcher = 1)
ORDER BY odr, tblUser_Apps.Favourite_App DESC, BDAppName
END

GO
/****** Object:  StoredProcedure [dbo].[qryGetUserApps]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[qryGetUserApps]  
	-- Add the parameters for the stored procedure here
	@PID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT        TOP (100) PERCENT tblApplications.BDApp_ID, tblApplications.BDApp_Number, 
                         CASE WHEN dbo.tblApplications.BDApp_Friendly_Name <> '' THEN dbo.tblApplications.BDApp_Friendly_Name ELSE dbo.tblApplications.BDApp_Name END AS BDAppName, tblApplications.Restricted_BDApp, 
                         tblGoverning_DLs.Governing_DL, tblApplications.BDApp_Admin_Contact, tblApplications.BDApp_Version_Number, tblApplications.BDApp_Source_Folder, tblApplications.BDApp_Command, 
                         tblApplications.BDApp_Command_Args, tblApplications.BDApp_Status, tblApplications.Updated_By, tblApplications.Date_Updated, tblApplications.Update_Process, '1' AS odr, tblUser_Apps.Favourite_App, 
                         lvwAppImages.BDApp_Image, tblApplications.User_Install_Location, tblApplications.Available_Via_Launcher
FROM            tblApplications INNER JOIN
                         tblUser_Apps ON tblApplications.BDApp_ID = tblUser_Apps.BDApp_ID INNER JOIN
                         lvwAppImages ON tblApplications.BDApp_ID = lvwAppImages.BDApp_ID LEFT OUTER JOIN
                         tblGoverning_DLs ON tblApplications.BDApp_Governing_DL = tblGoverning_DLs.GDL_ID
WHERE        (tblUser_Apps.PID = @PID) AND (tblApplications.Available_Via_Launcher = 1)
	UNION
	SELECT        tblApplications.BDApp_ID, tblApplications.BDApp_Number, 
                         CASE WHEN dbo.tblApplications.BDApp_Friendly_Name <> '' THEN dbo.tblApplications.BDApp_Friendly_Name ELSE dbo.tblApplications.BDApp_Name END AS BDAppName, tblApplications.Restricted_BDApp, 
                         tblGoverning_DLs.Governing_DL, tblApplications.BDApp_Admin_Contact, tblApplications.BDApp_Version_Number, tblApplications.BDApp_Source_Folder, tblApplications.BDApp_Command, 
                         tblApplications.BDApp_Command_Args, tblApplications.BDApp_Status, tblApplications.Updated_By, tblApplications.Date_Updated, tblApplications.Update_Process, '2' AS odr, 0 AS Favourite_App, lvwAppImages.BDApp_Image, 
                         tblApplications.User_Install_Location, tblApplications.Available_Via_Launcher
FROM            tblApplications INNER JOIN
                         lvwAppImages ON tblApplications.BDApp_ID = lvwAppImages.BDApp_ID LEFT OUTER JOIN
                         tblGoverning_DLs ON tblApplications.BDApp_Governing_DL = tblGoverning_DLs.GDL_ID
WHERE        (tblApplications.BDApp_Number NOT IN
                             (SELECT        BDApp_Number
                               FROM            lvwUsersBDApps
                               WHERE        (PID = @PID))) AND (tblApplications.Available_Via_Launcher = 1)
ORDER BY odr, Favourite_App DESC, BDAppName

END

GO
/****** Object:  StoredProcedure [dbo].[qryGetUserDetails]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryGetUserDetails] 
	-- Add the parameters for the stored procedure here
	@PID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        tblUsers.PID, tblUsers.Full_Name, tblUsers.Active, tblUsers.App_Launcher_Admin, derivedtblBDAppAdmin.BDApp_Admin_PID
FROM            tblUsers LEFT OUTER JOIN
                             (SELECT        BDApp_Admin_PID
                               FROM            tblBDApp_Admin
                               WHERE        (Active_Admin = 1)
                               GROUP BY BDApp_Admin_PID
                               HAVING         (BDApp_Admin_PID = @PID)) AS derivedtblBDAppAdmin ON tblUsers.PID = derivedtblBDAppAdmin.BDApp_Admin_PID
WHERE        (tblUsers.PID = @PID)
END

GO
/****** Object:  StoredProcedure [dbo].[qryGetUserUnAllocatedApps]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[qryGetUserUnAllocatedApps]  
	-- Add the parameters for the stored procedure here
	@PID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT        tblApplications.BDApp_ID, tblApplications.BDApp_Number, 
                         CASE WHEN dbo.tblApplications.BDApp_Friendly_Name <> '' THEN dbo.tblApplications.BDApp_Friendly_Name ELSE dbo.tblApplications.BDApp_Name END AS BDAppName, tblApplications.Restricted_BDApp, 
                         tblGoverning_DLs.Governing_DL, tblApplications.BDApp_Admin_Contact, tblApplications.BDApp_Version_Number, tblApplications.BDApp_Source_Folder, tblApplications.BDApp_Command, 
                         tblApplications.BDApp_Command_Args, tblApplications.BDApp_Status, tblStatus.Status_Description, tblStatus.Status_Image, tblApplications.Updated_By, tblApplications.Date_Updated, tblApplications.Update_Process, 
                         '2' AS odr, 0 AS Favourite_App, lvwAppImages.BDApp_Image, tblApplications.User_Install_Location, tblApplications.Available_Via_Launcher
FROM            tblApplications INNER JOIN
                         lvwAppImages ON tblApplications.BDApp_ID = lvwAppImages.BDApp_ID LEFT OUTER JOIN
                         tblStatus ON tblApplications.BDApp_Status = tblStatus.Status_ID LEFT OUTER JOIN
                         tblGoverning_DLs ON tblApplications.BDApp_Governing_DL = tblGoverning_DLs.GDL_ID
WHERE        (tblApplications.BDApp_Number NOT IN
                             (SELECT        BDApp_Number
                               FROM            lvwUsersBDApps
                               WHERE        (PID = @PID))) AND (tblApplications.Available_Via_Launcher = 1)
ORDER BY odr, Favourite_App DESC, BDAppName
END

GO
/****** Object:  StoredProcedure [dbo].[qryGetVersionNumber]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryGetVersionNumber]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        Version_Number
FROM            dbo.tblVersionNumber
END

GO
/****** Object:  StoredProcedure [dbo].[qrySetDeclinedUserApp]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qrySetDeclinedUserApp] 
	-- Add the parameters for the stored procedure here
	@nBDApp_ID int,
	@nUser_PID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE [dbo].[tblBDApp_Approvals] 
	SET [Decision] = 'Declined'
	FROM [dbo].[tblBDApp_Approvals]
	INNER JOIN dbo.tblApplications ON dbo.tblBDApp_Approvals.BDApp_No = dbo.tblApplications.BDApp_Number
	WHERE  ([User_PID] = @nUser_PID) AND (dbo.tblApplications.BDApp_ID = @nBDApp_ID)
END

GO
/****** Object:  StoredProcedure [dbo].[qryUpdateUserAppLastUsed]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryUpdateUserAppLastUsed] 
	-- Add the parameters for the stored procedure here
@nBDApp_ID int, @nPID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	UPDATE tblUser_Apps SET tblUser_Apps.Last_Used_by_User = CONVERT(VARCHAR(10), GETDATE(), 102) 
	WHERE ((tblUser_Apps.BDApp_ID = @nBDApp_ID) AND (tblUser_Apps.PID = @nPID));
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPAddAss]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPAddAss] 
	-- Add the parameters for the stored procedure here
	@nAssRef int,
	@nBDAppID int,
	@nDateOpened date,
	@nSLATarget date,
	@nDescription nvarchar(100),
	@nAssDev int,
	@nEmailSent date,
	@nEmailChased date,
	@nNotes nvarchar(100),
	@nNAD date,
	@nNA nvarchar(100),
	@nResolved date,
	@nFix nvarchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Update proccedure to update assyst table
	UPDATE       tblVPAssyst
SET                BDApp_ID = @nBDAppID, Assyst_Description = @nDescription, Assyst_Open = @nDateOpened, Assign_Dev = @nAssDev, SLA_Target = @nSLATarget, Email_Sent = @nEmailSent, Email_Chased = @nEmailChased, 
                         Assyst_Close = @nResolved, Notes = @nNotes, Next_Action_Date = @nNAD, Next_Action = @nNA, Assyst_Fix = @nFix
WHERE        (Assyst_Reference = @nAssRef)

	IF @@ROWCOUNT=0 --if application doesn't exist in above table then it needs adding to table
		Begin
		INSERT INTO tblVPAssyst
                         (Assyst_Reference, BDApp_ID, Assyst_Description, Assyst_Open, Assign_Dev, SLA_Target, Email_Sent, Email_Chased, Assyst_Close, Notes, Next_Action_Date, Next_Action, Assyst_Fix)
VALUES        (@nAssRef,@nBDAppID,@nDescription,@nDateOpened,@nAssDev,@nSLATarget,@nEmailSent,@nEmailChased,@nResolved,@nNotes,@nNAD,@nNA,@nFix)
		
		End

END

GO
/****** Object:  StoredProcedure [dbo].[qryVPAddBDAppApplication]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPAddBDAppApplication] 
	-- Add the parameters for the stored procedure here
	@nBDAppID int,
	@nBDAppNo int,
	@nBDAppName nvarchar(255),
	@nBDApp_Friendly nvarchar(255),
	@nRestBDApp bit,
	@nGoverningDL int,  
	@nContact nvarchar(255), 
    @nVersionNo nvarchar(255), 
	@nBDAppFolder nvarchar(max), 
	@nSourceFolder nvarchar(max),
	@nStatus int,
	@nUser_Install nvarchar(max),
	@nUpdatedBy int,
	@nUpdateProcess nvarchar(50),
	@nCommand nvarchar(max),
	@nCommandArgs nvarchar(max),
	@nAvailable_Launcher bit,
	@nGDPR bit,
	@nDPIA bit,
	@nSLA bit,
	@nDPIARef nvarchar(50),
	@nDPIALink nvarchar(max),
	@nSLALink nvarchar(max),
	@nDirectorate nvarchar(50),
	@nGroup nvarchar(50),
	@nCriticality int,
	@nBDAppReg bit,
	@nProductOwner nvarchar(100),
	@nBusSME nvarchar(100),
	@nBusContact nvarchar(100),
	@nLeadDev int,
	@nDataGuardian nvarchar(100),
	@nBDAppDescription nvarchar(250),
	@nBDAppNotes nvarchar(250),
	@nSQLPreProd nvarchar(250),
	@nSQLLive nvarchar(250),
	@nFrontEnd nvarchar(50),
	@nBackEnd nvarchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Update proccedure to update application table
	UPDATE       tblApplications
SET                BDApp_Name = @nBDAppName, BDApp_Friendly_Name = @nBDApp_Friendly, Restricted_BDApp = @nRestBDApp, BDApp_Governing_DL = @nGoverningDL, BDApp_Admin_Contact = @nContact, 
                         BDApp_Version_Number = @nVersionNo, BDApp_Source_Folder = @nSourceFolder, BDApp_Status = @nStatus, User_Install_Location = @nUser_Install, Updated_By = @nUpdatedBy, Date_Updated = GETDATE(), Update_Process = @nUpdateProcess, 
                         BDApp_Command = @nCommand, BDApp_Command_Args = @nCommandArgs, Available_Via_Launcher = @nAvailable_Launcher
WHERE        (BDApp_ID = @nBDAppID)

	IF @@ROWCOUNT=0 --if application doesn't exist in above table then it needs adding to table
		Begin
		INSERT INTO tblApplications
                         (BDApp_Number, BDApp_Name, BDApp_Friendly_Name, Restricted_BDApp, BDApp_Governing_DL, BDApp_Admin_Contact, BDApp_Version_Number, BDApp_Source_Folder, BDApp_Status, User_Install_Location, Updated_By, Date_Updated, 
                         Update_Process, BDApp_Command, BDApp_Command_Args, Available_Via_Launcher)
		VALUES        (@nBDAppNo,@nBDAppName,@nBDApp_Friendly,@nRestBDApp,@nGoverningDL,@nContact,@nVersionNo,@nSourceFolder,@nStatus,@nUser_Install,@nUpdatedBy, GETDATE(),@nUpdateProcess,@nCommand,@nCommandArgs,@nAvailable_Launcher)
		
		SELECT @nBDAppID = SCOPE_IDENTITY() --need to capture ID of entry just added

		End
	--update Compliance Table

UPDATE       tblVPCompliance
SET                GDPR = @nGDPR, DPIA = @nDPIA, DPIA_Reference = @nDPIARef, DPIA_Link = @nDPIALink, SLA = @nSLA, SLA_Link = @nSLALink
WHERE        (BDApp_ID = @nBDAppID)
		If @@ROWCOUNT=0
			Begin
			INSERT INTO tblVPCompliance
                         (BDApp_ID, GDPR, DPIA, DPIA_Reference, DPIA_Link, SLA, SLA_Link)
VALUES        (@nBDAppID,@nGDPR,@nDPIA,@nDPIARef,@nDPIALink,@nSLA,@nSLALink)
				END


	--update Details Table
UPDATE       tblVPDetails
SET                Directorate = @nDirectorate, CGroup = @nGroup, BusinessCriticality = @nCriticality, BDAppReg = @nBDAppReg, ProductOwner = @nProductOwner, BusinessSME = @nBusSME, BusinessContact = @nBusContact, 
                         LeadDeveloper = @nLeadDev, DataGuardian = @nDataGuardian, BDAppDescription = @nBDAppDescription, BDAppNotes = @nBDAppNotes, SQLPreProdLocation = @nSQLPreProd, SQLLiveLocation = @nSQLLive, 
                         BDAppFolder = @nBDAppFolder, FrontEndLanguage = @nFrontEnd, BackEndLanguage = @nBackEnd
WHERE        (BDApp_ID = @nBDAppID)
		if @@ROWCOUNT=0
		Begin
			Insert into tblVPDetails
                (BDApp_ID, Directorate, CGroup, BusinessCriticality, BDAppReg, ProductOwner, BusinessSME, BusinessContact , LeadDeveloper, 
                         DataGuardian , BDAppDescription , BDAppNotes , SQLPreProdLocation , SQLLiveLocation , BDAppFolder , 
                         FrontEndLanguage , BackEndLanguage )
			Values(@nBDAppID, @nDirectorate, @nGroup, @nCriticality, @nBDAppReg, @nProductOwner, @nBusSME, @nBusContact, @nLeadDev, 
                         @nDataGuardian, @nBDAppDescription, @nBDAppNotes, @nSQLPreProd, @nSQLLive, @nBDAppFolder, 
                         @nFrontEnd, @nBackEnd)
		End

		Return @nBDAppID
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPAddNewUser]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPAddNewUser] 
	-- Add the parameters for the stored procedure here
	@nPID int, 
	@nFullName nvarchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblUsers
                         (PID, Full_Name, Active, App_Launcher_Admin, VP_Admin)
VALUES        (@nPID, @nFullName, 1, 0, 1)
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPAddOtherDev]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPAddOtherDev]
	-- Add the parameters for the stored procedure here
	@nBDAppID int,
	@nPID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
UPDATE       tblVPBDAppOtherDevs
SET                BDApp_ID = @nBDAppID, Other_Dev = @nPID
WHERE        (BDApp_ID = @nBDAppID) AND (Other_Dev = @nPID)

	IF @@ROWCOUNT=0 --if application doesn't exist in above table then it needs adding to table
		Begin
		INSERT INTO tblVPBDAppOtherDevs
                         (BDApp_ID, Other_Dev)
VALUES        (@nBDAppID,@nPID)
	End
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPAddReview]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPAddReview] 
	-- Add the parameters for the stored procedure here
	@nReviewID int,
	@nBDAppID int,
	@nBDAppNo int,
	@nReviewDate date,
	@nDescription nvarchar(100), 
	@nNotes nvarchar(max), 
	@nActioned date
	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Update proccedure to update application table
	UPDATE       tblVPReviews
SET                BDApp_ID = @nBDAppID, BDApp_Number = @nBDAppNo, Review_Date = @nReviewDate, Review_Description = @nDescription, Notes = @nNotes, Actioned = @nActioned
FROM            tblVPReviews INNER JOIN
                         tblApplications ON tblVPReviews.BDApp_Number = tblApplications.BDApp_Number
WHERE        (tblVPReviews.Review_ID = @nReviewID)

	IF @@ROWCOUNT=0 --if application doesn't exist in above table then it needs adding to table
		Begin
		INSERT INTO tblVPReviews
                         (BDApp_ID, BDApp_Number, Review_Date, Review_Description, Notes, Actioned)
VALUES        (@nBDAppID, @nBDAppNo,@nReviewDate,@nDescription,@nNotes,@nActioned)
		
		SELECT @nReviewID = SCOPE_IDENTITY() --need to capture ID of entry just added

		End

		Return @nReviewID

END

GO
/****** Object:  StoredProcedure [dbo].[qryVPAdminAddAss]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPAdminAddAss] 
	-- Add the parameters for the stored procedure here
	@nPrmOne int,
	@nPrmTwo nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE       tblVPAssystFixes
SET                Assyst_Fix = @nPrmTwo
WHERE        (Fix_Id = @nPrmOne)
IF @@ROWCOUNT=0 --if fix id doesn't exist in above table then it needs adding to table
		Begin
		INSERT INTO tblVPAssystFixes
                         (Assyst_Fix)
VALUES        (@nPrmTwo)
		End
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPAdminAddBart]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[qryVPAdminAddBart] 
	-- Add the parameters for the stored procedure here
	@nPrmOne int,
	@nPrmTwo nvarchar(50),
	@nPrmThree nvarchar(max),
	@nPrmFour nvarchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE       tblVPBARTimport
SET                dbTable = @nPrmTwo, exFileName = @nPrmThree, exImportInstruction = @nPrmFour
WHERE        (imp_ID = @nPrmOne)
IF @@ROWCOUNT=0 --if fix id doesn't exist in above table then it needs adding to table
		Begin
		INSERT INTO tblVPBARTimport
                         (dbTable,exFileName,exImportInstruction)
VALUES        (@nPrmTwo,@nPrmThree,@nPrmFour)
		End
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPAdminAddBusCrit]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[qryVPAdminAddBusCrit] 
	-- Add the parameters for the stored procedure here
	@nPrmOne int,
	@nPrmTwo nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE       tblVPBusinessCriticality
SET                Criticality = @nPrmTwo
WHERE        (Criticality_ID = @nPrmOne)
IF @@ROWCOUNT=0 --if fix id doesn't exist in above table then it needs adding to table
		Begin
		INSERT INTO tblVPBusinessCriticality
                         (Criticality)
VALUES        (@nPrmTwo)
		End
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPAdminAddDirectorate]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPAdminAddDirectorate] 
	-- Add the parameters for the stored procedure here
	@nPrmOne int,
	@nPrmTwo nvarchar(50),
	@nPrmThree bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE       tblVPDirectorate
SET                Directorate = @nPrmTwo, Active = @nPrmThree
WHERE        (Directorate_ID = @nPrmOne)

IF @@ROWCOUNT=0 --if fix id doesn't exist in above table then it needs adding to table
		Begin
		INSERT INTO tblVPDirectorate
                         (Directorate, Active)
VALUES        (@nPrmTwo,@nPrmThree)
		End

END

GO
/****** Object:  StoredProcedure [dbo].[qryVPAdminAddGroup]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPAdminAddGroup] 
	-- Add the parameters for the stored procedure here
	@nPrmOne int,
	@nPrmTwo nvarchar(50),
	@nPrmThree nvarchar(50),
	@nPrmFour bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE       tblVPGroup
SET                Directorate = @nPrmTwo, CGroup = @nPrmThree, Active = @nPrmFour
WHERE        (Group_ID = @nPrmOne)
IF @@ROWCOUNT=0 --if fix id doesn't exist in above table then it needs adding to table
		Begin
		INSERT INTO tblVPGroup
                         (Directorate,CGroup,Active)
VALUES        (@nPrmTwo,@nPrmThree,@nPrmFour)
		End
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPAdminAddKPI]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[qryVPAdminAddKPI] 
	-- Add the parameters for the stored procedure here
	@nPrmOne int,
	@nPrmTwo int,
	@nPrmThree nvarchar(50),
	@nPrmFour nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE       tblVPKPIs
SET                BDApp_Number = @nPrmTwo, KPI_Description = @nPrmThree, KPI_Link = @nPrmFour
WHERE        (KPI_ID = @nPrmOne)
IF @@ROWCOUNT=0 --if fix id doesn't exist in above table then it needs adding to table
		Begin
		INSERT INTO tblVPKPIs
                         (BDApp_Number,KPI_Description,KPI_Link)
VALUES        (@nPrmTwo,@nPrmThree,@nPrmFour)
		End
END


GO
/****** Object:  StoredProcedure [dbo].[qryVPAdminAddLanguage]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPAdminAddLanguage] 
	-- Add the parameters for the stored procedure here
	@nPrmOne int,
	@nPrmTwo nvarchar(50),
	@nPrmThree bit,
	@nPrmFour bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE       tblVPLanguages
SET                ProgLanguage = @nPrmTwo, FrontEnd = @nPrmThree, BackEnd = @nPrmFour
WHERE        (LanguageID = @nPrmOne)
IF @@ROWCOUNT=0 --if fix id doesn't exist in above table then it needs adding to table
		Begin
		INSERT INTO tblVPLanguages
                         (ProgLanguage,FrontEnd,BackEnd)
VALUES        (@nPrmTwo,@nPrmThree,@nPrmFour)
		End
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPAdminAddReviewDes]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPAdminAddReviewDes] 
	-- Add the parameters for the stored procedure here
	@nPrmOne int,
	@nPrmTwo nvarchar(100),
	@nPrmThree nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE       tblVPReviewDescriptions
SET                RDescription = @nPrmTwo, RSOP = @nPrmThree
WHERE        (RDes_ID = @nPrmOne)
IF @@ROWCOUNT=0 --if fix id doesn't exist in above table then it needs adding to table
		Begin
		INSERT INTO tblVPReviewDescriptions
                         (RDescription, RSOP)
VALUES        (@nPrmTwo, @nPrmThree)
		End
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPAdminAddStndReport]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPAdminAddStndReport] 
	-- Add the parameters for the stored procedure here
	@nPrmOne int,
	@nPrmTwo nvarchar(100),
	@nPrmThree nvarchar(100),
	@nPrmFour nvarchar(100),
	@nPrmFive nvarchar(100),
	@nPrmSix bit,
	@nPrmSeven bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE       tblVPStandardReports
SET                Report_Name = @nPrmTwo, Report_Template = @nPrmThree, Report_SP = @nPrmFour, Report_Additional_SP = @nPrmFive, DateTo = @nPrmSix, DateFrom = @nPrmSeven
WHERE        (Report_ID = @nPrmOne)
IF @@ROWCOUNT=0 --if fix id doesn't exist in above table then it needs adding to table
		Begin
		INSERT INTO tblVPStandardReports
                         (Report_Name , Report_Template , Report_SP , Report_Additional_SP , DateTo , DateFrom )
VALUES        (@nPrmTwo,@nPrmThree,@nPrmFour, @nPrmFive,  @nPrmSix,  @nPrmSeven)
		End
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPBARTImportInstructions]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[qryVPBARTImportInstructions]	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	
SELECT	B.dbTable, 
		B.exFileName, 
		B.exImportInstruction
FROM    tblVPBARTimport AS B
JOIN	(SELECT MAX(imp_ID) AS Max_ID
		FROM tblVPBARTimport AS tblVPBARTimport_1) AS drvtMaxID ON B.imp_ID = drvtMaxID.Max_ID
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPDeleteAssystCase]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPDeleteAssystCase]
	-- Add the parameters for the stored procedure here
	@nAssID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblVPAssyst
WHERE        (Assyst_Reference = @nAssID)
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPDeleteBDAppApplication]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPDeleteBDAppApplication] 
	-- Add the parameters for the stored procedure here
	@nBDAppNo int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
DELETE FROM tblVPDetails
FROM            tblApplications INNER JOIN
                         tblVPDetails ON tblApplications.BDApp_ID = tblVPDetails.BDApp_ID
WHERE        (tblApplications.BDApp_Number = @nBDAppNo)

DELETE FROM tblVPCompliance
FROM            tblApplications INNER JOIN
                         tblVPCompliance ON tblApplications.BDApp_ID = tblVPCompliance.BDApp_ID
WHERE        (tblApplications.BDApp_Number = @nBDAppNo)

DELETE FROM tblVPReviews
FROM            tblApplications INNER JOIN
                         tblVPReviews ON tblApplications.BDApp_ID = tblVPReviews.BDApp_ID
WHERE        (tblApplications.BDApp_Number = @nBDAppNo)

DELETE FROM tblVPAssyst
FROM            tblApplications INNER JOIN
                         tblVPAssyst ON tblApplications.BDApp_ID = tblVPAssyst.BDApp_ID
WHERE        (tblApplications.BDApp_Number = @nBDAppNo)

DELETE FROM tblVPBDAppOtherDevs
FROM            tblApplications INNER JOIN
                         tblVPBDAppOtherDevs ON tblApplications.BDApp_ID = tblVPBDAppOtherDevs.BDApp_ID
WHERE        (tblApplications.BDApp_Number = @nBDAppNo)



	DELETE FROM tblUser_Apps
		FROM            tblUser_Apps INNER JOIN
                         tblApplications ON tblUser_Apps.BDApp_ID = tblApplications.BDApp_ID
		WHERE        (tblApplications.BDApp_Number = @nBDAppNo)

	DELETE FROM tblApplications
		WHERE        (BDApp_Number = @nBDAppNo)

	DELETE FROM tblBDApp_Package
		WHERE        (BDApp_Number = @nBDAppNo)



END

GO
/****** Object:  StoredProcedure [dbo].[qryVPDeleteOtherDev]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPDeleteOtherDev]
	-- Add the parameters for the stored procedure here
	@nBDAppID int,
	@nPID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblVPBDAppOtherDevs
WHERE        (BDApp_ID = @nBDAppID) AND (Other_Dev = @nPID)
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPDeleteReview]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPDeleteReview]
	-- Add the parameters for the stored procedure here
	@nReviewID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblVPReviews
WHERE        (Review_ID = @nReviewID)
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetAdminTables]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetAdminTables]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        TableName, tblSQL, AddUpdateSP, HideColNos
FROM            tblVPAdminTables
ORDER BY TableName
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetAllAppNos]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Graham Shrives
-- Create date: 04/12/2018
-- Description:	List all apps
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetAllAppNos] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT BDApp_Number
FROM            tblApplications
ORDER BY BDApp_Number
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetAllApps]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Graham Shrives
-- Create date: 04/12/2018
-- Description:	List all apps
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetAllApps] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        tblApplications.BDApp_ID, tblApplications.BDApp_Number, tblApplications.BDApp_Name, tblApplications.BDApp_Friendly_Name, tblApplications.Restricted_BDApp, tblApplications.BDApp_Governing_DL, 
                         tblApplications.BDApp_Admin_Contact, tblApplications.BDApp_Version_Number, tblApplications.BDApp_Source_Folder, tblApplications.BDApp_Status, tblApplications.Updated_By, tblApplications.Date_Updated, 
                         tblApplications.Update_Process, tblStatus.Status_Description, tblGoverning_DLs.Governing_DL, tblGoverning_DLs.List_Managers, tblApplications.BDApp_Command, tblApplications.BDApp_Command_Args, 
                         tblApplications.User_Install_Location, tblApplications.Available_Via_Launcher
FROM            tblApplications INNER JOIN
                         tblGoverning_DLs ON tblApplications.BDApp_Governing_DL = tblGoverning_DLs.GDL_ID INNER JOIN
                         tblStatus ON tblApplications.BDApp_Status = tblStatus.Status_ID
ORDER BY tblApplications.BDApp_Number
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetAllBDApps]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Graham Shrives
-- Create date: 04/12/2018
-- Description:	List all apps
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetAllBDApps] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @now datetime
	declare @fortnight datetime
	declare @fourweeks datetime
	Set @now = getdate()
	set @fortnight = dateadd(day, 14, @now)
	set @fourweeks = dateadd(day, 28, @now)

	

    -- Insert statements for procedure here
	SELECT tblApplications.BDApp_ID, tblApplications.BDApp_Number, tblApplications.BDApp_Name, tblApplications.Available_Via_Launcher, CASE WHEN tblVPBART_Rank.BART_Rank IS NULL THEN 1000 ELSE tblVPBART_Rank.BART_Rank END AS BART_Ranking, CASE WHEN tblVPCompliance.GDPR = 1 THEN 1 ELSE 0 END AS GDPR, 
         CASE WHEN tblVPCompliance.DPIA = 1 THEN 1 ELSE 0 END AS DPIA, CASE WHEN tblVPCompliance.SLA = 1 THEN 1 ELSE 0 END AS SLA, tblApplications.BDApp_Status, tblStatus.Status_Image, tblStatus.Status_Description, CASE WHEN lvwNextBDAppReview.Next_Review_Date = '1/1/1900' THEN '' ELSE lvwNextBDAppReview.Next_Review_Date END AS Next_Review_Date, 
         CASE WHEN tblVPDetails.Directorate IS NULL THEN '' ELSE tblVPDetails.Directorate END AS Directorate, CASE WHEN tblVPDetails.CGroup IS NULL THEN '' ELSE tblVPDetails.CGroup END AS CGroup, CASE WHEN tblVPBusinessCriticality.Criticality IS NULL THEN '' ELSE CONCAT(tblVPBusinessCriticality.Criticality_ID, ' - ', tblVPBusinessCriticality.Criticality) END AS BusCrit, 
         CASE WHEN tblVPDetails.BDAppReg IS NULL THEN 0 ELSE tblVPDetails.BDAppReg END AS BDAppReg, CASE WHEN tblVPDetails.ProductOwner IS NULL THEN '' ELSE tblVPDetails.ProductOwner END AS ProductOwner, CASE WHEN tblVPDetails.BusinessSME IS NULL THEN '' ELSE tblVPDetails.BusinessSME END AS BusinessSME, 
         CASE WHEN tblVPDetails.BusinessContact IS NULL THEN '' ELSE tblVPDetails.BusinessContact END AS BusinessContact, CASE WHEN tblUsers.Full_Name IS NULL THEN '' ELSE tblUsers.Full_Name END AS Full_Name, CASE WHEN tblVPDetails.DataGuardian IS NULL THEN '' ELSE tblVPDetails.DataGuardian END AS DataGuardian, 
         CASE WHEN tblVPDetails.BDAppDescription IS NULL THEN '' ELSE tblVPDetails.BDAppDescription END AS BDAppDescription, CASE WHEN tblVPDetails.BDAppNotes IS NULL THEN '' ELSE tblVPDetails.BDAppNotes END AS BDAppNotes, 
         CASE WHEN lvwNextBDAppReview.Next_Review_Date = '01/01/1900' THEN '' WHEN lvwNextBDAppReview.Next_Review_Date < @now THEN 'R' WHEN lvwNextBDAppReview.Next_Review_Date < @fortnight THEN 'A' WHEN lvwNextBDAppReview.Next_Review_Date < @fourweeks THEN 'G' ELSE '' END AS RAG, dbo.tblApplications.Date_Updated
FROM  dbo.tblVPDetails LEFT OUTER JOIN
         dbo.tblVPBusinessCriticality ON tblVPDetails.BusinessCriticality = tblVPBusinessCriticality.Criticality_ID LEFT OUTER JOIN
         dbo.tblUsers ON tblVPDetails.LeadDeveloper = tblUsers.PID RIGHT OUTER JOIN
         dbo.tblApplications ON tblVPDetails.BDApp_ID = tblApplications.BDApp_ID LEFT OUTER JOIN
         dbo.lvwNextBDAppReview ON tblApplications.BDApp_ID = lvwNextBDAppReview.BDApp_ID LEFT OUTER JOIN
         dbo.tblStatus ON tblApplications.BDApp_Status = tblStatus.Status_ID LEFT OUTER JOIN
         dbo.tblVPCompliance ON tblApplications.BDApp_ID = tblVPCompliance.BDApp_ID LEFT OUTER JOIN
         dbo.tblVPBART_Rank ON tblApplications.BDApp_Number = tblVPBART_Rank.BDApp_Number
ORDER BY tblApplications.BDApp_Number, tblApplications.BDApp_Name
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetAppFormCombos]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetAppFormCombos] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT DISTINCT BDApp_Number, BDApp_ID
FROM            tblApplications
ORDER BY BDApp_Number

    -- Insert statements for procedure here
	SELECT DISTINCT GDL_ID, Governing_DL
FROM            tblGoverning_DLs
ORDER BY Governing_DL

SELECT DISTINCT Status_ID, Status_Description
FROM            tblStatus
ORDER BY Status_Description

SELECT DISTINCT Directorate
FROM            tblVPDirectorate
WHERE        (Active = 1)
ORDER BY Directorate

SELECT        Directorate, CGroup
FROM            tblVPGroup
WHERE        (Active = 1)
ORDER BY Directorate, CGroup

SELECT        Full_Name, PID
FROM            tblUsers
WHERE        (VP_Admin = 1) AND (Active = 1)
ORDER BY Full_Name

SELECT        ProgLanguage
FROM            tblVPLanguages
WHERE        (FrontEnd = 1)
ORDER BY ProgLanguage

SELECT        ProgLanguage
FROM            tblVPLanguages
WHERE        (BackEnd = 1)
ORDER BY ProgLanguage

SELECT        Criticality_ID, CONCAT(Criticality_ID, ' - ', Criticality) as Criticality
FROM            tblVPBusinessCriticality
ORDER BY Criticality_ID

End

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetAssFormCombos]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetAssFormCombos]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        Assyst_Reference
FROM            tblVPAssyst
ORDER BY Assyst_Reference

SELECT        BDApp_Number, BDApp_ID
FROM            tblApplications
ORDER BY BDApp_Number

SELECT        PID, Full_Name
FROM            tblUsers
WHERE        (VP_Admin = 1) AND (Active = 1)

SELECT        Assyst_Fix
FROM            tblVPAssystFixes
ORDER BY Assyst_Fix

END



GO
/****** Object:  StoredProcedure [dbo].[qryVPGetBDAppComp]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetBDAppComp] 
	-- Add the parameters for the stored procedure here
	@BDAppID integer
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        tblApplications.BDApp_ID, tblApplications.BDApp_Number, CASE WHEN tblVPCompliance.GDPR IS NULL THEN 0 ELSE tblVPCompliance.GDPR END AS GDPR, CASE WHEN tblVPCompliance.DPIA IS NULL 
                         THEN 0 ELSE tblVPCompliance.DPIA END AS DPIA, CASE WHEN tblVPCompliance.SLA IS NULL THEN 0 ELSE tblVPCompliance.SLA END AS SLA
FROM            tblVPCompliance RIGHT OUTER JOIN
                         tblApplications ON tblVPCompliance.BDApp_ID = tblApplications.BDApp_ID
WHERE        (tblApplications.BDApp_ID = @BDAppID)
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetBDAppDetail]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetBDAppDetail]
	-- Add the parameters for the stored procedure here
	@BDAppID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        tblApplications.BDApp_ID, CASE WHEN tblVPDetails.Directorate IS NULL THEN '' ELSE tblVPDetails.Directorate END AS Directorate, CASE WHEN tblVPDetails.CGroup IS NULL THEN '' ELSE tblVPDetails.CGroup END AS CGroup, 
                         CASE WHEN tblVPDetails.BDAppReg IS NULL THEN 0 ELSE tblVPDetails.BDAppReg END AS BDAppReg, CASE WHEN tblVPDetails.ProductOwner IS NULL THEN '' ELSE tblVPDetails.ProductOwner END AS ProductOwner, 
                         CASE WHEN tblVPDetails.BusinessSME IS NULL THEN '' ELSE tblVPDetails.BusinessSME END AS BusinessSME, CASE WHEN tblVPDetails.BusinessContact IS NULL 
                         THEN '' ELSE tblVPDetails.BusinessContact END AS BusinessContact, CASE WHEN tblUsers.Full_Name IS NULL THEN '' ELSE tblUsers.Full_Name END AS Full_Name, CASE WHEN tblVPDetails.DataGuardian IS NULL 
                         THEN '' ELSE tblVPDetails.DataGuardian END AS DataGuardian
FROM            tblApplications LEFT OUTER JOIN
                         tblUsers INNER JOIN
                         tblVPDetails ON tblUsers.PID = tblVPDetails.LeadDeveloper ON tblApplications.BDApp_ID = tblVPDetails.BDApp_ID
WHERE        (tblApplications.BDApp_ID = @BDAppID)
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetBDAppDGVs]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetBDAppDGVs]
	-- Add the parameters for the stored procedure here
	@BDAppID Integer
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @now datetime
	declare @fortnight datetime
	declare @fourweeks datetime
	declare @aweek datetime
	declare @afortnight datetime	
	Set @now = getdate()
	set @fortnight = dateadd(day, 14, @now)
	set @fourweeks = dateadd(day, 28, @now)
	set @aweek = dateadd(day, -7, @now)
	set @afortnight = dateadd(day, -14, @now)
	

    -- Insert statements for procedure here
	SELECT DISTINCT 
                         tblVPReviews.Review_ID, tblApplications.BDApp_ID, tblApplications.BDApp_Number, tblVPReviews.Review_Date AS RDate, 
                         CASE WHEN tblVPReviews.Review_Date < @now THEN 'R' WHEN tblVPReviews.Review_Date < @fortnight THEN 'A' WHEN tblVPReviews.Review_Date < @fourweeks THEN 'G' ELSE '' END AS RRag, 
                         CASE WHEN tblVPReviews.Review_Description IS NULL THEN '' ELSE tblVPReviews.Review_Description END AS RDescription, CASE WHEN tblVPReviews.Notes IS NULL THEN '' ELSE tblVPReviews.Notes END AS RNotes 
                         
FROM            tblVPReviews INNER JOIN
                         tblApplications ON tblVPReviews.BDApp_Number = tblApplications.BDApp_Number
WHERE        (tblVPReviews.Actioned IS NULL) AND (tblApplications.BDApp_ID = @BDAppID)
ORDER BY RDate

--SELECT        Work_Item_Start, Work_Item_Description, Work_Item_Target_Date
--FROM            tblVPWWorkOnHand
--WHERE        (BDApp_ID = @BDAppID) AND (Work_Item_Closed_Date IS NULL)
--ORDER BY Work_Item_Start

SELECT        Assyst_Reference AS ASSRef, BDApp_ID, Assyst_Description AS ASSDescription, Assyst_Open AS ASSStart, CASE WHEN Assyst_Open < @afortnight THEN 'R' WHEN Assyst_Open < @aweek THEN 'A' ELSE 'G' END AS ASSRag,
                          Assign_Dev as ASSDev, SLA_Target As ASSSla, Email_Sent as ASSSent, Email_Chased as ASSChased, Assyst_Close as ASSClosed, Notes As ASSNotes, Next_Action_Date as ASSNad, Next_Action as ASSNa, Assyst_Fix As ASSFix
FROM            tblVPAssyst
WHERE        (BDApp_ID = @BDAppID) AND (Assyst_Close IS NULL)
ORDER BY ASSStart

SELECT        tblUsers.Full_Name
FROM            tblVPBDAppOtherDevs INNER JOIN
                         tblUsers ON tblVPBDAppOtherDevs.Other_Dev = tblUsers.PID
WHERE        (tblVPBDAppOtherDevs.BDApp_ID = @BDAppID)
ORDER BY tblUsers.Full_Name
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetBDAppName]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetBDAppName]
	-- Add the parameters for the stored procedure here
	@nBDAppID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        BDApp_Name
FROM            tblApplications
WHERE        (BDApp_ID = @nBDAppID)
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetBDAppOthDevs]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetBDAppOthDevs]
	-- Add the parameters for the stored procedure here
	@nBDAppID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        CASE WHEN tblVPBDAppOtherDevs.BDApp_ID = @nBDAppID THEN 1 ELSE 0 END AS DevCheck, tblUsers.PID As DEVPID, tblUsers.Full_Name
FROM            tblUsers LEFT OUTER JOIN
                         tblVPBDAppOtherDevs ON tblUsers.PID = tblVPBDAppOtherDevs.Other_Dev
WHERE        (tblUsers.VP_Admin = 1)
ORDER BY tblUsers.Full_Name
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetBDAppReviews]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetBDAppReviews]
	-- Add the parameters for the stored procedure here
	@BDAppID Integer
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT tblApplications.BDApp_ID, tblApplications.BDApp_Number, tblVPReviews.Review_Date, tblVPReviews.Review_Description, tblVPReviews.Notes, tblVPReviews.Review_ID
FROM            tblVPReviews INNER JOIN
                         tblApplications ON tblVPReviews.BDApp_Number = tblApplications.BDApp_Number
WHERE        (tblVPReviews.Actioned IS NULL) AND (tblApplications.BDApp_ID = @BDAppID)
ORDER BY tblVPReviews.Review_Date
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetFullAssystDetail]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetFullAssystDetail]
	-- Add the parameters for the stored procedure here
	@nAssRef int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        tblVPAssyst.Assyst_Reference, tblApplications.BDApp_Number, tblApplications.BDApp_Name, tblVPAssyst.Assyst_Open, tblVPAssyst.SLA_Target, tblVPAssyst.Assyst_Description, tblVPAssyst.Email_Sent, 
                         tblVPAssyst.Email_Chased, tblVPAssyst.Notes, tblVPAssyst.Next_Action_Date, tblVPAssyst.Next_Action, tblVPAssyst.Assyst_Fix, tblVPAssyst.Assyst_Close, tblUsers.Full_Name
FROM            tblUsers RIGHT OUTER JOIN
                         tblVPAssyst ON tblUsers.PID = tblVPAssyst.Assign_Dev LEFT OUTER JOIN
                         tblApplications ON tblVPAssyst.BDApp_ID = tblApplications.BDApp_ID
WHERE        (tblVPAssyst.Assyst_Reference = @nAssRef)
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetFullBDAppDetail]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Graham Shrives
-- Create date: 04/12/2018
-- Description:	List all apps
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetFullBDAppDetail] 
	-- Add the parameters for the stored procedure here
	@nBDApp_iD Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        BDApp_ID, BDApp_Number, BDApp_Name, BDApp_Friendly_Name, Restricted_BDApp, Governing_DL, BDApp_Admin_Contact, BDApp_Version_Number, BDApp_Source_Folder, Status_Description, User_Install_Location, 
                         Update_Process, BDApp_Command, BDApp_Command_Args, Available_Via_Launcher, GDPR, DPIA, SLA, CASE WHEN SLA_Link IS NULL THEN '' ELSE SLA_Link END AS SLA_Link, Directorate, CGroup, CASE WHEN BusinessCriticality is NULL Then '' ELSE BusinessCriticality End As BusinessCriticality, BDAppReg, 
                         ProductOwner, BusinessSME, BusinessContact, Full_Name, DataGuardian, BDAppDescription, BDAppNotes, CASE WHEN SQLPreProdLocation IS NULL THEN '' ELSE SQLPreProdLocation END AS SQLPreProd, 
                         CASE WHEN SQLLiveLocation IS NULL THEN '' ELSE SQLLiveLocation END AS SQLLive, CASE WHEN BDAppFolder IS NULL THEN '' ELSE BDAppFolder END AS BDAppFolder, CASE WHEN FrontEndLanguage IS NULL 
                         THEN '' ELSE FrontEndLanguage END AS FrontEnd, CASE WHEN BackEndLanguage IS NULL THEN '' ELSE BackEndLanguage END AS BackEnd, CASE WHEN BART_Rank IS NULL THEN 0 ELSE BART_Rank END AS BARTRank, 
                         CASE WHEN DPIA_Reference IS NULL THEN '' ELSE DPIA_Reference END AS DPIA_Ref, CASE WHEN DPIA_Link IS NULL THEN '' ELSE DPIA_Link END AS DPIA_Link
FROM            lvwBDAppDetail
WHERE        (BDApp_ID = @nBDApp_ID)
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetOtherDevsDGVs]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetOtherDevsDGVs]
	-- Add the parameters for the stored procedure here
	@BDAppID Integer
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT        tblUsers.Full_Name
FROM            tblVPBDAppOtherDevs INNER JOIN
                         tblUsers ON tblVPBDAppOtherDevs.Other_Dev = tblUsers.PID
WHERE        (tblVPBDAppOtherDevs.BDApp_ID = @BDAppID)
ORDER BY tblUsers.Full_Name
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetReviewDetails]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetReviewDetails]
	-- Add the parameters for the stored procedure here
	@nReviewID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        Review_ID, Review_Description, Notes, Actioned, BDApp_Number, BDApp_ID, Review_Date
FROM            tblVPReviews
WHERE        (Review_ID = @nReviewID)
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetReviewDGVs]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetReviewDGVs]
	-- Add the parameters for the stored procedure here
	@BDAppID Integer
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @now datetime
	declare @fortnight datetime
	declare @fourweeks datetime
	declare @aweek datetime
	declare @afortnight datetime	
	Set @now = getdate()
	set @fortnight = dateadd(day, 14, @now)
	set @fourweeks = dateadd(day, 28, @now)
	set @aweek = dateadd(day, -7, @now)
	set @afortnight = dateadd(day, -14, @now)
	

    -- Insert statements for procedure here
	SELECT DISTINCT 
                         tblVPReviews.Review_ID, tblApplications.BDApp_ID, tblApplications.BDApp_Number, tblVPReviews.Review_Date AS RDate, 
                         CASE WHEN tblVPReviews.Review_Date < @now THEN 'R' WHEN tblVPReviews.Review_Date < @fortnight THEN 'A' WHEN tblVPReviews.Review_Date < @fourweeks THEN 'G' ELSE '' END AS RRag, 
                         CASE WHEN tblVPReviews.Review_Description IS NULL THEN '' ELSE tblVPReviews.Review_Description END AS RDescription, CASE WHEN tblVPReviews.Notes IS NULL THEN '' ELSE tblVPReviews.Notes END AS RNotes, 
                         tblVPReviews.Actioned as RActioned
FROM            tblVPReviews INNER JOIN
                         tblApplications ON tblVPReviews.BDApp_Number = tblApplications.BDApp_Number
WHERE        (tblApplications.BDApp_ID = @BDAppID)
ORDER BY tblVPReviews.Actioned, RDate

--SELECT        Work_Item_Start, Work_Item_Description, Work_Item_Target_Date
--FROM            tblVPWWorkOnHand
--WHERE        (BDApp_ID = @BDAppID) AND (Work_Item_Closed_Date IS NULL)
--ORDER BY Work_Item_Start

SELECT        Assyst_Reference AS ASSRef, BDApp_ID, Assyst_Description AS ASSDescription, Assyst_Open AS ASSStart, CASE WHEN Assyst_Open < @afortnight THEN 'R' WHEN Assyst_Open < @aweek THEN 'A' ELSE 'G' END AS ASSRag,
                          Assign_Dev as ASSDev, SLA_Target As ASSSla, Email_Sent as ASSSent, Email_Chased as ASSChased, Assyst_Close as ASSClosed, Notes As ASSNotes, Next_Action_Date as ASSNad, Next_Action as ASSNa, Assyst_Fix As ASSFix
FROM            tblVPAssyst
WHERE        (BDApp_ID = @BDAppID) AND (Assyst_Close IS NULL)
ORDER BY ASSStart

SELECT        tblUsers.Full_Name
FROM            tblVPBDAppOtherDevs INNER JOIN
                         tblUsers ON tblVPBDAppOtherDevs.Other_Dev = tblUsers.PID
WHERE        (tblVPBDAppOtherDevs.BDApp_ID = @BDAppID)
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetReviewFormCombos]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetReviewFormCombos]
	-- Add the parameters for the stored procedure here
	@nBDAppID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        RDes_ID, RDescription, RSOP
FROM            tblVPReviewDescriptions
ORDER BY RDescription

SELECT        Review_ID, Review_Date
FROM            tblVPReviews
WHERE        (BDApp_ID = @nBDAppID)
ORDER BY Review_Date, Review_ID
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetStandardReports]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetStandardReports]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        Report_ID as Rep_ID, Report_Name as RName, Report_Template as RTemp, Report_SP as RSP, Report_Additional_SP as RADDSP, DateFrom AS RFROM, DateTo as RTO
FROM            tblVPStandardReports
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPGetUserDetails]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPGetUserDetails] 
	-- Add the parameters for the stored procedure here
	@PID Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        PID, Full_Name, Active, VP_Admin
FROM            tblUsers
WHERE        (PID = @PID) AND (VP_Admin = 1)
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPSearchApplications]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ===================================================
-- Author:		Liam McGowan 
-- Date: 
-- Description:	Keyword Search the BDApp Database 
-- ===================================================

CREATE PROCEDURE [dbo].[qryVPSearchApplications] 
	@String NVARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
 
SELECT  BDApp_ID	    AS [Search_ID], 
		BDApp_Number    AS [Search_Reference], 
		BDApp_Name		AS [Search_Name], 
		'BDApp Number'  AS [Search_Location]
FROM	lvwBDAppDetail
WHERE   CAST(BDApp_Number AS NVARCHAR) LIKE '%' + @String + '%'

UNION
SELECT	BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'BDApp Name' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   BDApp_Name LIKE '%' + @String + '%'

UNION
SELECT  BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'BDApp Friendly Name' AS [Search_Location]
FROM	lvwBDAppDetail 
WHERE   BDApp_Friendly_Name LIKE '%' + @String + '%'

UNION
SELECT  BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name],'Governing DL' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   Governing_DL LIKE '%' + @String + '%' 

UNION
SELECT	BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'BDApp Admin Contact' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   BDApp_Admin_Contact LIKE '%' + @String + '%'

UNION
SELECT	BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'BDApp Version Number' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   BDApp_Version_Number LIKE '%' + @String + '%'

UNION
SELECT  BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'BDApp Source Folder' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   BDApp_Source_Folder LIKE '%' + @String + '%' 

UNION
SELECT  BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'Status Description' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   Status_Description LIKE '%' + @String + '%' 

UNION
SELECT  BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'User install Location' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   User_Install_Location LIKE '%' + @String + '%' 

UNION
SELECT	BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'Update Process' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   Update_Process LIKE '%' + @String + '%' 

UNION
SELECT  BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'BDApp Command' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   BDApp_Command LIKE '%' + @String + '%' 

UNION
SELECT	BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'BDApp Command Arguments' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   BDApp_Command_Args LIKE '%' + @String + '%' 

UNION
SELECT	BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'SLA Link' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   SLA_Link LIKE '%' + @String + '%'

UNION
SELECT  BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'Directorate'  AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   Directorate LIKE '%' + @String + '%'

UNION
SELECT  BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'Customer Group' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   CGroup LIKE '%' + @String + '%'

UNION
SELECT	BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'Product Owner' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   ProductOwner LIKE '%' + @String + '%'

UNION
SELECT	BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'Business SME' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   BusinessSME LIKE '%' + @String + '%'

UNION
SELECT	BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'Business Contact' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   BusinessContact LIKE '%' + @String + '%'

UNION
SELECT	BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'Lead Developer' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   Full_Name LIKE '%' + @String + '%'

UNION
SELECT	BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'Data Guardian' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   DataGuardian LIKE '%' + @String + '%'

UNION
SELECT	BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'BDApp Name' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   BDAppDescription LIKE '%' + @String + '%'

UNION
SELECT	BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'BDApp Notes' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   BDAppNotes LIKE '%' + @String + '%'

UNION
SELECT	BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'SQL Pre-Production' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   SQLPreProdLocation LIKE '%' + @String + '%'

UNION
SELECT	BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'SQl Live' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   SQLLiveLocation LIKE '%' + @String + '%'

UNION
SELECT  BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'BDApp Folder' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   BDAppFolder LIKE '%' + @String + '%'

UNION
SELECT  BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'Front End Language' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   FrontEndLanguage LIKE '%' + @String + '%'

UNION
SELECT  BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'Back End Language' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   BackEndLanguage LIKE '%' + @String + '%'

UNION
SELECT	BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'DPIA Reference' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   DPIA_Reference LIKE '%' + @String + '%'

UNION
SELECT  BDApp_ID AS [Search_ID], BDApp_Number AS [Search_Reference], BDApp_Name AS [Search_Name], 'DPIA Link' AS [Search_Location]
FROM    lvwBDAppDetail
WHERE   DPIA_Link LIKE '%' + @String + '%'

ORDER BY BDApp_Number

END

GO
/****** Object:  StoredProcedure [dbo].[qryVPSearchAssystCases]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ===================================================
-- Author:		Liam McGowan 
-- Date: 
-- Description:	Keyword Search the Assyst Cases 
--				on the BDApp Database 
-- ===================================================
CREATE PROCEDURE [dbo].[qryVPSearchAssystCases]
	@String NVARCHAR(MAX)
AS
BEGIN
SET NOCOUNT ON;

SELECT	BDApp_ID			AS [Search_ID], 
		Assyst_Reference	AS [Search_Reference], 
		Assyst_Description	AS [Search_Name], 
		'Assyst Reference'	AS [Location]
FROM    tblVPAssyst
WHERE	CAST(Assyst_Reference AS NVARCHAR) LIKE '%' + @String + '%'

UNION 
SELECT	BDApp_ID AS [Search_ID], Assyst_Reference AS [Search_Reference], Assyst_Description AS [Search_Name], 'Assyst Description' AS [Location]
FROM    tblVPAssyst
WHERE   Assyst_Description LIKE '%' + @String + '%'

UNION
SELECT	BDApp_ID AS [Search_ID], Assyst_Reference AS [Search_Reference], Assyst_Description AS [Search_Name], 'Notes' AS [Location]
FROM    tblVPAssyst
WHERE   Notes LIKE '%' + @String + '%'

UNION
SELECT	BDApp_ID AS [Search_ID], Assyst_Reference AS [Search_Reference], Assyst_Description AS [Search_Name], 'Next Action' AS [Location]
FROM    tblVPAssyst
WHERE   Next_Action LIKE '%' + @String + '%'

UNION
SELECT	BDApp_ID AS [Search_ID], Assyst_Reference AS [Search_Reference], Assyst_Description AS [Search_Name], 'Assyst Fix' AS [Location]
FROM    tblVPAssyst
WHERE   Assyst_Fix LIKE '%' + @String + '%'

END
GO
/****** Object:  StoredProcedure [dbo].[qryVPStndAssystReport]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPStndAssystReport] 
	-- Add the parameters for the stored procedure here
	@nFromdate nvarchar(10),
	@nTodate nvarchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT dbo.tblVPAssyst.Assyst_Reference, dbo.tblApplications.BDApp_Number, dbo.tblApplications.BDApp_Name, dbo.tblVPAssyst.Assyst_Description, dbo.tblVPAssyst.Assyst_Open, dbo.tblVPAssyst.Assign_Dev, dbo.tblVPAssyst.SLA_Target, dbo.tblVPAssyst.Email_Sent, dbo.tblVPAssyst.Email_Chased, dbo.tblVPAssyst.Assyst_Close, dbo.tblVPAssyst.Notes, 
         dbo.tblVPAssyst.Next_Action_Date, dbo.tblVPAssyst.Next_Action, CASE WHEN dbo.tblVPAssyst.Assyst_Fix iS NULL THEN 'Awaiting Fix' ELSE dbo.tblVPAssyst.Assyst_Fix END As [Assyst Fix], CASE WHEN dbo.tblVPAssyst.Assyst_Close IS NULL THEN CASE WHEN dbo.tblVPAssyst.SLA_Target < CONVERT(DATETIME, @nTodate, 103) THEN 'Target Passed' ELSE 'Awaiting Target' END WHEN dbo.tblVPAssyst.Assyst_Close > dbo.tblVPAssyst.SLA_Target THEN 'Target Passed' ELSE 'Within Target' END AS RAG
FROM  dbo.tblVPAssyst LEFT OUTER JOIN
         dbo.tblApplications ON tblVPAssyst.BDApp_ID = tblApplications.BDApp_ID
WHERE (dbo.tblVPAssyst.Assyst_Open >= CONVERT(DATETIME, @nFromdate, 103)) AND (dbo.tblVPAssyst.Assyst_Open <= CONVERT(DATETIME, @nTodate, 103))
ORDER BY dbo.tblVPAssyst.Assyst_Close, dbo.tblVPAssyst.Assyst_Open
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPStndDPIAReviewReport]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPStndDPIAReviewReport]
	-- Add the parameters for the stored procedure here
	@nFromdate nvarchar(10),
	@nTodate nvarchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        dbo.tblApplications.BDApp_Number, dbo.tblApplications.BDApp_Name, dbo.tblVPReviews.Review_Date, dbo.tblVPReviews.Review_Description, dbo.tblVPReviews.Notes
FROM            dbo.tblApplications INNER JOIN
                         dbo.tblVPReviews ON dbo.tblApplications.BDApp_ID = dbo.tblVPReviews.BDApp_ID
WHERE        (dbo.tblVPReviews.Actioned IS NULL) AND (dbo.tblVPReviews.Review_Date <= CONVERT(DATETIME, @nTodate, 103)) AND (dbo.tblVPReviews.Review_Description LIKE N'%DPIA%')
ORDER BY dbo.tblVPReviews.Review_Date, dbo.tblApplications.BDApp_Number
END


GO
/****** Object:  StoredProcedure [dbo].[qryVPStndFullReport]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPStndFullReport] 
	-- Add the parameters for the stored procedure here
	@nFromdate date,
	@nTodate date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT dbo.tblApplications.BDApp_ID, dbo.tblApplications.BDApp_Number, dbo.tblApplications.BDApp_Name, dbo.tblApplications.BDApp_Friendly_Name, dbo.tblApplications.Restricted_BDApp, dbo.tblApplications.BDApp_Governing_DL, dbo.tblApplications.BDApp_Admin_Contact, dbo.tblApplications.BDApp_Version_Number, dbo.tblApplications.BDApp_Source_Folder, 
         dbo.tblApplications.BDApp_Status, dbo.tblStatus.Status_Description, dbo.tblApplications.User_Install_Location, dbo.tblUsers.Full_Name AS Updated_By, dbo.tblApplications.Date_Updated, dbo.tblApplications.Update_Process, dbo.tblApplications.BDApp_Command, dbo.tblApplications.BDApp_Command_Args, dbo.tblApplications.Available_Via_Launcher, 
         dbo.tblVPDetails.Directorate, dbo.tblVPDetails.CGroup, dbo.tblVPDetails.BDAppReg, dbo.tblVPDetails.BusinessCriticality, dbo.tblVPDetails.ProductOwner, dbo.tblVPDetails.BusinessSME, dbo.tblVPDetails.BusinessContact, tblUsers_1.Full_Name AS LeadDeveloper, dbo.tblVPDetails.DataGuardian, dbo.tblVPDetails.BDAppDescription, dbo.tblVPDetails.BDAppNotes, 
         dbo.tblVPDetails.SQLPreProdLocation, dbo.tblVPDetails.SQLLiveLocation, dbo.tblVPDetails.BDAppFolder, dbo.tblVPDetails.FrontEndLanguage, dbo.tblVPDetails.BackEndLanguage, dbo.tblUsers.Full_Name
FROM  dbo.tblUsers AS tblUsers_1 RIGHT OUTER JOIN
         dbo.tblVPDetails ON tblUsers_1.PID = dbo.tblVPDetails.LeadDeveloper RIGHT OUTER JOIN
         dbo.tblApplications LEFT OUTER JOIN
         dbo.tblUsers ON tblApplications.Updated_By = tblUsers.PID ON tblApplications.BDApp_ID = tblVPDetails.BDApp_ID LEFT OUTER JOIN
         dbo.tblStatus ON tblApplications.BDApp_Status = tblStatus.Status_ID
END

GO
/****** Object:  StoredProcedure [dbo].[qryVPStndReviewReport]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qryVPStndReviewReport]
	-- Add the parameters for the stored procedure here
	@nFromdate nvarchar(10),
	@nTodate nvarchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT dbo.tblApplications.BDApp_Number, dbo.tblApplications.BDApp_Name, dbo.tblVPReviews.Review_Date, dbo.tblVPReviews.Review_Description, dbo.tblVPReviews.Notes
FROM  dbo.tblApplications INNER JOIN
         dbo.tblVPReviews ON dbo.tblApplications.BDApp_ID = dbo.tblVPReviews.BDApp_ID
WHERE (dbo.tblVPReviews.Actioned IS NULL) AND (dbo.tblVPReviews.Review_Date <= CONVERT(DATETIME, @nTodate, 103))
ORDER BY dbo.tblVPReviews.Review_Date
END

GO
/****** Object:  Table [dbo].[tblApplications]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblApplications](
	[BDApp_ID] [int] IDENTITY(1,1) NOT NULL,
	[BDApp_Number] [int] NOT NULL,
	[BDApp_Name] [nvarchar](255) NOT NULL,
	[BDApp_Friendly_Name] [nvarchar](255) NOT NULL,
	[Restricted_BDApp] [bit] NOT NULL,
	[BDApp_Governing_DL] [int] NULL,
	[BDApp_Admin_Contact] [nvarchar](255) NULL,
	[BDApp_Version_Number] [nvarchar](255) NOT NULL,
	[BDApp_Source_Folder] [nvarchar](max) NULL,
	[BDApp_Status] [int] NOT NULL,
	[User_Install_Location] [nvarchar](max) NOT NULL,
	[Updated_By] [int] NOT NULL,
	[Date_Updated] [date] NOT NULL,
	[Update_Process] [nvarchar](50) NULL,
	[BDApp_Command] [nvarchar](max) NOT NULL,
	[BDApp_Command_Args] [nvarchar](max) NOT NULL,
	[Available_Via_Launcher] [bit] NOT NULL,
 CONSTRAINT [PK_BDApp_ID] PRIMARY KEY CLUSTERED 
(
	[BDApp_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblBDApp_Admin]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBDApp_Admin](
	[BDApp_Admin_ID] [int] IDENTITY(1,1) NOT NULL,
	[BDApp_Number] [int] NOT NULL,
	[BDApp_Admin_PID] [int] NOT NULL,
	[Active_Admin] [bit] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblBDApp_Approvals]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBDApp_Approvals](
	[User_PID] [int] NOT NULL,
	[BDApp_No] [int] NOT NULL,
	[Decision] [nchar](10) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblBDApp_Image]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblBDApp_Image](
	[Image_ID] [int] IDENTITY(1,1) NOT NULL,
	[BDApp_Number] [int] NOT NULL,
	[BDApp_Image] [varbinary](max) NULL,
 CONSTRAINT [PK_BDApp_Image] PRIMARY KEY CLUSTERED 
(
	[BDApp_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblBDApp_Package]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblBDApp_Package](
	[Package_ID] [int] IDENTITY(1,1) NOT NULL,
	[BDApp_Number] [int] NOT NULL,
	[BDApp_Package] [varbinary](max) NULL,
 CONSTRAINT [PK_BDApp_Package] PRIMARY KEY CLUSTERED 
(
	[BDApp_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblGoverning_DLs]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblGoverning_DLs](
	[GDL_ID] [int] IDENTITY(1,1) NOT NULL,
	[Governing_DL] [nvarchar](255) NOT NULL,
	[List_Managers] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tblGoverning_DLs_1] PRIMARY KEY CLUSTERED 
(
	[GDL_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblStatus]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblStatus](
	[Status_ID] [int] IDENTITY(1,1) NOT NULL,
	[Status_Description] [nvarchar](50) NOT NULL,
	[Status_Image] [varbinary](max) NULL,
 CONSTRAINT [PK_tblBDApp_Status] PRIMARY KEY CLUSTERED 
(
	[Status_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUser_Apps]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser_Apps](
	[User_App_ID] [int] IDENTITY(1,1) NOT NULL,
	[PID] [int] NOT NULL,
	[BDApp_ID] [int] NOT NULL,
	[Favourite_App] [bit] NOT NULL,
	[Last_Used_by_User] [date] NOT NULL,
 CONSTRAINT [PK_tbl_User_Apps] PRIMARY KEY CLUSTERED 
(
	[User_App_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsers](
	[PID] [int] NOT NULL,
	[Full_Name] [nvarchar](100) NOT NULL,
	[Active] [bit] NOT NULL,
	[App_Launcher_Admin] [bit] NOT NULL,
	[VP_Admin] [bit] NOT NULL,
 CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED 
(
	[PID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVersionNumber]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVersionNumber](
	[Version_Number] [nvarchar](10) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVPAdminTables]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVPAdminTables](
	[TableName] [nvarchar](50) NOT NULL,
	[tblSQL] [nvarchar](255) NOT NULL,
	[AddUpdateSP] [nvarchar](50) NOT NULL,
	[HideColNos] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVPAssyst]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVPAssyst](
	[Assyst_Reference] [int] NOT NULL,
	[BDApp_ID] [int] NOT NULL,
	[Assyst_Description] [nvarchar](100) NOT NULL,
	[Assyst_Open] [date] NOT NULL,
	[Assign_Dev] [int] NULL,
	[SLA_Target] [date] NOT NULL,
	[Email_Sent] [date] NULL,
	[Email_Chased] [date] NULL,
	[Assyst_Close] [date] NULL,
	[Notes] [nvarchar](100) NULL,
	[Next_Action_Date] [date] NULL,
	[Next_Action] [nvarchar](100) NULL,
	[Assyst_Fix] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblVPAssyst_1] PRIMARY KEY CLUSTERED 
(
	[Assyst_Reference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVPAssystFixes]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVPAssystFixes](
	[Fix_Id] [int] IDENTITY(1,1) NOT NULL,
	[Assyst_Fix] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblVPAssystFixes] PRIMARY KEY CLUSTERED 
(
	[Assyst_Fix] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVPBART_Rank]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVPBART_Rank](
	[BDApp_Number] [int] NOT NULL,
	[BART_Rank] [int] NOT NULL,
 CONSTRAINT [PK_tblVPBART_Prioirty] PRIMARY KEY CLUSTERED 
(
	[BDApp_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVPBARTimport]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVPBARTimport](
	[imp_ID] [int] IDENTITY(1,1) NOT NULL,
	[dbTable] [nvarchar](50) NOT NULL,
	[exFileName] [nvarchar](max) NOT NULL,
	[exImportInstruction] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVPBDAppOtherDevs]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVPBDAppOtherDevs](
	[BDApp_ID] [int] NOT NULL,
	[Other_Dev] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVPBusinessCriticality]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVPBusinessCriticality](
	[Criticality_ID] [int] NOT NULL,
	[Criticality] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_tblVPBusinessCriticality] PRIMARY KEY CLUSTERED 
(
	[Criticality_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVPCompliance]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVPCompliance](
	[BDApp_ID] [int] NOT NULL,
	[GDPR] [bit] NOT NULL,
	[DPIA] [bit] NOT NULL,
	[DPIA_Reference] [nvarchar](50) NULL,
	[DPIA_Link] [nvarchar](max) NULL,
	[SLA] [bit] NOT NULL,
	[SLA_Link] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblVPCompliance] PRIMARY KEY CLUSTERED 
(
	[BDApp_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVPDetails]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVPDetails](
	[BDApp_ID] [int] NOT NULL,
	[Directorate] [nvarchar](50) NULL,
	[CGroup] [nvarchar](50) NULL,
	[BDAppReg] [bit] NOT NULL,
	[BusinessCriticality] [int] NULL,
	[ProductOwner] [nvarchar](100) NULL,
	[BusinessSME] [nvarchar](100) NULL,
	[BusinessContact] [nvarchar](100) NULL,
	[LeadDeveloper] [int] NULL,
	[DataGuardian] [nvarchar](100) NULL,
	[BDAppDescription] [nvarchar](max) NULL,
	[BDAppNotes] [nvarchar](max) NULL,
	[SQLPreProdLocation] [nvarchar](250) NULL,
	[SQLLiveLocation] [nvarchar](250) NULL,
	[BDAppFolder] [nvarchar](250) NULL,
	[FrontEndLanguage] [nvarchar](50) NULL,
	[BackEndLanguage] [nvarchar](50) NULL,
 CONSTRAINT [PK_VPDetails] PRIMARY KEY CLUSTERED 
(
	[BDApp_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVPDirectorate]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVPDirectorate](
	[Directorate_ID] [int] IDENTITY(1,1) NOT NULL,
	[Directorate] [nvarchar](50) NOT NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVPGroup]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVPGroup](
	[Group_ID] [int] IDENTITY(1,1) NOT NULL,
	[Directorate] [nvarchar](50) NOT NULL,
	[CGroup] [nvarchar](50) NOT NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVPKPIs]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVPKPIs](
	[KPI_ID] [int] IDENTITY(1,1) NOT NULL,
	[BDApp_Number] [int] NOT NULL,
	[KPI_Description] [nvarchar](50) NOT NULL,
	[KPI_Link] [nvarchar](255) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVPLanguages]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVPLanguages](
	[LanguageID] [int] IDENTITY(1,1) NOT NULL,
	[ProgLanguage] [nvarchar](50) NOT NULL,
	[FrontEnd] [bit] NOT NULL,
	[BackEnd] [bit] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVPReviewDescriptions]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVPReviewDescriptions](
	[RDes_ID] [int] IDENTITY(1,1) NOT NULL,
	[RDescription] [nvarchar](100) NOT NULL,
	[RSOP] [nvarchar](255) NULL,
 CONSTRAINT [PK_tblReviewDescriptions] PRIMARY KEY CLUSTERED 
(
	[RDescription] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVPReviews]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVPReviews](
	[Review_ID] [int] IDENTITY(1,1) NOT NULL,
	[BDApp_ID] [int] NOT NULL,
	[BDApp_Number] [int] NOT NULL,
	[Review_Date] [date] NOT NULL,
	[Review_Description] [nvarchar](100) NOT NULL,
	[Notes] [nvarchar](max) NULL,
	[Actioned] [date] NULL,
 CONSTRAINT [PK_tblVPReviews] PRIMARY KEY CLUSTERED 
(
	[Review_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVPStandardReports]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVPStandardReports](
	[Report_ID] [int] IDENTITY(1,1) NOT NULL,
	[Report_Name] [nvarchar](100) NOT NULL,
	[Report_Template] [nvarchar](100) NOT NULL,
	[Report_SP] [nvarchar](100) NOT NULL,
	[Report_Additional_SP] [nvarchar](100) NULL,
	[DateTo] [bit] NOT NULL,
	[DateFrom] [bit] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVPWWorkOnHand]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVPWWorkOnHand](
	[Work_Item_ID] [int] IDENTITY(1,1) NOT NULL,
	[BDApp_ID] [int] NOT NULL,
	[Work_Item_Description] [nvarchar](max) NOT NULL,
	[Work_Item_Start] [date] NOT NULL,
	[Work_Item_Target_Date] [date] NOT NULL,
	[Work_Item_Closed_Date] [date] NULL,
	[CSharp] [bit] NOT NULL,
	[SQL] [bit] NOT NULL,
	[MSAccess] [bit] NOT NULL,
	[MSExcel] [bit] NOT NULL,
	[PowerBI] [bit] NOT NULL,
	[VBA] [bit] NOT NULL,
	[SEES] [bit] NOT NULL,
 CONSTRAINT [PK_tblVPWWorkOnHand] PRIMARY KEY CLUSTERED 
(
	[Work_Item_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmpAppInfo$]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpAppInfo$](
	[BDApp Ref] [float] NULL,
	[CDIO Registered] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Directorate] [nvarchar](255) NULL,
	[Cgroup] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[Front end] [nvarchar](255) NULL,
	[Back end] [nvarchar](255) NULL,
	[Server Info (if necessary)] [nvarchar](255) NULL,
	[Type] [nvarchar](255) NULL,
	[Support] [nvarchar](255) NULL,
	[Notes] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmpBARTRank$]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpBARTRank$](
	[BDAppReg] [float] NULL,
	[InherentRiskClassification] [nvarchar](255) NULL,
	[ResidualRiskClassification] [nvarchar](255) NULL,
	[InherentRisk] [float] NULL,
	[ResidualRisk] [float] NULL,
	[PriorityRankingInherent] [float] NULL,
	[PriorityRankingResidual] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmpContactDetails$]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpContactDetails$](
	[BDApp Ref] [float] NULL,
	[CDIO Registered] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Directorate] [nvarchar](255) NULL,
	[Cgroup] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[Product Owner] [nvarchar](255) NULL,
	[Business SME] [nvarchar](255) NULL,
	[Business Contact] [nvarchar](255) NULL,
	[Dev1] [nvarchar](255) NULL,
	[Dev2] [nvarchar](255) NULL,
	[Notes] [nvarchar](255) NULL,
	[Emailed SPOC?] [datetime] NULL,
	[BART Skype Arranged?] [nvarchar](255) NULL,
	[Staff set up on BART] [datetime] NULL,
	[BART setup] [datetime] NULL,
	[BART Completed] [datetime] NULL,
	[BART RAG] [nvarchar](255) NULL,
	[F19] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmpContactlist]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpContactlist](
	[BDApp] [int] NULL,
	[AppName] [nvarchar](255) NULL,
	[AKA] [nvarchar](255) NULL,
	[Type] [nvarchar](255) NULL,
	[Cont] [nvarchar](128) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmpDetails$]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpDetails$](
	[BDApp Ref] [float] NULL,
	[CDIO Registered] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Directorate] [nvarchar](255) NULL,
	[Cgroup] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[Type] [nvarchar](255) NULL,
	[Support] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmpLive BDApps]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpLive BDApps](
	[BDApp Reference] [float] NULL,
	[Application Name] [nvarchar](255) NULL,
	[AKA] [nvarchar](255) NULL,
	[Last Business Contact] [nvarchar](255) NULL,
	[Practitioner] [nvarchar](255) NULL,
	[Criticality] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmpLive_Cases]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpLive_Cases](
	[PPGRef] [int] NOT NULL,
	[BDApp] [int] NULL,
	[AppName] [nvarchar](255) NULL,
	[AKA] [nvarchar](255) NULL,
	[Criticality] [tinyint] NULL,
	[Description] [nvarchar](max) NULL,
	[NoOfUsers] [int] NULL,
	[MultiOfficeUse] [bit] NOT NULL,
	[Excel] [bit] NOT NULL,
	[ExcelVBA] [bit] NOT NULL,
	[Word] [bit] NOT NULL,
	[WordVBA] [bit] NOT NULL,
	[AccessApplication] [bit] NOT NULL,
	[AccessVBA] [bit] NOT NULL,
	[VB6] [bit] NOT NULL,
	[DAOorADO] [bit] NOT NULL,
	[OtherTool] [bit] NOT NULL,
	[Business_Contact] [nvarchar](50) NULL,
	[Closed] [datetime] NULL,
	[Directorate] [nvarchar](100) NULL,
	[Owner] [nvarchar](128) NULL,
	[Received] [datetime] NULL,
	[DLocation] [nvarchar](10) NULL,
	[Practitioner] [nvarchar](30) NULL,
	[Support] [nvarchar](24) NULL,
	[Full_Server_Path] [nvarchar](255) NULL,
	[App_Path] [nvarchar](255) NULL,
	[Install_Path] [nvarchar](255) NULL,
	[Notes] [nvarchar](max) NULL,
	[DSTest] [nvarchar](50) NULL,
	[DSDate] [datetime] NULL,
	[LID] [datetime] NULL,
	[WorkType] [nvarchar](30) NULL,
	[CSData] [bit] NOT NULL,
	[PNUsers] [bit] NOT NULL,
	[Standards] [bit] NOT NULL,
	[Benefits] [money] NULL,
	[EImpDate] [datetime] NULL,
	[Percentage] [int] NULL,
	[Status] [nvarchar](12) NULL,
	[OneOff] [money] NULL,
	[ACSCriticality] [nvarchar](20) NULL,
	[ACSPlatform] [nvarchar](20) NULL,
	[ACSConTyp] [nvarchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmpLocations$]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpLocations$](
	[BDApp Ref] [float] NULL,
	[CDIO Registered] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Directorate] [nvarchar](255) NULL,
	[Cgroup] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[Live Location] [nvarchar](255) NULL,
	[BDApp CAF?] [nvarchar](255) NULL,
	[Details of any dependencies] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmpMaster]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpMaster](
	[Reference ] [float] NULL,
	[Summary] [nvarchar](255) NULL,
	[Assigned To Dev:] [nvarchar](255) NULL,
	[Date] [datetime] NULL,
	[SLA Date] [datetime] NULL,
	[Acknowled# email sent] [nvarchar](255) NULL,
	[Chase email sent] [datetime] NULL,
	[Date resolved:] [nvarchar](255) NULL,
	[Notes] [nvarchar](255) NULL,
	[Next Action Due] [nvarchar](255) NULL,
	[Next Action Name] [nvarchar](255) NULL,
	[F12] [nvarchar](255) NULL,
	[F13] [nvarchar](255) NULL,
	[F14] [nvarchar](255) NULL,
	[F15] [nvarchar](255) NULL,
	[F16] [nvarchar](255) NULL,
	[F17] [nvarchar](255) NULL,
	[F18] [nvarchar](255) NULL,
	[F19] [nvarchar](255) NULL,
	[F20] [nvarchar](255) NULL,
	[F21] [nvarchar](255) NULL,
	[F22] [nvarchar](255) NULL,
	[F23] [nvarchar](255) NULL,
	[F24] [nvarchar](255) NULL,
	[F25] [nvarchar](255) NULL,
	[F26] [nvarchar](255) NULL,
	[F27] [nvarchar](255) NULL,
	[F28] [nvarchar](255) NULL,
	[F29] [nvarchar](255) NULL,
	[F30] [nvarchar](255) NULL,
	[F31] [nvarchar](255) NULL,
	[F32] [nvarchar](255) NULL,
	[F33] [nvarchar](255) NULL,
	[F34] [nvarchar](255) NULL,
	[F35] [nvarchar](255) NULL,
	[F36] [nvarchar](255) NULL,
	[F37] [nvarchar](255) NULL,
	[F38] [nvarchar](255) NULL,
	[F39] [nvarchar](255) NULL,
	[F40] [nvarchar](255) NULL,
	[F41] [nvarchar](255) NULL,
	[F42] [nvarchar](255) NULL,
	[F43] [nvarchar](255) NULL,
	[F44] [nvarchar](255) NULL,
	[F45] [nvarchar](255) NULL,
	[F46] [nvarchar](255) NULL,
	[F47] [nvarchar](255) NULL,
	[F48] [nvarchar](255) NULL,
	[F49] [nvarchar](255) NULL,
	[F50] [nvarchar](255) NULL,
	[F51] [nvarchar](255) NULL,
	[F52] [nvarchar](255) NULL,
	[F53] [nvarchar](255) NULL,
	[F54] [nvarchar](255) NULL,
	[F55] [nvarchar](255) NULL,
	[F56] [nvarchar](255) NULL,
	[F57] [nvarchar](255) NULL,
	[F58] [nvarchar](255) NULL,
	[F59] [nvarchar](255) NULL,
	[F60] [nvarchar](255) NULL,
	[F61] [nvarchar](255) NULL,
	[F62] [nvarchar](255) NULL,
	[F63] [nvarchar](255) NULL,
	[F64] [nvarchar](255) NULL,
	[F65] [nvarchar](255) NULL,
	[F66] [nvarchar](255) NULL,
	[F67] [nvarchar](255) NULL,
	[F68] [nvarchar](255) NULL,
	[F69] [nvarchar](255) NULL,
	[F70] [nvarchar](255) NULL,
	[F71] [nvarchar](255) NULL,
	[F72] [nvarchar](255) NULL,
	[F73] [nvarchar](255) NULL,
	[F74] [nvarchar](255) NULL,
	[F75] [nvarchar](255) NULL,
	[F76] [nvarchar](255) NULL,
	[F77] [nvarchar](255) NULL,
	[F78] [nvarchar](255) NULL,
	[F79] [nvarchar](255) NULL,
	[F80] [nvarchar](255) NULL,
	[F81] [nvarchar](255) NULL,
	[F82] [nvarchar](255) NULL,
	[F83] [nvarchar](255) NULL,
	[F84] [nvarchar](255) NULL,
	[F85] [nvarchar](255) NULL,
	[F86] [nvarchar](255) NULL,
	[F87] [nvarchar](255) NULL,
	[F88] [nvarchar](255) NULL,
	[F89] [nvarchar](255) NULL,
	[F90] [nvarchar](255) NULL,
	[F91] [nvarchar](255) NULL,
	[F92] [nvarchar](255) NULL,
	[F93] [nvarchar](255) NULL,
	[F94] [nvarchar](255) NULL,
	[F95] [nvarchar](255) NULL,
	[F96] [nvarchar](255) NULL,
	[F97] [nvarchar](255) NULL,
	[F98] [nvarchar](255) NULL,
	[F99] [nvarchar](255) NULL,
	[F100] [nvarchar](255) NULL,
	[F101] [nvarchar](255) NULL,
	[F102] [nvarchar](255) NULL,
	[F103] [nvarchar](255) NULL,
	[F104] [nvarchar](255) NULL,
	[F105] [nvarchar](255) NULL,
	[F106] [nvarchar](255) NULL,
	[F107] [nvarchar](255) NULL,
	[F108] [nvarchar](255) NULL,
	[F109] [nvarchar](255) NULL,
	[F110] [nvarchar](255) NULL,
	[F111] [nvarchar](255) NULL,
	[F112] [nvarchar](255) NULL,
	[F113] [nvarchar](255) NULL,
	[F114] [nvarchar](255) NULL,
	[F115] [nvarchar](255) NULL,
	[F116] [nvarchar](255) NULL,
	[F117] [nvarchar](255) NULL,
	[F118] [nvarchar](255) NULL,
	[F119] [nvarchar](255) NULL,
	[F120] [nvarchar](255) NULL,
	[F121] [nvarchar](255) NULL,
	[F122] [nvarchar](255) NULL,
	[F123] [nvarchar](255) NULL,
	[F124] [nvarchar](255) NULL,
	[F125] [nvarchar](255) NULL,
	[F126] [nvarchar](255) NULL,
	[F127] [nvarchar](255) NULL,
	[F128] [nvarchar](255) NULL,
	[F129] [nvarchar](255) NULL,
	[F130] [nvarchar](255) NULL,
	[F131] [nvarchar](255) NULL,
	[F132] [nvarchar](255) NULL,
	[F133] [nvarchar](255) NULL,
	[F134] [nvarchar](255) NULL,
	[F135] [nvarchar](255) NULL,
	[F136] [nvarchar](255) NULL,
	[F137] [nvarchar](255) NULL,
	[F138] [nvarchar](255) NULL,
	[F139] [nvarchar](255) NULL,
	[F140] [nvarchar](255) NULL,
	[F141] [nvarchar](255) NULL,
	[F142] [nvarchar](255) NULL,
	[F143] [nvarchar](255) NULL,
	[F144] [nvarchar](255) NULL,
	[F145] [nvarchar](255) NULL,
	[F146] [nvarchar](255) NULL,
	[F147] [nvarchar](255) NULL,
	[F148] [nvarchar](255) NULL,
	[F149] [nvarchar](255) NULL,
	[F150] [nvarchar](255) NULL,
	[F151] [nvarchar](255) NULL,
	[F152] [nvarchar](255) NULL,
	[F153] [nvarchar](255) NULL,
	[F154] [nvarchar](255) NULL,
	[F155] [nvarchar](255) NULL,
	[F156] [nvarchar](255) NULL,
	[F157] [nvarchar](255) NULL,
	[F158] [nvarchar](255) NULL,
	[F159] [nvarchar](255) NULL,
	[F160] [nvarchar](255) NULL,
	[F161] [nvarchar](255) NULL,
	[F162] [nvarchar](255) NULL,
	[F163] [nvarchar](255) NULL,
	[F164] [nvarchar](255) NULL,
	[F165] [nvarchar](255) NULL,
	[F166] [nvarchar](255) NULL,
	[F167] [nvarchar](255) NULL,
	[F168] [nvarchar](255) NULL,
	[F169] [nvarchar](255) NULL,
	[F170] [nvarchar](255) NULL,
	[F171] [nvarchar](255) NULL,
	[F172] [nvarchar](255) NULL,
	[F173] [nvarchar](255) NULL,
	[F174] [nvarchar](255) NULL,
	[F175] [nvarchar](255) NULL,
	[F176] [nvarchar](255) NULL,
	[F177] [nvarchar](255) NULL,
	[F178] [nvarchar](255) NULL,
	[F179] [nvarchar](255) NULL,
	[F180] [nvarchar](255) NULL,
	[F181] [nvarchar](255) NULL,
	[F182] [nvarchar](255) NULL,
	[F183] [nvarchar](255) NULL,
	[F184] [nvarchar](255) NULL,
	[F185] [nvarchar](255) NULL,
	[F186] [nvarchar](255) NULL,
	[F187] [nvarchar](255) NULL,
	[F188] [nvarchar](255) NULL,
	[F189] [nvarchar](255) NULL,
	[F190] [nvarchar](255) NULL,
	[F191] [nvarchar](255) NULL,
	[F192] [nvarchar](255) NULL,
	[F193] [nvarchar](255) NULL,
	[F194] [nvarchar](255) NULL,
	[F195] [nvarchar](255) NULL,
	[F196] [nvarchar](255) NULL,
	[F197] [nvarchar](255) NULL,
	[F198] [nvarchar](255) NULL,
	[F199] [nvarchar](255) NULL,
	[F200] [nvarchar](255) NULL,
	[F201] [nvarchar](255) NULL,
	[F202] [nvarchar](255) NULL,
	[F203] [nvarchar](255) NULL,
	[F204] [nvarchar](255) NULL,
	[F205] [nvarchar](255) NULL,
	[F206] [nvarchar](255) NULL,
	[F207] [nvarchar](255) NULL,
	[F208] [nvarchar](255) NULL,
	[F209] [nvarchar](255) NULL,
	[F210] [nvarchar](255) NULL,
	[F211] [nvarchar](255) NULL,
	[F212] [nvarchar](255) NULL,
	[F213] [nvarchar](255) NULL,
	[F214] [nvarchar](255) NULL,
	[F215] [nvarchar](255) NULL,
	[F216] [nvarchar](255) NULL,
	[F217] [nvarchar](255) NULL,
	[F218] [nvarchar](255) NULL,
	[F219] [nvarchar](255) NULL,
	[F220] [nvarchar](255) NULL,
	[F221] [nvarchar](255) NULL,
	[F222] [nvarchar](255) NULL,
	[F223] [nvarchar](255) NULL,
	[F224] [nvarchar](255) NULL,
	[F225] [nvarchar](255) NULL,
	[F226] [nvarchar](255) NULL,
	[F227] [nvarchar](255) NULL,
	[F228] [nvarchar](255) NULL,
	[F229] [nvarchar](255) NULL,
	[F230] [nvarchar](255) NULL,
	[F231] [nvarchar](255) NULL,
	[F232] [nvarchar](255) NULL,
	[F233] [nvarchar](255) NULL,
	[F234] [nvarchar](255) NULL,
	[F235] [nvarchar](255) NULL,
	[F236] [nvarchar](255) NULL,
	[F237] [nvarchar](255) NULL,
	[F238] [nvarchar](255) NULL,
	[F239] [nvarchar](255) NULL,
	[F240] [nvarchar](255) NULL,
	[F241] [nvarchar](255) NULL,
	[F242] [nvarchar](255) NULL,
	[F243] [nvarchar](255) NULL,
	[F244] [nvarchar](255) NULL,
	[F245] [nvarchar](255) NULL,
	[F246] [nvarchar](255) NULL,
	[F247] [nvarchar](255) NULL,
	[F248] [nvarchar](255) NULL,
	[F249] [nvarchar](255) NULL,
	[F250] [nvarchar](255) NULL,
	[F251] [nvarchar](255) NULL,
	[F252] [nvarchar](255) NULL,
	[F253] [nvarchar](255) NULL,
	[F254] [nvarchar](255) NULL,
	[F255] [nvarchar](255) NULL,
	[F256] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmptblCriticality]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmptblCriticality](
	[Criticality] [int] NOT NULL,
	[desc] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmptblDirectorate]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmptblDirectorate](
	[DirNames] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmptblImpHistory]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmptblImpHistory](
	[HPPGRef] [int] NULL,
	[HCRRef] [int] NULL,
	[ActionDate] [datetime] NULL,
	[EstImpDate] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmptblPerHistory]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmptblPerHistory](
	[HPPGRef] [int] NULL,
	[HCRRef] [int] NULL,
	[ActionDate] [datetime] NULL,
	[Percentage] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmptblPractitioner]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmptblPractitioner](
	[PractName] [nvarchar](30) NULL,
	[PType] [int] NULL,
	[PID] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmptblStatus]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmptblStatus](
	[Status_ID] [int] IDENTITY(1,1) NOT NULL,
	[Status_Description] [nvarchar](50) NOT NULL,
	[Status_Image] [varbinary](max) NULL,
 CONSTRAINT [PK_tmptblBDApp_Status] PRIMARY KEY CLUSTERED 
(
	[Status_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmptblSupport]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmptblSupport](
	[Support_type] [nvarchar](24) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmptblWork]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmptblWork](
	[PPGRef] [int] NOT NULL,
	[BDApp] [int] NULL,
	[AppName] [nvarchar](255) NULL,
	[AKA] [nvarchar](255) NULL,
	[Criticality] [tinyint] NULL,
	[Description] [nvarchar](max) NULL,
	[NoOfUsers] [int] NULL,
	[MultiOfficeUse] [bit] NOT NULL,
	[Excel] [bit] NOT NULL,
	[ExcelVBA] [bit] NOT NULL,
	[Word] [bit] NOT NULL,
	[WordVBA] [bit] NOT NULL,
	[AccessApplication] [bit] NOT NULL,
	[AccessVBA] [bit] NOT NULL,
	[VB6] [bit] NOT NULL,
	[DAOorADO] [bit] NOT NULL,
	[OtherTool] [bit] NOT NULL,
	[Business_Contact] [nvarchar](50) NULL,
	[Closed] [datetime] NULL,
	[Directorate] [nvarchar](100) NULL,
	[Owner] [nvarchar](128) NULL,
	[Received] [datetime] NULL,
	[DLocation] [nvarchar](10) NULL,
	[Practitioner] [nvarchar](30) NULL,
	[Support] [nvarchar](24) NULL,
	[Full_Server_Path] [nvarchar](255) NULL,
	[App_Path] [nvarchar](255) NULL,
	[Install_Path] [nvarchar](255) NULL,
	[Notes] [nvarchar](max) NULL,
	[DSTest] [nvarchar](50) NULL,
	[DSDate] [datetime] NULL,
	[LID] [datetime] NULL,
	[WorkType] [nvarchar](30) NULL,
	[CSData] [bit] NOT NULL,
	[PNUsers] [bit] NOT NULL,
	[Standards] [bit] NOT NULL,
	[Benefits] [money] NULL,
	[EImpDate] [datetime] NULL,
	[Percentage] [int] NULL,
	[Status] [nvarchar](12) NULL,
	[OneOff] [money] NULL,
	[ACSCriticality] [nvarchar](20) NULL,
	[ACSPlatform] [nvarchar](20) NULL,
	[ACSConTyp] [nvarchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[lvwAppImages]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE VIEW [dbo].[lvwAppImages]
AS
SELECT        dbo.tblApplications.BDApp_ID, dbo.tblBDApp_Image.BDApp_Number, dbo.tblBDApp_Image.BDApp_Image
FROM            dbo.tblApplications LEFT OUTER JOIN
                         dbo.tblBDApp_Image ON dbo.tblApplications.BDApp_Number = dbo.tblBDApp_Image.BDApp_Number
WHERE        (NOT (dbo.tblBDApp_Image.BDApp_Number IS NULL))
UNION
SELECT        dbo.tblApplications.BDApp_ID, dbo.tblApplications.BDApp_Number, dbo.tblBDApp_Image.BDApp_Image
FROM            dbo.tblApplications CROSS JOIN
                         dbo.tblBDApp_Image
WHERE        (dbo.tblApplications.BDApp_Number NOT IN
                             (SELECT        BDApp_Number
                               FROM            dbo.tblBDApp_Image AS tblBDApp_Image_1)) AND (dbo.tblBDApp_Image.BDApp_Number = 0)

GO
/****** Object:  View [dbo].[lvwBDAppDetail]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[lvwBDAppDetail]
AS
SELECT DISTINCT 
         dbo.tblApplications.BDApp_ID, dbo.tblApplications.BDApp_Number, dbo.tblApplications.BDApp_Name, dbo.tblApplications.BDApp_Friendly_Name, dbo.tblApplications.Restricted_BDApp, dbo.tblGoverning_DLs.Governing_DL, dbo.tblApplications.BDApp_Admin_Contact, dbo.tblApplications.BDApp_Version_Number, dbo.tblApplications.BDApp_Source_Folder, 
         dbo.tblStatus.Status_Description, dbo.tblApplications.User_Install_Location, dbo.tblApplications.Update_Process, dbo.tblApplications.BDApp_Command, dbo.tblApplications.BDApp_Command_Args, dbo.tblApplications.Available_Via_Launcher, dbo.tblVPCompliance.GDPR, dbo.tblVPCompliance.DPIA, dbo.tblVPCompliance.SLA, dbo.tblVPCompliance.SLA_Link, 
         dbo.tblVPDetails.Directorate, dbo.tblVPDetails.CGroup, dbo.tblVPDetails.BusinessCriticality, dbo.tblVPDetails.BDAppReg, dbo.tblVPDetails.ProductOwner, dbo.tblVPDetails.BusinessSME, dbo.tblVPDetails.BusinessContact, dbo.tblUsers.Full_Name, dbo.tblVPDetails.DataGuardian, dbo.tblVPDetails.BDAppDescription, dbo.tblVPDetails.BDAppNotes, 
         dbo.tblVPDetails.SQLPreProdLocation, dbo.tblVPDetails.SQLLiveLocation, dbo.tblVPDetails.BDAppFolder, dbo.tblVPDetails.FrontEndLanguage, dbo.tblVPDetails.BackEndLanguage, dbo.tblVPBART_Rank.BART_Rank, dbo.tblVPCompliance.DPIA_Reference, dbo.tblVPCompliance.DPIA_Link
FROM  dbo.tblApplications LEFT OUTER JOIN
         dbo.tblVPBART_Rank ON dbo.tblApplications.BDApp_Number = dbo.tblVPBART_Rank.BDApp_Number LEFT OUTER JOIN
         dbo.tblStatus ON dbo.tblApplications.BDApp_Status = dbo.tblStatus.Status_ID LEFT OUTER JOIN
         dbo.tblGoverning_DLs ON dbo.tblApplications.BDApp_Governing_DL = dbo.tblGoverning_DLs.GDL_ID LEFT OUTER JOIN
         dbo.tblVPCompliance ON dbo.tblApplications.BDApp_ID = dbo.tblVPCompliance.BDApp_ID LEFT OUTER JOIN
         dbo.tblVPDetails ON dbo.tblApplications.BDApp_ID = dbo.tblVPDetails.BDApp_ID LEFT OUTER JOIN
         dbo.tblUsers ON dbo.tblVPDetails.LeadDeveloper = dbo.tblUsers.PID

GO
/****** Object:  View [dbo].[lvwNextBDAppReview]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[lvwNextBDAppReview]
AS
SELECT        dbo.tblApplications.BDApp_ID, MIN(dbo.tblVPReviews.Review_Date) AS Next_Review_Date
FROM            dbo.tblApplications INNER JOIN
                         dbo.tblVPReviews ON dbo.tblApplications.BDApp_ID = dbo.tblVPReviews.BDApp_ID
WHERE        (dbo.tblVPReviews.Actioned IS NULL)
GROUP BY dbo.tblApplications.BDApp_ID

GO
/****** Object:  View [dbo].[lvwUserFavourites]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[lvwUserFavourites]
AS
SELECT        dbo.tblUsers.PID, dbo.tblUsers.Full_Name, dbo.tblUsers.Active, dbo.tblUsers.App_Launcher_Admin, dbo.tblApplications.BDApp_Number, dbo.tblApplications.BDApp_Name, dbo.tblApplications.BDApp_Friendly_Name, 
                         dbo.tblUser_Apps.Last_Used_by_User, dbo.tblApplications.Restricted_BDApp, dbo.tblApplications.BDApp_Governing_DL, dbo.tblApplications.BDApp_Admin_Contact, dbo.tblApplications.BDApp_Version_Number, 
                         dbo.tblApplications.BDApp_Source_Folder, dbo.tblApplications.BDApp_Status, dbo.tblApplications.User_Install_Location, dbo.tblApplications.Available_Via_Launcher
FROM            dbo.tblUsers INNER JOIN
                         dbo.tblUser_Apps ON dbo.tblUsers.PID = dbo.tblUser_Apps.PID INNER JOIN
                         dbo.tblApplications ON dbo.tblUser_Apps.BDApp_ID = dbo.tblApplications.BDApp_ID
WHERE        (dbo.tblUser_Apps.Favourite_App = 1)

GO
/****** Object:  View [dbo].[lvwUsersBDApps]    Script Date: 22/04/2020 13:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[lvwUsersBDApps]
AS
SELECT        dbo.tblUsers.PID, dbo.tblUsers.Full_Name, dbo.tblUsers.Active, dbo.tblUsers.App_Launcher_Admin, dbo.tblUser_Apps.BDApp_ID, dbo.tblUser_Apps.Last_Used_by_User, dbo.tblApplications.BDApp_Number, 
                         dbo.tblApplications.BDApp_Name, dbo.tblApplications.BDApp_Friendly_Name, dbo.tblApplications.Restricted_BDApp, dbo.tblApplications.BDApp_Governing_DL, dbo.tblApplications.BDApp_Admin_Contact, 
                         dbo.tblApplications.BDApp_Version_Number, dbo.tblApplications.BDApp_Source_Folder, dbo.tblApplications.BDApp_Status, dbo.tblApplications.Updated_By, dbo.tblApplications.Date_Updated, 
                         dbo.tblApplications.Update_Process, dbo.tblApplications.User_Install_Location, dbo.tblApplications.Available_Via_Launcher
FROM            dbo.tblUsers INNER JOIN
                         dbo.tblUser_Apps ON dbo.tblUsers.PID = dbo.tblUser_Apps.PID INNER JOIN
                         dbo.tblApplications ON dbo.tblUser_Apps.BDApp_ID = dbo.tblApplications.BDApp_ID

GO
ALTER TABLE [dbo].[tblApplications] ADD  CONSTRAINT [DF_tblApplications_Updated_By]  DEFAULT ((9999999)) FOR [Updated_By]
GO
ALTER TABLE [dbo].[tblApplications] ADD  CONSTRAINT [DF_tblApplications_Date_Updated]  DEFAULT ('01/01/1900') FOR [Date_Updated]
GO
ALTER TABLE [dbo].[tblApplications] ADD  CONSTRAINT [DF_tblApplications_BDApp_Executable]  DEFAULT ('') FOR [BDApp_Command]
GO
ALTER TABLE [dbo].[tblApplications] ADD  DEFAULT ((0)) FOR [Available_Via_Launcher]
GO
ALTER TABLE [dbo].[tblBDApp_Admin] ADD  CONSTRAINT [DF_tblBDApp_Admin_Active_Admin]  DEFAULT ((1)) FOR [Active_Admin]
GO
ALTER TABLE [dbo].[tblUser_Apps] ADD  CONSTRAINT [DF_tbl_User_Apps_Favourite_App]  DEFAULT ((0)) FOR [Favourite_App]
GO
ALTER TABLE [dbo].[tblUsers] ADD  CONSTRAINT [DF_tblUsers_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[tblUsers] ADD  CONSTRAINT [DF_Table_1_Admin]  DEFAULT ((0)) FOR [App_Launcher_Admin]
GO
ALTER TABLE [dbo].[tblUsers] ADD  CONSTRAINT [DF_tblUsers_VP_Admin]  DEFAULT ((0)) FOR [VP_Admin]
GO
ALTER TABLE [dbo].[tblVPBARTimport] ADD  CONSTRAINT [DF_tblBARTimport_exSheetName]  DEFAULT ('') FOR [exImportInstruction]
GO
ALTER TABLE [dbo].[tblVPDetails] ADD  CONSTRAINT [DF_VPDetails_BDAppReg]  DEFAULT ((0)) FOR [BDAppReg]
GO
ALTER TABLE [dbo].[tblVPDirectorate] ADD  CONSTRAINT [DF_tblVPDirectorate_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[tblVPGroup] ADD  CONSTRAINT [DF_tblVPGroup_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[tblVPLanguages] ADD  CONSTRAINT [DF_tblVPLanguages_FrontEnd]  DEFAULT ((0)) FOR [FrontEnd]
GO
ALTER TABLE [dbo].[tblVPLanguages] ADD  CONSTRAINT [DF_tblVPLanguages_BackEnd]  DEFAULT ((0)) FOR [BackEnd]
GO
ALTER TABLE [dbo].[tblVPReviews] ADD  CONSTRAINT [DF__tblVPRevi__BDApp__55DFB4D9]  DEFAULT ((1)) FOR [BDApp_ID]
GO
ALTER TABLE [dbo].[tblVPWWorkOnHand] ADD  CONSTRAINT [DF_tblVPWWorkOnHand_CSharp]  DEFAULT ((0)) FOR [CSharp]
GO
ALTER TABLE [dbo].[tblVPWWorkOnHand] ADD  CONSTRAINT [DF_tblVPWWorkOnHand_SQL]  DEFAULT ((0)) FOR [SQL]
GO
ALTER TABLE [dbo].[tblVPWWorkOnHand] ADD  CONSTRAINT [DF_tblVPWWorkOnHand_MSAccess]  DEFAULT ((0)) FOR [MSAccess]
GO
ALTER TABLE [dbo].[tblVPWWorkOnHand] ADD  CONSTRAINT [DF_Table_1_Excel]  DEFAULT ((0)) FOR [MSExcel]
GO
ALTER TABLE [dbo].[tblVPWWorkOnHand] ADD  CONSTRAINT [DF_tblVPWWorkOnHand_PowerBI]  DEFAULT ((0)) FOR [PowerBI]
GO
ALTER TABLE [dbo].[tblVPWWorkOnHand] ADD  CONSTRAINT [DF_tblVPWWorkOnHand_VBA]  DEFAULT ((0)) FOR [VBA]
GO
ALTER TABLE [dbo].[tblVPWWorkOnHand] ADD  CONSTRAINT [DF_tblVPWWorkOnHand_SEES]  DEFAULT ((0)) FOR [SEES]
GO
ALTER TABLE [dbo].[tblApplications]  WITH CHECK ADD  CONSTRAINT [FK_Governing_DL] FOREIGN KEY([BDApp_Governing_DL])
REFERENCES [dbo].[tblGoverning_DLs] ([GDL_ID])
GO
ALTER TABLE [dbo].[tblApplications] CHECK CONSTRAINT [FK_Governing_DL]
GO
ALTER TABLE [dbo].[tblApplications]  WITH CHECK ADD  CONSTRAINT [FK_Status] FOREIGN KEY([BDApp_Status])
REFERENCES [dbo].[tblStatus] ([Status_ID])
GO
ALTER TABLE [dbo].[tblApplications] CHECK CONSTRAINT [FK_Status]
GO
ALTER TABLE [dbo].[tblUser_Apps]  WITH CHECK ADD  CONSTRAINT [FK_BDApp_ID] FOREIGN KEY([BDApp_ID])
REFERENCES [dbo].[tblApplications] ([BDApp_ID])
GO
ALTER TABLE [dbo].[tblUser_Apps] CHECK CONSTRAINT [FK_BDApp_ID]
GO
ALTER TABLE [dbo].[tblUser_Apps]  WITH CHECK ADD  CONSTRAINT [FK_PID] FOREIGN KEY([PID])
REFERENCES [dbo].[tblUsers] ([PID])
GO
ALTER TABLE [dbo].[tblUser_Apps] CHECK CONSTRAINT [FK_PID]
GO