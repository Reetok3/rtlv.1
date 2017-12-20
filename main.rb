require "byebug"
class Rtl
	# 変数宣言
	def initialize(src)
		# ソースを入れた変数
		@src = src
		# ソースを一文字ずつ小分けにして入れた配列
		@p = src.split("").push("\n")
		# 今プログラムの何文字めかを記録する
		@i = 1
		# 今プログラムの何行めかを記録する．
		@l = 1
		# 変数がハッシュとして入る
		@var = {}
		# ファイル名
		if ARGF.filename == "-"
			@name = "パイプ指定"
		else
			@name = ARGF.filename
		end
	end
	# 実行スクリプト
	def run
	# debug用
		p @p
		# ファイル終端（配列の空要素）にたどり着くまで...
		while true
			byebug
			if char("print") == 0 then # printだったら...
				# p @p
				# 5も自分p,r,i,n,tを飛ばす
				n(5)
				# p @p
				# スペースがあったら飛ばす
				skip_space
				# p @p
				# p why_print
				puts getValue(why_print)
			elsif @p.size == []
				exit
			elsif @p[0] == "\n" then # 改行だったら...読み飛ばす
				n(1)
			elsif char(" ") == 0 then # 空文字だったら...読み飛ばす
				n(1)
			elsif char("//") == 0 then # 1行コメントだったら...\nまで読み飛ばす
				why_kaigyo
			elsif char("/*") == 0 then # 複数行コメントだったら...*/まで読み飛ばす
				why("*/")
			else # それ以外だったら...変数とみなしてみる
				if @p[1] == "=" || @p[2] == "="  then
					name = why("=").delete(" ")
					n(1)
					skip_space
					var = why_print
					@var[name] = getValue(var)
				else
					# エラーを表示
					error("文法エラー\"#{@p[0]}\"")
				end
			end
		end

	end

	# private

	def arg(a)
		c = a.split("")
		# p c
		if c[0] == " "
			c.delete_at(0)
		end
		# p c
		i=0
		while c.size != i
			if c[i] == "(" || c[i] == ")" || c[i] == " "
				c.delete_at(i)
			end
			i+=1
		end
		return c
	end

	# \nが来るか//が来るか/*が来るまでスキップ
	def why_print
		# 進めた文字を入れる
		r = ""
		# 来るまで...
		while @p[0] != "\n" && char("//") == 1 && char("/*") == 1
			# カウンター
			i = 0
			r = r + @p[0]
			# p @p[0]

			n(1)
			if @p == [""]
				error("期待していた文字\"\\n\"か\"//\"か\"\*\"が最後まで見つかりませんでした．")
			end
			i+=1
		end
		n(1)
		r = r + @p[0]
		# p @p[0]
		return r
	end
	# 渡された引数が変数か文字列かを判断して，変数の場合は変数の値として，文字列だったらそのまま返す
	def getValue(c)
		if @var[c] != nil
			return @var[c]
		elsif c.split("")[0] == "r" && c.split("")[1] == "a" && c.split("")[2] == "n" && c.split("")[3] == "d" && c.split("")[4] == "o" && c.split("")[5] == "m"
			n(6)
			cr = arg(c.delete("random")).join.delete("\n").split(",")
			p cr
			if cr.size == 2
				if cr[0] < cr[1]
					srand(Time.now.to_i)
					return Random.rand(cr[0].to_i...cr[1].to_i)
				elsif cr[0] > cr[1]
					srand(Time.now.to_i)
					return Random.rand(cr[1].to_i...cr[0].to_i)
				end
			rand(1..6)
			elsif cr.size == 1
				p cr[0]
				srand(Time.now.to_i)
				return Random.rand(cr[0].to_i...33554432)

			elsif cr.size == 0
				srand(Time.now.to_i)
				return Random.rand(-33554432...33554432)
			end
		else
			return c.delete("\"")
		end
	end

	# スペースがあった場合スキップする
	def skip_space
		while char(" ") == 0 do
		# もしスペースだったら？
		if char(" ") == 0
			# 読み飛ばす
			n(1)
		end
		end
	end
	# 改行まで進めて進めた文字を返す
	def why_kaigyo
		r = ""
		while @p[0] != "\n"
			i = 0
			r << @p[0]
			n(1)
			if @p == [""]
				error("期待して居た文字列\"\\n\"が最後まで見つかりませんでした．")
			end
			i+=1
		end
		return r
	end
	# 期待している複数のの文字まで進め，進めた文字を返す
	def why(c)
		# 進めた文字を入れる
		r = ""
		# 期待している文字が来るまで...
		while char(c) == 1
			# カウンター
			i = 0
			# 期待している文字が来なかったということなので，飛ばす文字をrに追加して，読み飛ばす．
			# while i != c.split("").size
			r << @p[0]
			n(1)
			# end
			# もしファイル終端になってしまったら...
			if p == [""]
				# エラー
				error("期待していた文字列\"#{c}\"が最後まで見つかりませんでした．")
			end
			# カウンターを1増やす
			i+=1
		end
		# 進めた文字を返す
		return r
	end
	# n文字進める
	def n(fn)
		# 配列の一番最初の文字を削除することで次の文字に回す
		i = 0
		# n回繰り返す（n回飛ばす動作を繰り返す）
		while i != fn
			if @p[0] == "\n"
				@l += 1
				@i=0
			end
			# 最初の一番目を削除
			@p.delete_at(0)
			@i+=1
			# かうんたーを1増やす
			i+=1
		end
		# 次の文字に進んだことを記録する
		@i += fn
	end
	# 期待している文字列があったら，1を返す char("aiu")の場合は，p[0]=="a"&&p[1]=="i"&&p[2]="u"かどうかを確認するということになる
	def char(c)
		# カウンター
		i = 0
		# 期待している文字列cを一文字ずつ小分けにして配列に
		cb = c.split("")
		# cの文字数回繰り返す
		while cb.size != i do
			# 期待している文字があるかどうか一文字ずつチェックする
			if cb[i] != @p[i] then
				# 1を返す
				return 1
			end
			# カウンターを1増やす
			i+=1
		end
		# 0を返す
		return 0
	end
	# エラーを出す
	def error(e)
		# エラーを出力
		puts "#{ARGF.filename}:エラーが起きました:#{@l}列目:#{@i}文字目:#{e}\n"
		# 終了
		exit
	end
end
# Rtlを作成 & コードを動かす！
Rtl.new(ARGF.read).run
