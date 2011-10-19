index.html : content.html header.html footer.html
	cat header.html > index.html
	cat content.html >> index.html
	cat footer.html >> index.html
	sed -i s/YYYYYY/"`date`"/ index.html
	sed -i s/XXXXXX/`git rev-parse HEAD`/ index.html

content.html : content.md
	markdown content.md > content.html

sold.html : sold.md
	cat header.html > sold.html
	markdown sold.md >> sold.html
	cat footer.html >> sold.html

clean:
	-rm index.html content.html

upload: content.html index.html sold.html
	rsync -vrt index.html sold.html images kudu:websites/haenel.co/yardsale/
	ssh kudu 'chmod a+rX -vR websites/haenel.co/yardsale/'
