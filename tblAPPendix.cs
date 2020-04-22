namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tblAPPendix")]
    public partial class tblAPPendix
    {
        [Key]
        public int MainID { get; set; }

        [Column(TypeName = "numeric")]
        public decimal? BDAPPNo { get; set; }

        [StringLength(32)]
        public string BDAPPName { get; set; }

        [StringLength(32)]
        public string BDAPPFriendlyName { get; set; }

        [StringLength(10)]
        public string BDAPPMasterVersionNumber { get; set; }

        [StringLength(10)]
        public string BDAPPStatus { get; set; }
    }
}
