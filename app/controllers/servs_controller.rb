# -*- encoding : utf-8 -*-
class ServsController < ApplicationController
  # GET /servs
  # GET /servs.json
  def index
    @servs = Serv.all.order_by(:name.asc)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @servs }
    end
  end

  # GET /servs/1
  # GET /servs/1.json
  def show
    @serv = Serv.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @serv }
    end
  end

  # GET /servs/new
  # GET /servs/new.json
  def new
    @serv = Serv.new
    @conn=Conn.new
    @net_eles = NetEle.all
    if @net_eles.count > 0
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @serv }
      end
    else
      respond_to do |format|
        format.html { redirect_to servs_url, notice: t('servs.delete.error_mo')  }
        format.json { render json: @servs.errors, status: :unprocessable_entity }
      end
    end

  end

  # GET /servs/1/edit
  def edit
    @serv = Serv.find(params[:id])
    @net_eles = NetEle.all
    @conn = @serv.conn
  end

  # POST /servs
  # POST /servs.json
  def create
    @serv = Serv.new(params[:serv])
    if @serv.mother
      params[:serv][:conn][:ip]=@serv.mother.conn.ip
    end
    @conn=Conn.new(params[:serv][:conn])
    @serv.conn=@conn
    respond_to do |format|
      if @serv.save
        format.html { redirect_to servs_url, notice: t('servs.create.notice')  }
        format.json { render json: @serv, status: :created, location: @serv }
      else
        @net_eles = NetEle.all
        format.html { render action: "new" }
        format.json { render json: @serv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /servs/1
  # PUT /servs/1.json
  def update
    @serv = Serv.find(params[:id])
    @conn = @serv.conn
    @serv2 = Serv.new(params[:serv])
    if @serv2.mother
      params[:serv][:mother]=@serv2.mother
      params[:serv][:conn][:ip]=@serv2.mother.conn.ip
    else
      params[:serv][:mother]=nil
      params[:serv][:conn][:ip]=nil
    end
    pass1=@conn.update_attributes(params[:serv][:conn])
    pass2=@serv.update_attributes(params[:serv])
    respond_to do |format|
      if pass1 and pass2
        format.html { redirect_to servs_url, notice: t('servs.update.notice')  }
        format.json { head :no_content }
      else
        @net_eles = NetEle.all
        format.html { render action: "edit" }
        format.json { render json: @serv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servs/1
  # DELETE /servs/1.json
  def destroy
    @serv = Serv.find(params[:id])
    @serv.destroy

    respond_to do |format|
      format.html { redirect_to servs_url, notice: t('servs.delete.notice')   }
      format.json { head :no_content }
    end
  end

  def testconn
    @m='No hay conexión'
    @cs='error'
    repo=params['repo']
    port=params['port']
    if repo != ""
      @netele = NetEle.find_by(:_id => repo)
      ip=@netele.conn.ip
      if self.is_port_open?(ip,port)
        @m='Conexión exitosa'
        @cs='success'
      end
    end
    respond_to do |format|
      format.js {}
    end
  end

  def is_port_open?(ip, port)
    begin
      Timeout::timeout(1) do
        begin
          s = TCPSocket.new(ip, port)
          s.close
          return true
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Errno::EADDRNOTAVAIL, SocketError
          return false
        end
      end
    rescue Timeout::Error
    end
    return false
  end

  def delparams
    mcratrs = Serv.find(params[:id]).mcr_atrs
    mcratrs.each do |mcratr|
      mcratr.destroy
    end
    respond_to do |format|
      format.html { redirect_to servs_url, notice: t('forms.delparam.notice')   }
      format.json { head :no_content }
    end
    end

  def upload_new
    tmp = params[:serv][:file].tempfile
    #fileroute=Rails.application.assets['ja.xml'].pathname
    #f = File.open(fileroute)
    f=File.open(tmp)
    doc = Nokogiri::XML(f)
    puts doc
    puts "///////////////////////////////////////////////"
    f.close
    @mr=ManRsc.find(params[:id])
    doc.xpath('//mcr-atrs/mcr-atr').each do |n1|
      mcr=McrAtr.new
      n1.elements.each do |n2|
        if n2.name == 'name'
          mcr.name=n2.text
        elsif n2.name == 'desc'
          mcr.desc=n2.text
        elsif n2.name == 'ref-prot'
          mcr.ref_prot=n2.text
        elsif n2.name == 'atrs'
          n2.elements.each do |n3|
            atr=Atr.new
            n3.elements.each do |n4|
              if n4.name == 'name'
                atr.name=n4.text
              elsif n4.name == 'desc'
                atr.desc=n4.text
              elsif n4.name == 'ref-prot'
                atr.ref_prot=n4.text
              elsif n4.name == 'type'
                atr.type=n4.text
              elsif n4.name == 'rdbl'
                atr.rdbl=n4.text
              elsif n4.name == 'wtbl'
                atr.wtbl=n4.text
              elsif n4.name == 'value'
                atr.value=n4.text
              end
            end
            atr.mcr_atr=mcr
          end
        end
      end
      mcr.man_rsc=@mr
    end
    respond_to do |format|
      format.html # upload_new.html.haml
      format.json { render json: @mr }
    end
  end

  def upload_create
    @mr = ManRsc.find(params[:id])
    mcr_atrs=params[:serv][:mcr_atrs_attributes]
    @mr.mcr_atrs_attributes=mcr_atrs
    pass=true
    @mr.mcr_atrs.each do |mcr|
      if not mcr.save
        pass=false
      end
      mcr.atrs.each do |atr|
        if not atr.save
          pass=false
        end
      end
    end
    #=f2.collection_radio_buttons :rdbl, [[true, 'SI'] ,[false, 'NO']], :first, :last, :item_wrapper_class => 'inline'
    #=f2.input :type, label: 'Tipo', :input_html => { :class => "span4" }, :hint => "Tipo del Atributo"
    respond_to do |format|
      if pass
        @mr.save
        format.html { redirect_to servs_url, notice: 'Parámetros creados satisfactoriamente.' }
        format.json { head :no_content }
      else
        @mr.mcr_atrs.each do |mcratr|
          mcratr.destroy
        end
        format.html { render action: "upload_new" }
        format.json { render json: @mr.errors, status: :unprocessable_entity }
      end
    end
  end

end

