namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tblVPGroup")]
    public partial class tblVPGroup
    {
        [Key]
        [Column(Order = 0)]
        public int Group_ID { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string Directorate { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(50)]
        public string CGroup { get; set; }

        [Key]
        [Column(Order = 3)]
        public bool Active { get; set; }
    }
}
