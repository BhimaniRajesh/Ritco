<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"   CodeFile="DriverRegister.aspx.cs" Inherits="Reports_DriverRegister" %>

 
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    
 <%--     <script language="Javascript"  >
function checkEvent ()
{
 
 var ddlDname = document.getElementById("ctl00$MyCPH1$ddlDname").value;
 
 var txtDname = document.getElementById("ctl00$MyCPH1$txtDriverName").value;

alert(ddlDname)
alert(txtDname)
}
 

//  if(ddlDname=="" && txtDname=="")

//  {

//   alert("Driver Name is Compulsory!!!")
//   
//    return false;

//   }
//   } 
    </script>--%>
    
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports >Driver Register Report</asp:Label>
               <%-- <hr align="center" size="1" color="#8ba0e5"> --%>
            </td> 
            
             <td align="right">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/images/indicator.gif" />
                    <font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
      <br> 
      <p align="center">
      <table cellspacing="1" width="600px">
            <tr align="center">
                <td>  
       <table cellspacing="1" cellpadding="2" class="boxbg" width="600px">
                    <tr class="bgbluegrey">
                            <td colspan="3" align="center">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                        </tr>
                       
                        
                       
                                              <tr style="background-color: white">
                            <td align="left" colspan="1"  >
                                <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Select Location</asp:Label></td>
                               <asp:RequiredFieldValidator ID="RFVProductType" runat="server" ControlToValidate="ddlLocation"
                        ErrorMessage="*" ForeColor="red"></asp:RequiredFieldValidator>
                        <td  align="left" colspan="2" >
                           
                           <asp:DropDownList ID="ddlLocation" CssClass="blackfnt" runat="server"   Width="132px"></asp:DropDownList>
                                                      </td>
                        </tr>
                           <tr style="background-color: white">
                            <td align="left" colspan="1">
                               <asp:Label ID="lblLExpires" CssClass="blackfnt" runat="server" Font-Bold="True">License expires within next</asp:Label></td>
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtLExpiry" SetFocusOnError="true" Display="Dynamic"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                           <asp:RegularExpressionValidator ID="REVSalesDt3" runat="server" ControlToValidate="txtLExpiry"   SetFocusOnError="true" Display="Dynamic"
                        ErrorMessage="!" ValidationExpression="([0-9]*)"
                        Width="1px"></asp:RegularExpressionValidator>
                        <td align="left" colspan="2">
                               &nbsp;<asp:TextBox ID="txtLExpiry" CssClass="input" runat="server"  Width="121px"></asp:TextBox>
                               </td>
                        </tr>
                          <tr style="background-color: white">
                            <td align="left" colspan="1">
                                <asp:Label ID="lblDName" CssClass="blackfnt" runat="server" Font-Bold="True">Select Driver Name</asp:Label></td>
                           <td align="left" colspan="2" >
                           
                   <asp:DropDownList ID="ddlDname" CssClass="blackfnt" runat="server"  Width="134px"></asp:DropDownList>
                           
                           
                           
                           
                           </td>
                        </tr>
                        
                          <tr style="background-color: white" align="center">
                          <td align="center" colspan="3">
                          <asp:Label ID="lblOR" CssClass="blackfnt" runat="server" Font-Bold="True" Font-Size="10">OR</asp:Label>
                          </td>
                          </tr>
                         <tr style="background-color: white" align="center">
                                                                                  <td align="left"  colspan="1">
                                 <asp:Label ID="lblDriverName" CssClass="blackfnt"     runat="server" Text="Enter Driver Name"  Font-Bold="True"></asp:Label>
                                                              </td>
                            <td align="left" colspan="2">
                                &nbsp;<asp:TextBox ID="txtDriverName" runat="server"  CssClass="input" > 
                                 
                             </asp:TextBox>
                                </td>
                             
                        </tr>
                        	   
                          <tr style="background-color: white">
                            <td align="right" colspan="3">
                                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                           <asp:Label ID="lblErrMsg" runat="server" Text="" CssClass="blackfnt" Font-Bold="true" ForeColor="red" Visible="false"></asp:Label>  
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit"   OnClick="btnSubmit_Click" /> 
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                    </table>
                          </td>
            </tr>
        </table>

<br />
 <table cellspacing="1" style="width: 100%">
        <tr align="center">
            <td align="center">
                &nbsp;<asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True"  
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            PageSize="50"  OnPageIndexChanging="pgChange" >
                            <Columns>
                   <asp:BoundField   DataField="Driver_Id" HeaderText="Driver Code"   />
                           
                                <asp:BoundField DataField="Driver_Name" HeaderText="Driver Name">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Driver_Location" HeaderText="Location">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="P_Address" HeaderText="Permanent Address">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="C_Address" HeaderText="Current Address">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="License_No" HeaderText="License No"  />
                                      <asp:BoundField DataField="Issue_By_RTO" HeaderText="Issued By"  />
                                <asp:BoundField DataField="ValidityDt" HeaderText="Validity Date"  />
                              <asp:BoundField DataField="ADDRESS_PRROF" HeaderText="Address Proof Document Type & No">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>     
                                 <asp:BoundField DataField="ID_PRROF" HeaderText="ID Proof Document Type & No">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>  
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                  <%--  </ContentTemplate>
                    <Triggers>
                        <atlas:ControlEventTrigger ControlID="btnSubmit" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>--%>
            </td>
        </tr>
    </table>
</p>
 <P align="center">
  <table >
  <tr style="background-color: white">
  <td align="center" style="height: 21px">
    <asp:LinkButton ID="LinkButton1" Visible="false"  Font-Bold="true" runat="server" OnClick="LinkButton1_Click">Transform To XLS</asp:LinkButton>
  </td>
      
  </tr>
  </table>
  </p> 
   </ContentTemplate>
                   <%-- <Triggers>
                        <asp:ControlEventTrigger ControlID="btnSubmit" EventName="Click" />
                    </Triggers>--%>

    </asp:UpdatePanel>
</asp:Content>