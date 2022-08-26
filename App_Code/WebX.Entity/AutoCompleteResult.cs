using System.Runtime.Serialization;

namespace WebX.Entity
{
    [DataContract]
    public class AutoCompleteResult
    {
        [DataMember]
        public string Value { get; set; }
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string Description { get; set; }
        [DataMember]
        public string Alias { get; set; }

        public AutoCompleteResult()
        {
            Name = "";
            Value = "";
            Description = "";
            Alias = "";
        }
    }
}