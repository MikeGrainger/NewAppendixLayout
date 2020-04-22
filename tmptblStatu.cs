namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tmptblStatu
    {
        [Key]
        public int Status_ID { get; set; }

        [Required]
        [StringLength(50)]
        public string Status_Description { get; set; }

        public byte[] Status_Image { get; set; }
    }
}
