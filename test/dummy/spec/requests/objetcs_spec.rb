RSpec.describe ObjectsController, type: :request do
  context "#html" do
    before { get '/objects' }
    scenario "#status" do
      expect(response.status).to eql 200
    end

    scenario "#content-type" do
      expect(response.header['Content-Type']).to eql 'text/html; charset=utf-8'
    end

    scenario "#body" do
      expect(response.body.include? '{:object=&gt;&quot;object content&quot;}')
        .to be true
    end
  end

  context "#json" do
    before { get '/objects.json' }
    scenario "#status" do
      expect(response.status).to eql 200
    end

    scenario "#content-type" do
      expect(response.header['Content-Type'])
        .to eql 'application/json; charset=utf-8'
    end

    scenario "#body" do
      expect(response.body.include? '{"object":"object content"}')
        .to be true
    end
  end

  context "#xml" do
    before { get '/objects.xml' }
    scenario "#status" do
      expect(response.status).to eql 200
    end

    scenario "#content-type" do
      expect(response.header['Content-Type'])
        .to eql 'application/xml; charset=utf-8'
    end

    scenario "#body" do
      expect(response.body.include? '<object>object content</object>')
        .to be true
    end
  end

  context "#js" do
    before { get '/objects.js' }
    scenario "#status" do
      expect(response.status).to eql 200
    end

    scenario "#content-type" do
      expect(response.header['Content-Type'])
        .to eql 'text/javascript; charset=utf-8'
    end

    scenario "#body" do
      expect(response.body.include? "alert('{:object=&gt;&quot;object")
        .to be true
    end
  end
end
