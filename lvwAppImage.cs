namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class lvwAppImage
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int BDApp_ID { get; set; }

        public int? BDApp_Number { get; set; }

        public byte[] BDApp_Image { get; set; }
    }
}
