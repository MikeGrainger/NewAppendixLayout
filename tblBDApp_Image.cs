namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tblBDApp_Image
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Image_ID { get; set; }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int BDApp_Number { get; set; }

        public byte[] BDApp_Image { get; set; }
    }
}
