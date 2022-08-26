<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="MSStep1.aspx.cs" Inherits="GUI_Operations_MISROUTE_MSStep1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
   
    <script src="../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    

    
     <script language="javascript" type="text/javascript">
     	var months = new Array("","January", "February", "March", "April", "May", "June",
	"July", "August", "September", "October", "November", "December");
	
     
var doc="document.aspnetForm.ctl00_MyCPH1_"; //common part of all object's name on the form
var docInGrid="document.aspnetForm.ctl00_MyCPH1_";
var tmpDt="";
var tmpDtArr;

     function ValidateDocketData ()
     {
     
      var xmlData_MSRDKT="<root>";
      for(i=0;i<parseInt(eval(doc+"MSRDKTList").value);i++){
            j=i+2
            if(j<10)
            {
                 MSRCHK = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + "0"+ j +"_CHKMR"); 
            }
            else
            {
                 MSRCHK = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl"+ j +"_CHKMR"); 
            }
           // alert(" hi.. I .. " +j)
       // MSRCHK = 'document.aspnetForm.ctl00_MyCPH1_grvcontrols_ctl' + '0'+ i +'_CHKMR';   
        //  alert(MSRCHK)        
       /// alert(MSRCHK.checked)      
       if(MSRCHK.checked==true)
            {          
            
            currdate="<%=System.DateTime.Now.ToString("MM/dd/yyyy")%>"     
//            dt_dd=currdate.substring(0,2)
//	        dt_mm=currdate.substring(3,5)
//	        dt_yy=currdate.substring(6,10)
//	        alert("hi")
//	        currdate=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
//        	
	  
                xmlData_MSRDKT = xmlData_MSRDKT + "<SU><SUDate>" + currdate + "</SUDate>"; 
            //   alert(MSRCHK.getAttribute('ID'))
                        rowid=MSRCHK.getAttribute('ID').substring(0,31)
                       msardkt=document.getElementById("" + rowid +"txtmrdkt");
                      msardktpkg=document.getElementById("" + rowid +"hrtxtmrpkgs");
                      msardktwt=document.getElementById("" + rowid +"hrtxtmrWt");
                       
                       xmlData_MSRDKT = xmlData_MSRDKT + "<MRSDKT>" + Trim(eval(msardkt).value) + "</MRSDKT>"
                       xmlData_MSRDKT = xmlData_MSRDKT + "<MRSPKG>" + Trim(eval(msardktpkg).value) + "</MRSPKG>"
                       xmlData_MSRDKT = xmlData_MSRDKT + "<MRSWT>" + Trim(eval(msardktwt).value) + "</MRSWT>"
               
                   xmlData_MSRDKT = xmlData_MSRDKT + "</SU>";
             //alert("hi..." +xmlData_MSRDKT)    
             }
             
             
     
    }
    
    
     xmlData_MSRDKT = xmlData_MSRDKT + "</root>";
     eval(doc+"hXMLData_MSRDKT").value=xmlData_MSRDKT;
     document.aspnetForm.method="post";
     document.aspnetForm.action="./MSStep2.aspx";
    document.aspnetForm.submit();
    
    
    
     }  
     
      function ENABLED_MSALLFIELDS(chkval)
    {
        //alert("AAA " +chkval.getAttribute('ID'))
        rowid=chkval.getAttribute('ID').substring(0,31)
     //    alert("cccc "+rowid)     
         msardkt=document.getElementById("" + rowid +"txtmrdkt");
              
                
        if(chkval.checked==true)
                {
                    msardkt.disabled=false;
                  // alert("DDDD ")     
                  
                    msardkt.focus();
                }
                else
                {
                   msardkt.disabled=true;
                 }
            
            }
     
      function OnDKTBlur(id)
   {
            // document.getElementById(id).value=document.getElementById(id).value.toUpperCase()
            var txtDKT=id;
           // alert(txtDKT.getAttribute('ID'))
            rowid=txtDKT.getAttribute('ID').substring(0,31)
            msarpkg=document.getElementById("" + rowid +"txtmrpkgs");
            msarwt=document.getElementById("" + rowid +"txtmrwt");
            
             hrmsarpkg=document.getElementById("" + rowid +"hrtxtmrpkgs");
            hrmsarwt=document.getElementById("" + rowid +"hrtxtmrwt");
            
            var DOCKET=txtDKT.value;
            
              if(DOCKET==" ")
            { msarpkg.innerText=""
                  msarwt.innerText=""
                  }
            if(DOCKET=="")
            {
                  msarpkg.innerText=""
                  msarwt.innerText=""
                return false;
                }
         
        
            var findobj=false;
            findobj=GetXMLHttpObject();
            
             if(findobj)
            {
            
                var strpg="../STOCKUPDATE/CheckDKT.aspx?DOCKET=" + DOCKET;
                 findobj.open("GET",strpg,true);
                 findobj.onreadystatechange=function()
                 {
                // alert(findobj.responseText)
                     if(findobj.readyState==4 && findobj.status==200)
                        {
                            var res=findobj.responseText.split("|");
                             //alert(res[0])
                         
                            if(res[1]!="" )
                            {
                               if( res[1]!="Y")
                               {
                                        if(res[1]=="N")
                                        {
                                        alert("Document Number is Not Exists... Please Enter Valid Document Number");                               
                                        txtDKT.value="";
                                        txtDKT.focus();
                                        }
                                        
                                        else 
                                        {
                                          alert(res[1])
                                          // txtDKT.value="";
                                        txtDKT.focus();
                                        }                               
                                
                                return false;
                                }
                                else
                                {
                                    msarpkg.innerText=res[2]
                                    msarwt.innerText=res[3]
                                    hrmsarpkg.innerText=res[2]
                                    hrmsarwt.innerText=res[3]
                                    
                                    //return true;
                                }
                                
                            }                         
                            
                        }
                 }
            findobj.send(null);
            }
            return false;
   }
     
     </script>

                    
    <asp:UpdatePanel ID="upStockUpdate"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <table cellspacing="1" style="width: 900px">
                <tr style="background-color: white">
                    <td align="left" style="width: 50%">
                     <asp:HiddenField ID="hBrCd" runat="server" EnableViewState="true" />
                     <asp:HiddenField ID="MSRDKTList" runat="server" EnableViewState="true" />
                    <asp:HiddenField ID="hXMLData_MSRDKT" runat="server" EnableViewState="true" />
                    </td>
                    <td align="left">
                        <asp:UpdateProgress ID="uppMain" runat="server">
                            <ProgressTemplate>
                                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                    <tr>
                                        <td align="right">
                                            <img src="../../images/loading.gif" alt="" />
                                        </td>
                                        <td>
                                            <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
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
                        &nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="350">
                <tr style="background-color: White">
                    <td style="text-align: left" class="blackfnt">
                        &nbsp;Enter No. of Rows
                    </td>
                    <td style="text-align: left" class="blackfnt">
                        &nbsp;<asp:TextBox ID="txtRows" Text="3" runat="server" BorderStyle="Groove" onkeypress="javascript:validInt(event);"
                            CssClass="input" Width="50px"></asp:TextBox>
                        &nbsp;<asp:Button ID="btnAdd" UseSubmitBehavior="false" runat="server" Text="Add Rows"
                            OnClick="btnAdd_Click" />
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" cellpadding="0" cellspacing="0" width="500">
                <tr style="background-color: White">
                    <td style="text-align: left" class="blackfnt">
                    
                        <asp:GridView ID="grvcontrols" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                            CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast"
                            PagerStyle-HorizontalAlign="left" Width="100%" ShowFooter="True">
                            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                            <FooterStyle CssClass="boxbg" />
                            <Columns>
                                <%-- <asp:TemplateField HeaderText="Sr. No.">
                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblsrno" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>--%>
                                <%--Onclick="Javascript:return ENABLED_MSALLFIELDS(this);"--%>
                                <asp:TemplateField ItemStyle-HorizontalAlign="left">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="CHKMR" runat="server" Onclick="Javascript:return ENABLED_MSALLFIELDS(this);" />
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Docket. No.">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtmrdkt" Enabled="false" CssClass="blackfnt" runat="server" Onblur="Javascript:return OnDKTBlur(this);"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Pkgs">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hrtxtmrpkgs" runat="server" />
                                        <asp:Label ID="txtmrpkgs" CssClass="blackfnt" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Actual Weight">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hrtxtmrWt" runat="server" />
                                        <asp:Label ID="txtmrWt" CssClass="blackfnt" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                    <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle HorizontalAlign="Left" />
                        </asp:GridView>
                        <br />
                    </td>
                </tr>
                <tr id="Tr2" style="background-color: White; display:block" runat="server">
                    <td  align="left">
                        <asp:Button Text="Declare Misroute >>" ID="btnStockUpdate" runat="server" OnClientClick="return ValidateDocketData()"
                            />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
