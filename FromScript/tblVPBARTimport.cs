namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tblVPBARTimport")]
    public partial class tblVPBARTimport
    {
        [Key]
        [Column(Order = 0)]
        public int imp_ID { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string dbTable { get; set; }

        [Key]
        [Column(Order = 2)]
        public string exFileName { get; set; }

        [Key]
        [Column(Order = 3)]
        public string exImportInstruction { get; set; }
    }
}
