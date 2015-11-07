module Api
  class SentencesController < ApiController
    def random
      @sentence = Sentence.all.to_a[rand(Sentence.all.size).to_i]
      render json: @sentence
    end

    def diff
      @sentence = Sentence.where(id: params[:sentence_id].to_i).last
      render json: {rate: @sentence.diff(params[:string])}
    end
  end
end