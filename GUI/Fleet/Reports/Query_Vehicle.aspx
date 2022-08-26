<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="Query_Vehicle.aspx.cs" Inherits="GUI_MIS_Vehicle_Register_Query_Vehicle" %>
<%@ Register TagName="CMPFT" TagPrefix="Company" Src="~/GUI/Common_UserControls/CompayFilter.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

 <script language="javascript" type="text/javascript">
     
         function cust(ID)
        {
         ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        } 
        
   function OnSub_DATACHECK()
    {
       var DDlocation=document.getElementById("ctl00_MyCPH1_DDlocation");
        var DDVehicle=document.getElementById("ctl00_MyCPH1_DDVehicle");
         var txtVehno=document.getElementById("ctl00_MyCPH1_txtVehno");
      var ddlCompanyList=document.getElementById("ctl00$MyCPH1$CMPFT1$ddlCompanyList");

       window.open("Query_Vehicle_Result.aspx?location=" + DDlocation.value + "&vehicleno=" + DDVehicle.value + "&vehlist=" + txtVehno.value + "&Company_Code=" + ddlCompanyList.value + "");

      //return false;

        
    }
    </script>


   <br />
    <br />
    <table align="Left" border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 50%; ">
       <tr class="bgbluegrey">
            <td align="center" colspan="2" class="blackfnt">
               Vehicle Register Report </td>
        </tr>
        <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                        <td class="blackfnt" >
                            <asp:Label ID="Label1"  Font-Bold="True" CssClass="blackfnt" Text="Select Company" runat="server"></asp:Label>
                        </td>
                        <td align="left" valign="top"  >
                           <Company:CMPFT ID="CMPFT1" runat="server" />
                       </td>
                    </tr> 
                      
        <tr style="background-color: white">
            <td class="blackfnt">                &nbsp;Select Location</td>
            <td class="blackfnt" >
                &nbsp;<asp:DropDownList ID="DDlocation" runat="server">
                    
                </asp:DropDownList>&nbsp;</td>
        </tr>
         <tr style="background-color: white">
            <td class="blackfnt">                &nbsp;Select Vehicle</td>
            <td class="blackfnt" >
                &nbsp;<asp:DropDownList ID="DDVehicle" runat="server">
                    
                </asp:DropDownList>&nbsp;</td>
        </tr>
        
         <tr align="center" style="background-color: white">
            <td class="blackfnt" colspan="2">OR</td>
           
        </tr>
        
        <tr style="background-color: white">
            <td class="blackfnt">                &nbsp;Enter  Vehicle No.</td>
            <td class="blackfnt" >&nbsp;<asp:TextBox ID="txtVehno"  runat="server" Width="272px"></asp:TextBox>
                </td>
        </tr>
        
        
        
        
         <tr style="background-color: white">
            <td align="center" colspan="2">
             
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                    <ContentTemplate>   
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit"   OnClientClick="Javascript: return OnSub_DATACHECK();" />
                   </ContentTemplate>
                                                  
                                                </asp:UpdatePanel></td>
        </tr>
    </table>


</asp:Content>