namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tblApplication
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tblApplication()
        {
            tblUser_Apps = new HashSet<tblUser_Apps>();
        }

        [Key]
        public int BDApp_ID { get; set; }

        public int BDApp_Number { get; set; }

        [Required]
        [StringLength(255)]
        public string BDApp_Name { get; set; }

        [Required]
        [StringLength(255)]
        public string BDApp_Friendly_Name { get; set; }

        public bool Restricted_BDApp { get; set; }

        public int? BDApp_Governing_DL { get; set; }

        [StringLength(255)]
        public string BDApp_Admin_Contact { get; set; }

        [Required]
        [StringLength(255)]
        public string BDApp_Version_Number { get; set; }

        public string BDApp_Source_Folder { get; set; }

        public int BDApp_Status { get; set; }

        [Required]
        public string User_Install_Location { get; set; }

        public int Updated_By { get; set; }

        [Column(TypeName = "date")]
        public DateTime Date_Updated { get; set; }

        [StringLength(50)]
        public string Update_Process { get; set; }

        [Required]
        public string BDApp_Command { get; set; }

        [Required]
        public string BDApp_Command_Args { get; set; }

        public bool Available_Via_Launcher { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tblUser_Apps> tblUser_Apps { get; set; }

        public virtual tblGoverning_DLs tblGoverning_DLs { get; set; }
    }
}
