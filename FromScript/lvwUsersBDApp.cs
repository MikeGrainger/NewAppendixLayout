namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class lvwUsersBDApp
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int PID { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(100)]
        public string Full_Name { get; set; }

        [Key]
        [Column(Order = 2)]
        public bool Active { get; set; }

        [Key]
        [Column(Order = 3)]
        public bool App_Launcher_Admin { get; set; }

        [Key]
        [Column(Order = 4)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int BDApp_ID { get; set; }

        [Key]
        [Column(Order = 5, TypeName = "date")]
        public DateTime Last_Used_by_User { get; set; }

        [Key]
        [Column(Order = 6)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int BDApp_Number { get; set; }

        [Key]
        [Column(Order = 7)]
        [StringLength(255)]
        public string BDApp_Name { get; set; }

        [Key]
        [Column(Order = 8)]
        [StringLength(255)]
        public string BDApp_Friendly_Name { get; set; }

        [Key]
        [Column(Order = 9)]
        public bool Restricted_BDApp { get; set; }

        public int? BDApp_Governing_DL { get; set; }

        [StringLength(255)]
        public string BDApp_Admin_Contact { get; set; }

        [Key]
        [Column(Order = 10)]
        [StringLength(255)]
        public string BDApp_Version_Number { get; set; }

        public string BDApp_Source_Folder { get; set; }

        [Key]
        [Column(Order = 11)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int BDApp_Status { get; set; }

        [Key]
        [Column(Order = 12)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Updated_By { get; set; }

        [Key]
        [Column(Order = 13, TypeName = "date")]
        public DateTime Date_Updated { get; set; }

        [StringLength(50)]
        public string Update_Process { get; set; }

        [Key]
        [Column(Order = 14)]
        public string User_Install_Location { get; set; }

        [Key]
        [Column(Order = 15)]
        public bool Available_Via_Launcher { get; set; }
    }
}
