namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tblVPKPI
    {
        [Key]
        [Column(Order = 0)]
        public int KPI_ID { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int BDApp_Number { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(50)]
        public string KPI_Description { get; set; }

        [Key]
        [Column(Order = 3)]
        [StringLength(255)]
        public string KPI_Link { get; set; }
    }
}
