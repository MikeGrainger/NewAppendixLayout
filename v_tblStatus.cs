namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class v_tblStatus
    {
        [Key]
        public int MainIDStatus { get; set; }

        [StringLength(32)]
        public string BDAPPStatus { get; set; }
    }
}
