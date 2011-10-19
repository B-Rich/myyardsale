all : index.html sold.html

index.html : index.md header.html footer.html
	cat header.html > index.html
	markdown index.md >> index.html
	cat footer.html >> index.html
	sed -i s/WWWWWW/`grep '^####.*####' index.md | wc -l`/ index.html
	sed -i s/YYYYYY/"`date`"/ index.html
	sed -i s/XXXXXX/`git rev-parse HEAD`/ index.html

sold.html : sold.md header.html footer.html
	cat header.html > sold.html
	markdown sold.md >> sold.html
	cat footer.html >> sold.html

clean:
	-rm index.html sold.html

upload: index.html sold.html
	rsync -vrt index.html sold.html images kudu:websites/haenel.co/yardsale/
	ssh kudu 'chmod a+rX -vR websites/haenel.co/yardsale/'
