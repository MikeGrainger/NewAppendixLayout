namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tblVPAdminTable
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(50)]
        public string TableName { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(255)]
        public string tblSQL { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(50)]
        public string AddUpdateSP { get; set; }

        [StringLength(50)]
        public string HideColNos { get; set; }
    }
}
