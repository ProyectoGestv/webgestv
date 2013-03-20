# -*- encoding : utf-8 -*-
class ServsController < ApplicationController
  # GET /servs
  # GET /servs.json
  def index
    @servs = Serv.all

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

  def upload
    fileroute=Rails.application.assets['ja.xml'].pathname
    puts '//////////////////////////////////////////'
    #data = File.read(fileroute)
    f = File.open(fileroute)
    @doc = Nokogiri::XML(f)
    f.close
    #mr1=ManRsc.new
    mr1=ManRsc.find_by(name: 's5')
    @doc.xpath('//mcr-atrs/mcr-atr').each do |n1|
      puts "n1 #{n1.name} = #{n1.text}"
      mcr=McrAtr.new
      n1.elements.each do |n2|
        puts "n2 #{n2.name} = #{n2.text}"
        if n2.name == 'name'
          mcr.name=n2.text
        elsif n2.name == 'desc'
          mcr.desc=n2.text
        elsif n2.name == 'ref-prot'
          mcr.ref_prot=n2.text
        elsif n2.name == 'atrs'
          n2.elements.each do |n3|
            puts "n3 #{n3.name} = #{n3.text}"
            atr=Atr.new
            n3.elements.each do |n4|
              puts "n4 #{n4.name} = #{n4.text}"
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
            if not atr.save
              puts atr.to_xml
              puts '************ NO SAVE ATR *****************'
              #atr.mcr_atr=nil
              atr.destroy
            end
          end
        end
      end
      mcr.man_rsc=mr1
      if not mcr.save
        puts mcr.to_xml(:include => :atrs)
        puts '************ NO SAVE MCR *****************'
        mcr.atrs.each do |atr|
          atr.destroy
        end
        #mcr.man_rsc.destroy
        mcr.destroy
      end
      #puts mcr.to_xml(:include => :atrs)
      puts '+++++++++++++++++++++++++++++++++++++++++'
      #puts mcr.atrs.to_xml
    end


    puts '------------------SALIO---------------------'
    if mr1.save
      puts mr1.to_xml(:include => {:mcr_atrs => {:include => :atrs} })
      puts '************ NO SAVE MR *****************'
      mr1=ManRsc.find_by(name: 's5')
      puts mr1.to_xml(:include => {:mcr_atrs => {:include => :atrs} })
    else
      mr1.mcr_atrs.each do |mcratr|
        mcratr.destroy
      end
    end
    puts '//////////////////////////////////////////'
    respond_to do |format|
      format.html { redirect_to servs_url }
      format.json { head :no_content }
    end
  end
end
