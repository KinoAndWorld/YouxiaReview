# -*- coding: utf-8 -*-
import scrapy

from yxReview.items import ArticleItem

class YxReviewSpider(scrapy.Spider):
    name = "yx_review"
    allowed_domains = ["www.ali213.net"]
    start_urls = (
        'http://www.ali213.net/news/pingce/',
    )

    def parse(self, response):
        items = []
        for sel in response.xpath('//div[@class="t3_l_one_l"]'):
            item = ArticleItem()
            item["cover_image"] = sel.xpath("div[@class='one_l_pic']/a/img/@src").extract()
            item["title"] =   sel.xpath("div[@class='one_l_con']/div[@class='one_l_con_tit']/a/text()").extract()
            item["summary"] = sel.xpath("div[@class='one_l_con']/div[@class='one_l_con_con']/text()").extract()
            items.append(item)

        index = 0
        for scoreSel in response.xpath('//div[@class = "t3_l_one_r"]'):
            item = items[index]
            item["score"] = scoreSel.xpath("div/span/text()").extract()
            index = index + 1
            yield item

        # print items
