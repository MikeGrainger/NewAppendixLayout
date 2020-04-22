namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_tblAPPendix
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
