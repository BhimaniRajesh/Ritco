<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="ReceiverMaster.aspx.cs" Inherits="ReceiverMasterAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>

    <script language="javascript" type="text/javascript">
/*************************************************************************************************************
*  CHECK LOCATION
/*************************************************************************************************************/        
function checkLocation(id)
{    
    var obj = document.getElementById(id);              
    obj.value = obj.value.toUpperCase();    
     
    var hdnLocation = document.getElementById("ctl00_MyCPH1_hdnLocation");
    var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");    
    
    if (obj.value != "")
    { 
       var objXMLHttpObject = false;
       objXMLHttpObject = GetXMLHttpObject();          

        if(objXMLHttpObject)
        {      
             hdnajaxstate.value = "1";               
             var boolLocationCode = "../AjaxResponse.aspx?mode=check&code1=locationcode&code2=" + obj.value + "&sid=" + Math.random() + "&sid2" + Math.random(); 
             objXMLHttpObject.open("GET", boolLocationCode);
   
             objXMLHttpObject.onreadystatechange = function()
             {                       
                 if((objXMLHttpObject.readyState == 4) && (objXMLHttpObject.status == 200))
                 {                                      
                      var result = objXMLHttpObject.responseText.split("|");                   
                        
                      if(result[0] == "false")
                      {                         
                          alert(result[1]);                                                           
                          obj.focus();  
                          obj.value = "";
                          hdnajaxstate.value = "0"; 
                          hdnLocation.value = "False";                   
                          return false;  
                      }
                      else
                      {
                          hdnajaxstate.value = "0";
                          hdnLocation.value = "True"; 
                          return true;
                      }                           
                }
            }                  
            objXMLHttpObject.send(null);
        }        
    }  
    return true;
}

/*************************************************************************************************************
*   VALIDATION FOR ALL INPUT WHEN SUBMIT BUTTON CLICK
/*************************************************************************************************************/             
function btnSubmitCheck()
{ 
       
        var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");  
        if(hdnajaxstate.value != "0")
        {
            alert("Let the Internal Processes Over. Please wait 5-10 seconds or LogOut.");
            return false;
        } 
        
        var txtReceiverName = document.getElementById("ctl00_MyCPH1_txtReceiverName");   
        if(txtReceiverName.value == "")
        {
                alert("Please Enter Receiver Name.");
                txtReceiverName.focus();
                return false;
        }   
	        
	    var txtCstLoc = document.getElementById("ctl00_MyCPH1_txtCstLoc");  
        if(txtCstLoc.value == "")
        {
                alert("Please enter Location.");
                txtCstLoc.focus();
                return false;
        }	    
        
        
       if(!confirm("Are you sure you want to Submit this Record ?"))
            return false;
                      
        return true;          
}
    </script>

    <asp:Panel runat="server" HorizontalAlign="left" Style="width: 10in" ID="pnlMain">
        <br />
        <br />
        <asp:Table ID="tblMain" runat="server" HorizontalAlign="center" CssClass="boxbg"
            CellSpacing="1" BorderWidth="0" Width="100%" BorderStyle="Groove">
            <asp:TableRow CssClass="bgbluegrey" VerticalAlign="Middle">
                <asp:TableCell HorizontalAlign="center" CssClass="blackfnt" ColumnSpan="4" Style="height: 20px;">
                                                        <b>RECEIVER MASTER</b></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                <asp:TableCell HorizontalAlign="left">
                    Receiver Code</asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                    <asp:Label ID="lblReceiverCode" CssClass="redfnt" runat="server">&lt;System Generated&gt;</asp:Label></asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                    <font color="red">*</font> Receiver Name
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                    <asp:TextBox ID="txtReceiverName" runat="server" CssClass="blackfnt" Width="125px"
                        MaxLength="248" BorderStyle="Groove" TabIndex="1" onkeypress="javascript:return withoutQuote(event)"
                        Onblur="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                <asp:TableCell HorizontalAlign="left">
                   <font color="red">*</font> Location</asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                    <asp:TextBox ID="txtCstLoc" runat="server" BorderStyle="Groove" MaxLength="13" CssClass="blackfnt"
                        Width="125px" TabIndex="2" onkeypress="javascript:return withoutQuote(event)"
                        onblur="javascript:return checkLocation(this.getAttribute('id'))">
                    </asp:TextBox>
                    <%--       <atlas:AutoCompleteExtender ID="extLocation" runat="server">
                        <atlas:AutoCompleteProperties Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetLocationList"
                            ServicePath="../../services/WebService.asmx" TargetControlID="txtCstLoc" />
                    </atlas:AutoCompleteExtender>--%>
                    <ajaxToolkit:AutoCompleteExtender ID="extLocation" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                        ServiceMethod="GetLocationList" ServicePath="../../services/WebService.asmx" TargetControlID="txtCstLoc">
                    </ajaxToolkit:AutoCompleteExtender>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                    Active Flag 
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                    <asp:CheckBox ID="chkActiveFlag" runat="server" CssClass="blackfnt" Checked="true"
                        TabIndex="3" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey" VerticalAlign="Middle">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="4">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="blackfnt" OnClick="btnSubmit_Click"
                        TabIndex="4" OnClientClick="Javascript:return btnSubmitCheck();" /></asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
    <asp:HiddenField ID="hdnLocation" runat="server" Value="0" />
    <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
</asp:Content>
