<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"     CodeFile="GenPMSch.aspx.cs" Inherits="GUI_Fleet_Job_PMRemGen" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
     +<script language="javascript" type="text/javascript">  
 function check()
 
 {
 
 alert("Task Submitted");
  
 
 
 
 }
 
 
 </script><%--  <script language="javascript" type="text/javascript">
       
//        function nwOpen(mNo)
//        {
//         window.open("/ERP.NET/GUI/Fleet/Webadmin/Driver/PopupVehicleNo.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
// 
//        }
//        
        
        function Check()
        {
        
        var grid=document.getElementById("ctl00_MyCPH1_DataGrid1");
        var r=grid.rows.length;
       abc=0;
          for(k=0;k<r-1;k++)
          {  
             
               j=k+2
               var pref="";
              if(j<10)
              {
              pref = "ctl00_MyCPH1_DataGrid1_ctl0" + j + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_DataGrid1_ctl" + j + "_";
              }    
        
          //  document.getElementById(pref + "chkSelect").Checked;
       
            if(document.getElementById(pref + "chkSelect").checked)
            {
                 abc=abc+1;
            }   
         
          }
       
       
       
       
         if(abc<1)
         
        {
        alert("Select Atleast One Record");
        return false;
        }
        
        }

        
        
        
               
        </script>--%>
<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Generate PM Schedule</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
            
                   <td align="right">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>      
            
            
        </tr>
    </table>
            
            <br/>
            <br/>        
     <table  align="center"  cellspacing="1" style="width: 70%"  >                                                                    
                                         
                        <tr  align="center"  style="background-color: white">
               
                <td align="center" >
    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                    
     <table  align="center"  cellspacing="1" style="width: 70%" class="boxbg">                                                                    
                           
                           
                                            <tr class="bgbluegrey">
                        <td colspan="2" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                        </td>
                    </tr>
                        
                           
                           
                           
   
                          <tr style="background-color: white" align="center">
                                                       
                             <td align="left" >
                                 <asp:Label ID="Label1" runat="server" Text="Vehicle Category" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td  align="left">
                                &nbsp;<asp:DropDownList ID="ddlVehCategory" runat="server"  AutoPostBack="true"  OnSelectedIndexChanged="ddlVehCategory_SelectedIndexChanged"   CssClass="blackfnt">
                                 
                             </asp:DropDownList>
                                </td>
                             
                        </tr>
                        
                        
                        
                        
                        
                          <tr style="background-color: white" align="center">
                                                      
                             <td align="left"  >
                                 <asp:Label ID="Label2" runat="server" Text="Manufacturer" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblMfg" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>
                      	    <tr style="background-color: white" align="center">
                                      <td align="left" >
                                 <asp:Label ID="Label3" runat="server" Text="Model" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblModel" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>
                        
                             
             
                     </table>
                     <br/>
                          <table  align="center"  cellspacing="1" style="width: 70%" >    
                       <tr style="background-color: white" align="center">
                          <td  align="center" colspan="2">
                           <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"    /> 
                       </td>
                       
                       
                      </tr>
                     </table>
                     <br/>
                     <br/>
    
     <table cellspacing="1" style="width: 100%"     runat="server">
     
       <tr style="background-color: white" align="center">
                          <td  align="center" colspan="2">
                          
                           <asp:Label ID="lblError" runat="server" Visible="false"    CssClass="redfnt"  ></asp:Label>
                          
                          </td>
                          </tr>
     
     
     
        <tr align="center">
            <td align="center">
             <%--                
                  <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> --%>
                        <asp:DataGrid ID="DataGrid1" runat="server"     OnItemDataBound="DataGrid1_ItemDataBound"  DataKeyField="W_GRPCD"
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"    
                            CellSpacing="1" CssClass="dgRowStyle" 
                            HeaderStyle-CssClass="dgHeaderStyle"  PagerStyle-HorizontalAlign="left" OnItemCommand="DataGrid1_ItemCommand"
                             >
                            <Columns>
                   
	                                <asp:TemplateColumn HeaderText="Select" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate  >
                                                                  <asp:CheckBox ID="chkSelect" runat="server"   />
                                                            </ItemTemplate>
                                                          
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        
	                                       <asp:TemplateColumn HeaderText="Work Group Code" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblW_GRPCD" runat="server"  Width="120px" CssClass="blackfnt"  ></asp:Label>
	                             	    <asp:DropDownList ID="ddlWorkGroup" runat="server"   AutoPostBack="true"   Visible="false"    Width="120px" CssClass="blackfnt" OnSelectedIndexChanged="ddlWorkGroup_SelectedIndexChanged" ></asp:DropDownList>
	                                </ItemTemplate>
	                              </asp:TemplateColumn> 
	                          
                            <asp:TemplateColumn HeaderText="Description" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblDesc" runat="server"  Width="120px" CssClass="blackfnt"    ></asp:Label>
	                            
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
	                              
	                              
	                                    <asp:TemplateColumn HeaderText="Unit Of Measure" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblUnit" runat="server"  Width="120px" CssClass="blackfnt"   ></asp:Label>
	                            
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                                    <asp:TemplateColumn HeaderText="Service Intervals Days" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblSIDays" runat="server"  Width="120px" CssClass="blackfnt"    ></asp:Label>
	                            
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
	                              
	                                    <asp:TemplateColumn HeaderText="Service Intervals Kms" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblSIKms" runat="server"  Width="120px" CssClass="blackfnt"   ></asp:Label>
	                            
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
	                                    <asp:TemplateColumn HeaderText="Advance Notification Days" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblANDays" runat="server"  Width="120px" CssClass="blackfnt"   ></asp:Label>
	                            
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
	                                    <asp:TemplateColumn HeaderText="Advance Notification Kms" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblANKms" runat="server"  Width="120px" CssClass="blackfnt"  ></asp:Label>
	                            
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                                  
                                      <asp:TemplateColumn>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="AddTask" runat="server" CausesValidation="False" >Select Task</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
	                                                  
                              
        <%--                    <asp:HyperLinkColumn  DataNavigateUrlFormatString="~/GUI/Fleet/Job/FinalizeTask.aspx?id={0}"   Target="_blank"
                                  DataTextFormatString="Select Task" DataNavigateUrlField ="W_GRPCD" DataTextField="W_GRPCD" >
                                    <ItemStyle CssClass="bluelink" ForeColor="Blue" />
                                </asp:HyperLinkColumn>  --%>  
                              <%--  <asp:TemplateColumn>
                                   <ItemTemplate>
                                   
                                       <asp:LinkButton ID="LinkButton1" Visible="true"   Text='<a href="javascript:nwOpen(2)">...</a>'  runat="server">View</asp:LinkButton>
                                
                                
                                  </ItemTemplate>
                               </asp:TemplateColumn>--%>
  
                            </Columns>
                      
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:DataGrid>

        <%--    </ContentTemplate>
                   
                 </asp:UpdatePanel> --%>
 
 
            </td>
        </tr>
    </table>
  
<%--  </ContentTemplate>
                    <Triggers>
                        <asp:ControlEventTrigger ControlID="btnSubmit" EventName="Click" />
                    </Triggers>
                        </asp:UpdatePanel>--%>
  
    
       
  
  <br/>
     <table cellspacing="1" style="width: 100%"  align="center">
        <tr align="center">
            <td align="center">
            
        <%--    OnClientClick="javascript:Check()"  --%>
               <asp:Button ID="cmdFinalize" runat="server"  Visible="false"     Text="Finalize" OnClick="cmdFinalize_Click"     /> 
            
            </td>
            </tr>
            </table>
  
   <br/>
   
    <table   id="table1"    runat="server"  visible="false"  width="70%" align="center">
       
            
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" ></asp:Label>
                    
                    </td>
                           
                    
            </tr>
            
            
              
            <tr style="background-color: white">
                <td colspan="4" align="center">
               
                         
                             <asp:GridView id="GridView1"  runat="server" PageSize="10"   Visible ="false" EmptyDataText="No Records Found.."   AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="blackfnt" CellSpacing="1" Width="100%" Height="1px"   Font-Size="10" OnRowDataBound="DataGrid1_RowDataBound" >
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />

		                             

                                <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"/>
                                <Columns >
                                
                                
                                 <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate  >
                                                                  <asp:CheckBox ID="chkSelect" runat="server"   />
                                                            </ItemTemplate>
                                                          
                                                        </asp:TemplateField>
                                
                                
                                    <asp:TemplateField HeaderText="Task Code" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate  >
                                                                  <asp:Label ID="lblTaskCd"   runat="server" CssClass="bleckfnt"  ></asp:Label>
                                                            </ItemTemplate>
                                                          
                                                        </asp:TemplateField>
                                                        
                                                            <asp:TemplateField HeaderText="Task Description" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate  >
                                                                  <asp:Label ID="lblTaskDesc" runat="server" CssClass="bleckfnt"  ></asp:Label>
                                                            </ItemTemplate>
                                                          
                                                        </asp:TemplateField>
                                                        
                                                        
                                                        
                                                            <asp:TemplateField HeaderText="Task  Type" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate  >
                                                                  <asp:Label ID="lblTaskType" runat="server"  CssClass="bleckfnt" ></asp:Label>
                                                            </ItemTemplate>
                                                          
                                                        </asp:TemplateField>
                                                        
                                                        
                                                             
                                
                             
                             
                                
	                            </Columns>
	                        </asp:GridView>&nbsp;
		             
          </td>
          </tr>
          </table>
   <br/>
 
   
     <table   cellpadding="0" cellspacing="0"  width="100%">
                    <tr bgcolor="white">
                        <td style="height:19px" align="center">
    
    
    
    <asp:Button ID="Button1" runat="server" Text="Submit"   OnClientClick="javascript:check()" OnClick="btnSub_Click"  Visible="false"  />&nbsp;&nbsp;
    <%--  
       <INPUT style="Z-INDEX: 104; width: 49px; left: 466px; top: 304px;"  visible="false" type="button" value="Next"
				onclick="Done();" tabIndex="2" id="Button1" />--%>
      
      
    </td>
    </tr>
    </table>
   
   
    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
                    </Triggers>
                        </asp:UpdatePanel>
      </td>
        </tr>
     </table>
      
    </asp:Content>
