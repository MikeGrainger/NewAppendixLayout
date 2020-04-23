namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tblVPCompliance")]
    public partial class tblVPCompliance
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int BDApp_ID { get; set; }

        public bool GDPR { get; set; }

        public bool DPIA { get; set; }

        [StringLength(50)]
        public string DPIA_Reference { get; set; }

        public string DPIA_Link { get; set; }

        public bool SLA { get; set; }

        public string SLA_Link { get; set; }
    }
}
