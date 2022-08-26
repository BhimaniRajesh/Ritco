<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="callreg_inter.aspx.cs" Inherits="SFM_callreg_inter" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
       
<%--<script language="javascript" type="text/javascript">

function Pick_onclick(arg1,arg2)
 {
    //window.open("Popup-ProspectCust.aspx","ABC","location=1,status=1,scrollbars=1"); 
    //window.open("./Popup-ProspectCust.aspx?" + arg1 + "," + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"); 
    window.open("./Popup-ProspectCust.aspx?" + arg1 + "," + arg2) 
   
  //window.close();
}


</script>--%>

<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
            <font class="blackfnt"><%=callvisit%> Entry</font>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        <br />

<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="right" style="height: 33px">
                        <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../images/back.gif" /></a>
                    </td>
                </tr>
            </table>
            <br />
    <div align="center">

    <%--<atlas:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />--%>
        
    
       
        <%--<table style="left: 152px; width: 536px; position: relative; top: 16px; height: 16px;">
            <tr>
                <td style="width: 3px; height: 30px;">
                   <font class="bluefnt">Prospect/CustomeId
                   </font>
                </td>
                
            </tr>
            <tr>
                <td style="width: 3px; height: 30px;">
                </td>
                
            </tr>
          
        </table>
        <asp:Button ID="btnSubmit" runat="server" Height="24px" Style="left: 360px; position: relative;
            top: -14px" Text="Submit" Width="80px" OnClick="Button1_Click" />
        <br />
       
        <asp:TextBox ID="txtProspectId" runat="server" Height="20px" Style="left: 328px; position: relative;
            top: -70px" Width="250px"></asp:TextBox>
            <atlas:AutoCompleteExtender runat="server" ID="Extender1"  >
              <atlas:AutoCompleteProperties Enabled="True"
            TargetControlID="txtProspectId"
            ServiceMethod="GetBlogProspectTitlesForAutoComplete"
            ServicePath="~/Service/AutoCompleteSFM.asmx" MinimumPrefixLength="1"  />
            </atlas:AutoCompleteExtender>
            &nbsp;<%--<input id="btnPick" type="button" value="..." onclick="return Pick_onclick()" style="left: 328px; width: 24px; position: relative; top: -70px; height: 24px" /><br />
    --%>
    
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                            cols="1" width="85%">
                            <%--<tr class="bgbluegrey">
                                                        <td align="center" colspan="5">
                                                            <font class="blackfnt"><strong>Please Select Appointment</strong></font></td>
                                                    </tr>--%>
                            
                
                
                <tr bgcolor="white">
                    <td align="left" class="field1" style="width: 136px; height: 21px;">
                         <font class="blackfnt">Prospect/Customer Id.</font>
                    </td>
                    <td align="left" style="width: 138px; height: 21px;">
                    <asp:TextBox ID="txtCustCode" runat="server" Width="60px"></asp:TextBox>                                            
                    <input id="btnCust" type="button" name="" runat="server"/>
                    </td>
                </tr>
                
                
                
          </table>
          <br />
        <table align="center" cellspacing="1" cellpadding="1" width="85%" border="0">
        <tr bgcolor="white" align="center">
                    
                    <td style="width: 138px; height: 22px;" colspan="6">
                         <asp:Button ID="Button1" runat="server" Height="24px" Text="Submit" Width="80px" style="left: 342px; position: relative; top: -1px" OnClick="Button1_Click" />
                    </td>
                </tr>
        </table>
        
        </div>
</asp:Content>
