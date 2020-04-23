namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tblVPDirectorate")]
    public partial class tblVPDirectorate
    {
        [Key]
        [Column(Order = 0)]
        public int Directorate_ID { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string Directorate { get; set; }

        [Key]
        [Column(Order = 2)]
        public bool Active { get; set; }
    }
}
