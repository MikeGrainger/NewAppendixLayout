namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tblVPBusinessCriticality")]
    public partial class tblVPBusinessCriticality
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Criticality_ID { get; set; }

        [Required]
        [StringLength(255)]
        public string Criticality { get; set; }
    }
}
