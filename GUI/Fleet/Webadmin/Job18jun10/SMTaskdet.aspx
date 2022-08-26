<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="SMTaskdet.aspx.cs" Inherits="GUI_Job_Taskdet" %>



    
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script language="javascript" type="text/javascript">  

function OnDescChange(row_Index,txtDesc,ddlWorkGroup)
{
    if(txtDesc.value=="")
    {
        return true;
    }
    var grid=document.getElementById("ctl00_mycph1_dgworkgroup");
    var r=grid.rows.length;
    
    var str_index = "";
    for (intindex = 2; intindex <= r ; intindex++)
    {
        if (intindex < 10)
        {
            str_index = "0" + intindex;
        }
        else
        {
            str_index = intindex;
        }
        if (row_Index == intindex - 2)
        {
            continue;
        }
        var desc = document.getElementById("ctl00_mycph1_dgworkgroup_ctl" + str_index + "_txtDesc");
        var wrkgrp =  document.getElementById("ctl00_mycph1_dgworkgroup_ctl" + str_index + "_ddlworkgroup");
        if(desc.value ==  txtDesc.value)
        {
            if(wrkgrp.value == ddlWorkGroup.value)
            {
                alert("This part already exist at row " + (intindex - 1));
                txtDesc.value = "";
                txtDesc.focus();
                return false;
            }
        }
    }
}
function OnWorkGrpChange(row_Index,txtDesc,ddlWorkGroup)
{
    txtDesc.value="";
}
function OnUnitChange()
{
    var grid=document.getElementById("ctl00_MyCPH1_dgWorkgroup");
    var r=grid.rows.length;
    for(k=0;k<r-1;k++)
    {  
        j=k+2
        var pref="";
        if(j<10)
        {
            pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_";
        }                                       
        else
        {         
            pref = "ctl00_MyCPH1_dgWorkgroup_ctl" + j + "_";
        }
        var ddlUnit=document.getElementById(pref + "ddlUnit");
        var txtServiceIDays=document.getElementById(pref + "txtServiceIDays");
        var txtServiceIKms=document.getElementById(pref + "txtServiceIKms");
        var txtAdvNoteDays=document.getElementById(pref + "txtAdvNoteDays");
        var txtAdvNoteKms=document.getElementById(pref + "txtAdvNoteKms");
        if(ddlUnit.value=="BOTH")
        {
            txtServiceIDays.style.visibility="visible"; 
            txtServiceIKms.style.visibility="visible"; 
            txtAdvNoteDays.style.visibility="visible"; 
            txtAdvNoteKms.style.visibility="visible"; 
        }
        else if(ddlUnit.value=="Days")
        {
            txtServiceIDays.style.visibility="visible"; 
            txtServiceIKms.style.visibility="hidden"; 
            txtAdvNoteDays.style.visibility="visible"; 
            txtAdvNoteKms.style.visibility="hidden";  
            txtServiceIKms.value="";
            txtAdvNoteKms.value="";
        }
        else if(ddlUnit.value=="KMS")
        {
            txtServiceIDays.style.visibility="hidden"; 
            txtServiceIKms.style.visibility="visible"; 
            txtAdvNoteDays.style.visibility="hidden"; 
            txtAdvNoteKms.style.visibility="visible";  
            txtServiceIDays.value="";
            txtAdvNoteDays.value="";
        }
        else
        {
            txtServiceIDays.style.visibility="hidden";
            txtServiceIKms.style.visibility="hidden";
            txtAdvNoteDays.style.visibility="hidden";
            txtAdvNoteKms.style.visibility="hidden";
            txtServiceIDays.value="";
            txtAdvNoteDays.value="";
            txtServiceIKms.value="";
            txtAdvNoteKms.value="";
        }
    }
}

function  check()
{
    var grid=document.getElementById("ctl00_MyCPH1_dgWorkgroup");
    var r=grid.rows.length;
    for(k=0;k<r-1;k++)
    {  
        j=k+2
        var pref="";
        if(j<10)
        {
            pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_";
        }                                       
        else
        {         
            pref = "ctl00_MyCPH1_dgWorkgroup_ctl" + j + "_";
        }    
        
        var ddlWorkGroup=document.getElementById(pref + "ddlWorkGroup");
        var Desc=document.getElementById(pref + "txtDesc");
        var TaskType=document.getElementById(pref + "ddlTaskType");
        var Unit=document.getElementById(pref + "ddlUnit");
        var SIdays=document.getElementById(pref + "txtServiceIDays");
        var ANDays=document.getElementById(pref + "txtAdvNoteDays");
        var SIKms=document.getElementById(pref + "txtServiceIKms");
        var ANKms=document.getElementById(pref + "txtAdvNoteKms");
        if(ddlWorkGroup.value=="")
        {
            alert ("Please enter Work Group!");
            ddlWorkGroup.focus();
            return false;
        }
        if(Desc.value=="")
        {
            alert ("Please enter Task Description!");
            Desc.focus();
            return false; 
        }
        if(TaskType.value=="")
        {
            alert("Please select Task Type!");
            TaskType.focus();
            return  false; 
        }
            
        if(Unit.value=="")
        {
            alert ("Please select Unit of Measure!")
            Unit.focus();
            return  false; 
        }
        else
        {
            if(Unit.value=="BOTH")
            {
                if(SIdays.value=="")
                {
                    alert("Service Interval Days  cannot  be blank!")
                    SIdays.focus();
                    return false;
                }
                if(SIKms.value=="")
                {
                    alert("Service Interval Kms  cannot  be blank!")
                    SIKms.focus();
                    return false;
                }
                if(ANDays.value=="")
                {
                    alert("Advance Notification Days  cannot  be blank!")
                    ANDays.focus();
                    return false;
                }
                if(ANKms.value=="")
                {
                    alert("Advance Notification Kms  cannot  be blank!")
                    ANKms.focus();
                    return false;
                }
            }
            else if (Unit.value=="Days")
            {
                if(SIdays.value=="")
                {
                    alert("Service Interval Days  cannot  be blank!")
                    SIdays.focus();
                    return false;
                }
                if(ANDays.value=="")
                {
                    alert("Advance Notification Days  cannot  be blank!")
                    ANDays.focus();
                    return false;
                }
                if(parseFloat(SIdays.value)<=parseFloat(ANDays.value))
                {
                    alert ("Advance Notification Days should be  less than Service Interval Days!")
                    ANDays.focus();
                    return  false; 
                }
            }
            else if (Unit.value=="KMS")
            {
                if(SIKms.value=="")
                {
                    alert("Service Interval Kms  cannot  be blank!")
                    SIKms.focus();
                    return false;
                }
                if(ANKms.value=="")
                {
                    alert("Advance Notification Kms  cannot  be blank!")
                    ANKms.focus();
                    return false;
                }
                alert(parseFloat(SIKms.value));
                alert(parseFloat(ANKms.value));
                
                if(parseFloat(SIKms.value)<=parseFloat(ANKms.value))
                {
                    alert ("Advance Notification Kms should be  less than Service Interval Kms!")
                    ANKms.focus();
                    return  false; 
                }
            }
        }
    }
}  
function validFloat(event,txtid)
{
    var tb=document.getElementById(txtid);
    var txt=tb.value;
    if(event.keyCode==13)
    return true;

    if(event.keyCode==46)
    if(txt.indexOf('.')!=-1)
    event.keyCode=0;

    if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
    {event.keyCode=0;return false;}
} 
</script>

  <table  align="center" cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" >
            <br />
               <br />
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">SM Task Master</asp:Label>
                <br />
                <br />
               <br />
            </td>
            
                   <td align="right" >
                    <asp:UpdateProgress ID="uppMain" runat="server">
            <ProgressTemplate>
                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                    <tr>
                        <td align="left">
                            <img src="../../../images/loading.gif" alt="" />
                        </td>
                        <td align="left">
                            <font face="verdana" color="#0000ff" size="2"><b>Please Wait ...</b></font>
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                    background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                    opacity: .50; -moz-opacity: .50;" runat="server">
                    <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                        left: 50%;" ID="Panel2" runat="server">
                    </asp:Panel>
                </asp:Panel>
            </ProgressTemplate>
        </asp:UpdateProgress>
        
        
           <%--     <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/Loading_New.gif" />
                    <%--<font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  --%>
         
          </td>      
            
        </tr>
    </table>
     <hr align="center" color="#8ba0e5" size="1" />
    <br>
        <table  align="left" cellspacing="1" style="width: 100%" border=0>
        <tr style="background-color: white">
        <td align="left" colspan="2">
    
            <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>   
                <table   align="center" cellspacing="1" cellpadding="2" class="boxbg">
                                                                                    
                                           
                         <%--<tr style="background-color: white" align="center">
                                                       
                             <td align="right" >
                                 <asp:Label ID="lblWorkGroup" runat="server" Text="Select Work Group" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;
                                <asp:DropDownList ID="ddlWorkGroup" runat="server"    AutoPostBack="true" OnSelectedIndexChanged="ddlWorkGroup_SelectedIndexChanged" />   
                                <asp:RequiredFieldValidator ID="reqddlWorkGroup" runat="server" Display="Dynamic" Text="!" ControlToValidate="ddlWorkGroup" />
                                </td>
                             
                        </tr>--%>
                          <tr style="background-color: white" >
                                                       
                             <td align="left" colspan="2" >
                             
                                <asp:Panel ID="pnlTripsheetDetails" runat="server" Width="100%" >      
                                   
                          <table cellspacing="1" style="width: 100%" class="boxbg"  border="0">
                        <tr class="bgbluegrey">
                            <td   colspan="4"  align="left" style="height: 20px">
                       
                             <font class="bluefnt"><b>Select Vehicle Model</b></font>
                        <asp:Label ID="lblTDSH" runat="server" Font-Bold="True">Show...</asp:Label>
                            </td>
                            
                            </tr>
                               </table>
                        </asp:Panel>
                              
                              
                                </td>
                          
                             
                        </tr>
                        
                                                </tr>
                          <tr style="background-color: white" >
                                                       
                             <td align="left" colspan="2" >
                       <asp:Panel ID="pnlTripDt" runat="server" Width="800px" >     
                                 <asp:CheckBoxList ID="chklstVehicleModel" runat="server" RepeatColumns="4" 
                                     Font-Names="Verdana" Font-Size="8pt" Width="100%">
                                 </asp:CheckBoxList>
                                 </asp:Panel>
                 <ajaxToolkit:CollapsiblePanelExtender ID="cpe" runat="Server"
                     TargetControlID="pnlTripDt"
                     ExpandControlID="pnlTripsheetDetails" CollapseControlID="pnlTripsheetDetails" Collapsed="True"
                     TextLabelID="lblTDSH" ExpandedText="Hide..." CollapsedText="Show..."
                     SuppressPostBack="true"/>
            
                        
                                </td>
                          
                             
                        </tr>
                        
                         <%--<tr style="background-color: white" align="center">
                            
                            
                             <td align="right" >
                                 <asp:Label ID="Label1" runat="server" Text="Manufacturer" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblMfg" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>
                        	   
                        	    <tr style="background-color: white" align="center">
                            
                            
                             <td align="right" >
                                 <asp:Label ID="Label2" runat="server" Text="Model" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblModel" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>--%>
                        
                    
                        
                        
                        </table>
                        
                  
                        
                        
                          <br>
                        	
                         <table  align="center" cellspacing="1" cellpadding="2" class="boxbg" >
                           
                              <tr style="background-color: white">
                        <td colspan="2">
                        <asp:Label ID="lblError" runat="server"   Visible="true" CssClass="redfnt">
                                 
                             </asp:Label>
                        
                        </td>
                        </tr>
                           
                           
                           
                           
                           
                           <tr style="background-color: white" align="center" >
                           <td  align="left" width="20%">
                 <font class=blackfnt>Enter no. of rows </font>&nbsp;&nbsp;
                 </td>
                 <td align="left" >
                 <asp:TextBox ID="txtRow" runat="server" MaxLength="3" Width="30"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   BorderStyle="Groove"  Text="0" AutoPostBack="true" OnTextChanged="txtRow_TextChanged"></asp:TextBox>
              	                                                                   <asp:RegularExpressionValidator ID="RegtxtRow" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtRow" Display="Dynamic"></asp:RegularExpressionValidator>
                           
                            
                      </td>
                 </tr>
                          
                                                     
                           
                        
                        
                        
                        
                            <tr style="background-color: white">
                        <td colspan="2">
                             <asp:datagrid id="dgWorkgroup" runat="server" PageSize="1000"  OnItemDataBound="dgWorkgroup_ItemDataBound"  OnItemCommand="dgWorkgroup_ItemCommand"      AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign=Left   >
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                                <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
		                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                                <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"/>
                                <Columns >
                                    <asp:TemplateColumn HeaderText="Sr.No.">
                                        <ItemTemplate>
                                            <center>
                                            <%# Container.ItemIndex+1 %>.
                                            <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                <asp:HiddenField ID="hfTaskId" runat="server" Value=""  />
                                            </center>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
        	                      
                                    <asp:TemplateColumn HeaderText="Work Group">
                                    <ItemTemplate>
                                              <asp:DropDownList ID="ddlWorkGroup" runat="server" />   
                                            <%--<asp:RequiredFieldValidator ID="reqddlWorkGroup" runat="server" Display="Dynamic" Text="!" ControlToValidate="ddlWorkGroup" />--%>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                    
                                    
	                              <asp:TemplateColumn HeaderText="Task Description">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtDesc" CssClass="input" runat="server" BorderStyle="Groove" Width="150px"  ></asp:TextBox>
	                                </ItemTemplate>
                                      <HeaderStyle HorizontalAlign="Left" />
	                              </asp:TemplateColumn>
        	                      
        	                      <asp:TemplateColumn HeaderText="Task Type" >
	                                <ItemTemplate>
	                                    <asp:DropDownList ID="ddlTaskType" runat="server" BorderStyle="Groove" Width="150px" />
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
	                               <asp:TemplateColumn HeaderText="Unit Of Measure" >
	                                <ItemTemplate>
	                                <%--AutoPostBack="true" OnSelectedIndexChanged="ddlUnit_SelectedIndexChanged" --%>
	                                    <asp:DropDownList ID="ddlUnit" runat="server"  BorderStyle="Groove" Width="60px"   >
                                           <asp:ListItem Selected="True" Value=""></asp:ListItem>
                                            <asp:ListItem  Value="BOTH">BOTH</asp:ListItem>
                                            <asp:ListItem Value="Days">DAYS</asp:ListItem>
                                            <asp:ListItem Value="KMS">KMS</asp:ListItem>
                                        </asp:DropDownList>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
        	                    <asp:TemplateColumn HeaderText="Estimated Hours"  >
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtEstHours" Style="text-align: right" runat="server" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  BorderStyle="Groove" Width="50px" ></asp:TextBox>
	                               
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
	                              <asp:TemplateColumn HeaderText="Service Intervals Days"  >
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtServiceIDays" Style="text-align: right" runat="server" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  BorderStyle="Groove" Width="50px" ></asp:TextBox>
	                                                                   <asp:RegularExpressionValidator ID="RegtxtServiceIDays" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtServiceIDays" Display="Dynamic"></asp:RegularExpressionValidator>
	                               
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                               <asp:TemplateColumn HeaderText="Service Intervals Kms">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtServiceIKms" runat="server" Style="text-align: right" CssClass="input"  BorderStyle="Groove"  Width="50px"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      ></asp:TextBox>
	                                                                         <asp:RegularExpressionValidator ID="RegtxtServiceIKms" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtServiceIKms" Display="Dynamic"></asp:RegularExpressionValidator>
	                                
	                                
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                               <asp:TemplateColumn HeaderText="Advance Notification Days">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtAdvNoteDays" Style="text-align: right" runat="server" CssClass="input" BorderStyle="Groove"  Width="50px"    onkeypress="javascript:validFloat(event,this.getAttribute('id'))"    ></asp:TextBox>
	                                                   <asp:RegularExpressionValidator ID="RegtxtAdvNoteDays" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtAdvNoteDays" Display="Dynamic"></asp:RegularExpressionValidator>
	                               
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
	                              
	                                  <asp:TemplateColumn HeaderText="Advance Notification Kms">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtAdvNoteKms" Style="text-align: right" runat="server" CssClass="input"  BorderStyle="Groove"  Width="50px"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      ></asp:TextBox>
	                                
	                                 <asp:RegularExpressionValidator ID="RegtxtAdvNoteKms" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtAdvNoteKms" Display="Dynamic"></asp:RegularExpressionValidator>
	                                
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                                                        
        	                              	                                                                          
	                         	            
	                            </Columns>
	                        </asp:datagrid>
	                    		               </td>
                    </tr>
                    
                    <%--<asp:TemplateColumn HeaderText="Delete">
                      <ItemTemplate>
                        <asp:LinkButton ID="DeleteRow" runat="server" CausesValidation="false">X</asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateColumn>
                    --%>
                    
                      <tr style="background-color: white">
                            <td colspan="3" align="center">
                          <%--      <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>--%>
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" Visible="false" OnClick="btnSubmit_Click" OnClientClick="javascript:return check()" /> 
                                    <%--</ContentTemplate>
                                </asp:UpdatePanel>--%>
                            </td>
                        </tr>
                    
                    
            </table>  
            
            
            
                                      
                                     </ContentTemplate>
                    <Triggers>
                        <%--<asp:AsyncPostBackTrigger ControlID="ddlWorkGroup" EventName="SelectedIndexChanged" />--%>
                          <asp:AsyncPostBackTrigger ControlID="txtRow" EventName="TextChanged" />
                     <%--       <asp:AsyncPostBackTrigger ControlID="ddlUnit" EventName="SelectedIndexChanged" />--%>
                    </Triggers>
                 </asp:UpdatePanel> 
                        </td>
                        </tr>
                        </table>              
                                      
                                      
                                      
                                                         
                        
                       
                        
       
 
 
 
 
 </asp:Content>    
