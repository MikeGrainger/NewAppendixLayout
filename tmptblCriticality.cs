namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tmptblCriticality")]
    public partial class tmptblCriticality
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Criticality { get; set; }

        [StringLength(100)]
        public string desc { get; set; }
    }
}
