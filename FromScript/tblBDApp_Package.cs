namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tblBDApp_Package
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Package_ID { get; set; }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int BDApp_Number { get; set; }

        public byte[] BDApp_Package { get; set; }
    }
}
