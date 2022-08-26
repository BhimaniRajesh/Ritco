using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace WebX.Entity
{
    /// <summary>
    ///  Get POD Link Response
    /// </summary>
    [DataContract]
    public class PODLinkResponse
    {
        [DataMember]
        public bool IsSuccess { get; set; }
        [DataMember]
        public string ErrorMessage { get; set; }
        [DataMember]
        public string PODLink { get; set; }

    }

}
