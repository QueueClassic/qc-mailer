module QCHelper

  def enqueue_stub
    proc do |method, *args| 
      klass = eval(method.split(".").first)
      msg = method.split(".").last
      klass.send(msg, *args)
    end 
  end

  def setup
    init_db
  end

  def teardown
    QC.delete_all
  end

  def init_db(table_name="queue_classic_jobs")
    QC::Conn.execute("SET client_min_messages TO 'warning'")
    QC::Setup.drop
    QC::Setup.create
    QC::Conn.disconnect
  end

end
