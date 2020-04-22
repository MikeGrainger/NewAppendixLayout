namespace NewAppendixLayout
{
	using System;
	using System.Data.Entity;
	using System.ComponentModel.DataAnnotations.Schema;
	using System.Linq;

	public partial class Model1 : DbContext
	{
		public Model1()
			: base("name=Model1")
		{
		}

		public virtual DbSet<tblAPPendix> tblAPPendixes { get; set; }
		public virtual DbSet<tblApplication> tblApplications { get; set; }
		public virtual DbSet<tblBDApp_Image> tblBDApp_Image { get; set; }
		public virtual DbSet<tblBDApp_Package> tblBDApp_Package { get; set; }
		public virtual DbSet<tblGoverning_DLs> tblGoverning_DLs { get; set; }
		public virtual DbSet<tblStatus> tblStatus { get; set; }
		public virtual DbSet<tblUser_Apps> tblUser_Apps { get; set; }
		public virtual DbSet<tblUser> tblUsers { get; set; }
		public virtual DbSet<tblVPAssyst> tblVPAssysts { get; set; }
		public virtual DbSet<tblVPAssystFix> tblVPAssystFixes { get; set; }
		public virtual DbSet<tblVPBART_Rank> tblVPBART_Rank { get; set; }
		public virtual DbSet<tblVPBusinessCriticality> tblVPBusinessCriticalities { get; set; }
		public virtual DbSet<tblVPCompliance> tblVPCompliances { get; set; }
		public virtual DbSet<tblVPDetail> tblVPDetails { get; set; }
		public virtual DbSet<tblVPReviewDescription> tblVPReviewDescriptions { get; set; }
		public virtual DbSet<tblVPReview> tblVPReviews { get; set; }
		public virtual DbSet<tblVPWWorkOnHand> tblVPWWorkOnHands { get; set; }
		public virtual DbSet<tmptblStatu> tmptblStatus { get; set; }
		public virtual DbSet<tblBDApp_Admin> tblBDApp_Admin { get; set; }
		public virtual DbSet<tblBDApp_Approvals> tblBDApp_Approvals { get; set; }
		public virtual DbSet<tblVersionNumber> tblVersionNumbers { get; set; }
		public virtual DbSet<tblVPAdminTable> tblVPAdminTables { get; set; }
		public virtual DbSet<tblVPBARTimport> tblVPBARTimports { get; set; }
		public virtual DbSet<tblVPBDAppOtherDev> tblVPBDAppOtherDevs { get; set; }
		public virtual DbSet<tblVPDirectorate> tblVPDirectorates { get; set; }
		public virtual DbSet<tblVPGroup> tblVPGroups { get; set; }
		public virtual DbSet<tblVPKPI> tblVPKPIs { get; set; }
		public virtual DbSet<tblVPLanguage> tblVPLanguages { get; set; }
		public virtual DbSet<tblVPStandardReport> tblVPStandardReports { get; set; }
		public virtual DbSet<tmpLive_Cases> tmpLive_Cases { get; set; }
		public virtual DbSet<tmptblCriticality> tmptblCriticalities { get; set; }
		public virtual DbSet<tmptblWork> tmptblWorks { get; set; }
		public virtual DbSet<lvwAppImage> lvwAppImages { get; set; }
		public virtual DbSet<lvwNextBDAppReview> lvwNextBDAppReviews { get; set; }
		public virtual DbSet<lvwUserFavourite> lvwUserFavourites { get; set; }
		public virtual DbSet<lvwUsersBDApp> lvwUsersBDApps { get; set; }
		public virtual DbSet<v_tblAPPendix> v_tblAPPendix { get; set; }
		public virtual DbSet<v_tblStatus> v_tblStatus { get; set; }

		protected override void OnModelCreating(DbModelBuilder modelBuilder)
		{
			modelBuilder.Entity<tblAPPendix>()
				.Property(e => e.BDAPPNo)
				.HasPrecision(18, 0);

			modelBuilder.Entity<tblAPPendix>()
				.Property(e => e.BDAPPName)
				.IsFixedLength();

			modelBuilder.Entity<tblAPPendix>()
				.Property(e => e.BDAPPFriendlyName)
				.IsFixedLength();

			modelBuilder.Entity<tblAPPendix>()
				.Property(e => e.BDAPPMasterVersionNumber)
				.IsFixedLength();

			modelBuilder.Entity<tblAPPendix>()
				.Property(e => e.BDAPPStatus)
				.IsFixedLength();

			modelBuilder.Entity<tblApplication>()
				.HasMany(e => e.tblUser_Apps)
				.WithRequired(e => e.tblApplication)
				.WillCascadeOnDelete(false);

			modelBuilder.Entity<tblGoverning_DLs>()
				.HasMany(e => e.tblApplications)
				.WithOptional(e => e.tblGoverning_DLs)
				.HasForeignKey(e => e.BDApp_Governing_DL);

			modelBuilder.Entity<tblStatus>()
				.Property(e => e.BDAPPStatus)
				.IsFixedLength();

			modelBuilder.Entity<tblUser>()
				.HasMany(e => e.tblUser_Apps)
				.WithRequired(e => e.tblUser)
				.WillCascadeOnDelete(false);

			modelBuilder.Entity<tblBDApp_Approvals>()
				.Property(e => e.Decision)
				.IsFixedLength();

			modelBuilder.Entity<tmpLive_Cases>()
				.Property(e => e.Benefits)
				.HasPrecision(19, 4);

			modelBuilder.Entity<tmpLive_Cases>()
				.Property(e => e.OneOff)
				.HasPrecision(19, 4);

			modelBuilder.Entity<tmptblWork>()
				.Property(e => e.Benefits)
				.HasPrecision(19, 4);

			modelBuilder.Entity<tmptblWork>()
				.Property(e => e.OneOff)
				.HasPrecision(19, 4);

			modelBuilder.Entity<v_tblAPPendix>()
				.Property(e => e.BDAPPNo)
				.HasPrecision(18, 0);

			modelBuilder.Entity<v_tblAPPendix>()
				.Property(e => e.BDAPPName)
				.IsFixedLength();

			modelBuilder.Entity<v_tblAPPendix>()
				.Property(e => e.BDAPPFriendlyName)
				.IsFixedLength();

			modelBuilder.Entity<v_tblAPPendix>()
				.Property(e => e.BDAPPMasterVersionNumber)
				.IsFixedLength();

			modelBuilder.Entity<v_tblAPPendix>()
				.Property(e => e.BDAPPStatus)
				.IsFixedLength();

			modelBuilder.Entity<v_tblStatus>()
				.Property(e => e.BDAPPStatus)
				.IsFixedLength();
		}
	}
}
