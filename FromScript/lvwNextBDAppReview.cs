namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("lvwNextBDAppReview")]
    public partial class lvwNextBDAppReview
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int BDApp_ID { get; set; }

        [Column(TypeName = "date")]
        public DateTime? Next_Review_Date { get; set; }
    }
}
