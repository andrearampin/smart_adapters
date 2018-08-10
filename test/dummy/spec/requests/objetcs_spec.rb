RSpec.describe ObjectsController, type: :request do
  context "#html" do
    before { get '/objects' }
    scenario "#status 200" do
      expect(response.status).to eql 200
    end

    scenario "#content-type html" do
      expect(response.header['Content-Type']).to eql 'text/html; charset=utf-8'
    end

    scenario "#body valid" do
      expect(response.body.include? '{:object=&gt;&quot;object content&quot;}')
        .to be true
    end
  end

  context "#json" do
    before { get '/objects.json' }
    scenario "#status 200" do
      expect(response.status).to eql 200
    end

    scenario "#content-type json" do
      expect(response.header['Content-Type'])
        .to eql 'application/json; charset=utf-8'
    end

    scenario "#body valid" do
      expect(response.body.include? '{"object":"object content"}')
        .to be true
    end
  end

  context "#xml" do
    before { get '/objects.xml' }
    scenario "#status 200" do
      expect(response.status).to eql 200
    end

    scenario "#content-type xml" do
      expect(response.header['Content-Type'])
        .to eql 'application/xml; charset=utf-8'
    end

    scenario "#body valid" do
      expect(response.body.include? '<object>object content</object>')
        .to be true
    end
  end

  context "#js" do
    before { get '/objects.js' }
    scenario "#status 200" do
      expect(response.status).to eql 200
    end

    scenario "#content-type js" do
      expect(response.header['Content-Type'])
        .to eql 'text/javascript; charset=utf-8'
    end

    scenario "#body valid" do
      expect(response.body.include? "alert('{:object=&gt;&quot;object")
        .to be true
    end
  end

  context "#xxx" do
    scenario "#exception" do
      expect { get '/objects.xxx' }
        .to raise_exception(SmartAdapters::Exceptions::InvalidRequestFormatException)
    end
  end
end
