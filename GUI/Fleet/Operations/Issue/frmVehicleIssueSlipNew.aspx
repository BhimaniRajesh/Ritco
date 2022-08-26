<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmVehicleIssueSlipNew.aspx.cs" Inherits="Issue_frmVehicleIssueSlipNew" %>
<%@ Register TagPrefix="DateCalendar" TagName="Header" Src="~/DateCalendar.ascx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


<script language="javascript">


function fnCheckSel(intObjId)
{
//ctl00_MyCPH1_DataGrid1_ctl02_chksel
 var strSceTypeId; 
 strSceTypeId = intObjId + "1"
 for (var i=1; i<document.forms(0).length; i++) 
  { 
     if(document.forms(0).elements[i].id )
      { 
        if(document.forms(0).elements[i].id.indexOf("chksel")!=-1)
         {
            //alert(document.forms(0).elements[i].id ); 
            /*if (document.forms(0).elements[i].id.indexOf("chksel")==-1)
             { 
                alert("hi")
                document.forms(0).elements[i].checked=false
              }*/
              document.forms(0).elements[i].checked=false
         }
      }
  } 
 document.getElementById(intObjId).checked=true
}


function fnCheckVal(intObjId)
{
 var found_it ;
 for (var i=1; i<document.forms(0).length; i++)   
   { 
      if(document.forms(0).elements[i].id )
       { 
        if(document.forms(0).elements[i].id.indexOf("chksel")!=-1) 
         {
            if (document.forms(0).elements[i].checked)
             {// Set the flag if any radio button is checked
                found_it = true;
                break;
             }
         }
       }
   } 
 
 if(!found_it)
 {
  alert("Select atleast one request");
  return false;
 }
 else 
 {
   return true;
 } 
}

</script>

 <p align="center">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Sheet >> Issue New with Request</asp:Label>
               <%-- <hr align="center" size="1" color="#8ba0e5">--%>
            </td>
            
             <td align=right>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color=red><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>      
        </tr>
    </table>
    </p>
    <hr align="center" size="1" color="#8ba0e5">
      <br/> 
      
      <p align="center">
      <table cellspacing="1" cellpadding="3" style="width: 95%" align=center class="boxbg" border="0">
            
            <tr style="background-color: white">
                <td colspan="4" align="center">
                    <asp:Label ID="lblError"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor=red></asp:Label></td>
                           
                    
            </tr>
            
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="NEW TRIP SHEET FORM"></asp:Label></td>
                           
                    
            </tr>
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Trip Sheet Id</font>
                </td>
                <td align="left">
                   <font class=blackfnt color=red>< System generated ></font>
                </td>
                <td align="left">
                <font class=bluefnt>Trip Sheet Date</font>
                </td>
                <td align="left">
               <DateCalendar:header id="DtCal" runat="server" ></DateCalendar:header>
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Manual Trip Sheet No.</font>
                </td>
                <td align="left" colspan=3>
                   <font class=blackfnt >
                   <asp:TextBox ID="txtManualTripSheetNo" runat=server BorderStyle="Groove" Width="100" MaxLength="10" CssClass="input" OnTextChanged="Check_ManualTripSheetNo" AutoPostBack=true></asp:TextBox>
                     <asp:RequiredFieldValidator ID="ReqManualTripSheetNo" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtManualTripSheetNo"></asp:RequiredFieldValidator>
                     
                      <asp:UpdatePanel ID="UpdatePanel2" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Label ID="lblMTS" runat=server CssClass="balckfnt" ForeColor=red></asp:Label>
                     </ContentTemplate>
                     <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtManualTripSheetNo" EventName="TextChanged" />
                    </Triggers>
                    </asp:UpdatePanel> 
                   </font>
                </td>
                </tr>
            
            <tr style="background-color: white">
                <td colspan=4 align=center>
                <br>
                <table border="0" cellpadding="0" cellspacing="0" class="boxbg" width="95%">
                    <tr bgcolor="white">
                        <td style="height:19px">
                             <asp:datagrid id="DataGrid1" runat="server" PageSize="1000"  AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign=Left OnItemDataBound="DataGrid1_ItemDataBound" >
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                                <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
		                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                                <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                                <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"/>
                                <Columns >
	                            <asp:TemplateColumn HeaderText="Select">
	                                <ItemTemplate>
	                                    <asp:RadioButton ID="chksel"  runat="server" />
	                                </ItemTemplate>
	                             </asp:TemplateColumn>
        	                     
	                              <asp:TemplateColumn HeaderText="Req.ID" >
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtReqId" runat="server" BorderStyle="Groove" Width="90px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                      
	                              <asp:TemplateColumn HeaderText="Req. By" HeaderStyle-HorizontalAlign=Left>
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtReqBy" runat="server" BorderStyle="Groove" Width="150px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                      
	                               <asp:TemplateColumn HeaderText="Req. Date">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtReqDt" runat="server" BorderStyle="Groove" Width="60px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                      
	                              <asp:TemplateColumn HeaderText="Orign City">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtOrgnCity" runat="server" BorderStyle="Groove" Width="75px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                      
	                               <asp:TemplateColumn HeaderText="Destn. City">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtDestnCity" runat="server" BorderStyle="Groove" Width="75px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                      
	                              <asp:TemplateColumn HeaderText="Start date">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtStDt" runat="server" BorderStyle="Groove" Width="90px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                      
	                              <asp:TemplateColumn HeaderText="End date">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtEdDt" runat="server" BorderStyle="Groove" Width="90px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                      
	                               <%--<asp:TemplateColumn HeaderText="Passengers">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtPassNo" runat="server" BorderStyle="Groove" Width="30px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>--%>
        	                      
        	                      
	                               <asp:TemplateColumn HeaderText="Vehicle Type" >
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtVehType" runat="server" BorderStyle="Groove" Width="75px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
	                              <%--<asp:TemplateColumn HeaderText="Vehicle No." >
	                                <ItemTemplate>
	                                    <asp:DropDownList ID="cboVehno" runat=server Width="90px"></asp:DropDownList>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>--%>
        	             
	                            </Columns>
	                        </asp:datagrid>&nbsp;
	                        <asp:Label ID="lblDataError" runat=server ForeColor=red CssClass="blackfnt"></asp:Label>
		               </td>
                    </tr>
            </table>
             <p align=right><asp:Button ID="cmdSubmit" runat="server" Text="Next >>" OnClick="SubmitData" /></p><%--nClick="OnSubmit"--%>
         </td>
        </tr> 
        
         <%--<tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Select Driver</font>
                </td>
                <td align="left" colspan=3>
                   <font class=blackfnt >
                    <asp:DropDownList ID="cboDriver" runat=server ></asp:DropDownList>
                   </font>
                </td>
                
            </tr>--%>
            
               
     </table>
     </p>
        
       
  

</asp:Content> 