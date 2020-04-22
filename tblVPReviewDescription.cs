namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tblVPReviewDescription
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int RDes_ID { get; set; }

        [Key]
        [StringLength(100)]
        public string RDescription { get; set; }

        [StringLength(255)]
        public string RSOP { get; set; }
    }
}
