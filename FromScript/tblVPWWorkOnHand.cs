namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tblVPWWorkOnHand")]
    public partial class tblVPWWorkOnHand
    {
        [Key]
        public int Work_Item_ID { get; set; }

        public int BDApp_ID { get; set; }

        [Required]
        public string Work_Item_Description { get; set; }

        [Column(TypeName = "date")]
        public DateTime Work_Item_Start { get; set; }

        [Column(TypeName = "date")]
        public DateTime Work_Item_Target_Date { get; set; }

        [Column(TypeName = "date")]
        public DateTime? Work_Item_Closed_Date { get; set; }

        public bool CSharp { get; set; }

        public bool SQL { get; set; }

        public bool MSAccess { get; set; }

        public bool MSExcel { get; set; }

        public bool PowerBI { get; set; }

        public bool VBA { get; set; }

        public bool SEES { get; set; }
    }
}
